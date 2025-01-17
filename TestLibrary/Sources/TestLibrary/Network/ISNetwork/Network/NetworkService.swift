// Copyright © 2021 Minor. All rights reserved.

import Foundation
import Alamofire
import KeychainAccess
import UIKit

public protocol Request: Encodable & Sendable {}

public protocol NetworkServiceProtocol {
    func execute<T:  DataModel & Sendable>(
        urlRequest: NetworkURLRequest,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    )
    
    func executeWithParams<T: DataModel & Sendable, U: Request>(
        urlRequest: NetworkURLRequest,
        request: U?,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    )
    
    func executeForOAuth<T: DataModel & Sendable>(
        urlRequest: NetworkURLRequest,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    )
    
    func executeForOAuthWithParams<T: DataModel & Sendable, U: Request>(
        urlRequest: NetworkURLRequest,
        request: U?,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    )
    
    func executeForOAuthFileUpload<T: DataModel & Sendable>(
        fileData: Data,
        fileName: String,
        isPdf: Bool,
        urlRequest: NetworkURLRequest,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    )
}

public final class NetworkService: NetworkServiceProtocol {
    public init() {}
    
    public func execute<T: DataModel & Sendable>(
        urlRequest: NetworkURLRequest,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    ) {
        AF.request(urlRequest.requestURL,
                   method: urlRequest.method,
                   headers: urlRequest.header,
                   requestModifier: { $0.timeoutInterval = 60 }
        )
        .validate(statusCode: [200..<300, 400..<405].joined())
        .responseDecodable(of: T.self) { response in
            debugPrint("Request: ", response)
            switch response.result {
            case .success(let res):
                let statusCode = response.response?.statusCode ?? 400
                if (statusCode >= 200 && statusCode < 300) {
                    completion(.success(res))
                } else {
                    let errorMessage = res.message ?? ""
                    completion(.failure(NetworkError(message: errorMessage, statusCode: statusCode)))
                }
            case .failure(let error):
                debugPrint(error)
                completion(.failure(self.handleError(statusCode: response.response?.statusCode ?? 400, error: error)))
            }
        }
    }

    public func executeWithParams<T: DataModel & Sendable, U: Request>(
        urlRequest: NetworkURLRequest,
        request: U?,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    ) {
        AF.request(urlRequest.requestURL,
                   method: urlRequest.method,
                   parameters: request,
                   encoder: urlRequest.encoder,
                   headers: urlRequest.header,
                   requestModifier: { $0.timeoutInterval = 60 }
        )
        .validate(statusCode: [200..<300, 400..<405].joined())
        .responseDecodable(of: T.self) { response in
            debugPrint("Request: ", response)
            switch response.result {
            case .success(let res):
                let statusCode = response.response?.statusCode ?? 400
                if (statusCode >= 200 && statusCode < 300) {
                    completion(.success(res))
                } else {
                    let errorMessage = res.message ?? ""
                    completion(.failure(NetworkError(message: errorMessage, statusCode: statusCode)))
                }
            case .failure(let error):
                debugPrint(error)
                completion(.failure(self.handleError(statusCode: response.response?.statusCode ?? 400, error: error)))
            }
        }
    }
    
    public func executeForOAuth<T: DataModel & Sendable>(
        urlRequest: NetworkURLRequest,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    ) {
        AF.request(urlRequest.requestURL,
                   method: urlRequest.method,
                   headers: urlRequest.header,
                   interceptor: self,
                   requestModifier: { $0.timeoutInterval = 60 }
        )
        .validate(statusCode: [200..<401, 402..<404].joined())
        .responseDecodable(of: T.self) { response in
            debugPrint("Request: ", response)
            switch response.result {
            case .success(let res):
                let statusCode = response.response?.statusCode ?? 400
                if (statusCode >= 200 && statusCode < 300) {
                    completion(.success(res))
                } else {
                    let errorMessage = res.message ?? ""
                    completion(.failure(NetworkError(message: errorMessage, statusCode: statusCode)))
                }
            case .failure(let error):
                debugPrint(error)
                completion(.failure(self.handleError(statusCode: response.response?.statusCode ?? 400, error: error)))
            }
        }
    }
    
    public func executeForOAuthWithParams<T: DataModel & Sendable, U: Request>(
        urlRequest: NetworkURLRequest,
        request: U?,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    ) {
        AF.request(urlRequest.requestURL,
                   method: urlRequest.method,
                   parameters: request,
                   encoder: urlRequest.encoder,
                   headers: urlRequest.header,
                   interceptor: self,
                   requestModifier: { $0.timeoutInterval = 60 }
        )
        .validate(statusCode: [200..<401].joined())
        .responseDecodable(of: T.self) { response in
            debugPrint("Request: ", response)
            switch response.result {
            case .success(let res):
                let statusCode = response.response?.statusCode ?? 400
                if (statusCode >= 200 && statusCode < 300) {
                    completion(.success(res))
                } else {
                    let errorMessage = res.message ?? ""
                    completion(.failure(NetworkError(message: errorMessage, statusCode: statusCode)))
                }
            case .failure(let error):
                debugPrint(error)
                completion(.failure(self.handleError(statusCode: response.response?.statusCode ?? 400, error: error)))
            }
        }
    }
    
    public func executeForOAuthFileUpload<T: DataModel & Sendable>(
        fileData: Data,
        fileName: String,
        isPdf: Bool,
        urlRequest: NetworkURLRequest,
        model: T.Type,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    ) {
        do {
            guard let url = URL(string: urlRequest.requestURL) else { return }
            let request = try URLRequest(url: url, method: urlRequest.method, headers: urlRequest.header)
            
            let urlRequestConvertible: Alamofire.URLRequestConvertible = request
            
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(fileData, withName: "document", fileName: fileName, mimeType: isPdf ? "application/pdf" : "image/png")
                },
                with: urlRequestConvertible,
                interceptor: self
            )
            .validate(statusCode: [200..<401].joined())
            .responseDecodable(of: T.self) { response in
                debugPrint("Request: ", response)
                switch response.result {
                case .success(let res):
                    let statusCode = response.response?.statusCode ?? 400
                    if (statusCode >= 200 && statusCode < 300) {
                        completion(.success(res))
                    } else {
                        let errorMessage = res.message ?? ""
                        completion(.failure(NetworkError(message: errorMessage, statusCode: statusCode)))
                    }
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(self.handleError(statusCode: response.response?.statusCode ?? 400, error: error)))
                }
            }
            
        } catch let error {
            print("Upload error: ", error.localizedDescription)
        }
    }
    
    private func handleError(statusCode: Int, error: AFError) -> NetworkError {
        if !(NetworkReachabilityManager()?.isReachable ?? true) {
            return NetworkError(message: "Your internet connection seems to be offline. Please try again.", statusCode: statusCode)
        }
        switch statusCode {
        case 400, 401: return NetworkError(message: error.localizedDescription, statusCode: statusCode)
        default: return NetworkError(message: "Something went wrong. Please try again.", statusCode: statusCode)
        }
    }
}

extension NetworkService: @preconcurrency RequestAdapter, @preconcurrency RequestRetrier, RequestInterceptor {
    @MainActor public func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping @Sendable (Alamofire.RetryResult) -> Void) {
        if let error = error.asAFError, (error.responseCode ?? 400) == 401 {
            Task { @MainActor in
                getRefreshToken { isSuccess in
                    if isSuccess {
                        completion(.retry)
                    } else {
    //                    NotificationCenter.default.post(name: NSNotification.Name("sessionExpired"), object: nil)
                        completion(.doNotRetry)
                    }
                }
            }
            
        } else {
            completion(.doNotRetry)
        }
    }
    
    @MainActor public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: KeychainHelper.getString(for: .accessToken)))
        completion(.success(urlRequest))
    }
    
    @MainActor private func getRefreshToken(completion: @escaping @Sendable (Bool) -> Void) {
        let service = NetworkService()

        var accessToken = ""
        var refreshToken = ""
        
        let refreshTokenRequest = RefreshTokenParams(
            access_token: KeychainHelper.getString(for: .accessToken),
            refresh_token: KeychainHelper.getString(for: .refreshToken)
        )
        
        service.executeWithParams(urlRequest: LoginRouter.refreshToken, request: refreshTokenRequest, model: RefreshTokenResponse.self) { result in
            // Ensure the closure that calls completion is marked as @Sendable
            Task { @MainActor in
                switch result {
                case .success(let data):
                    debugPrint("Token is refreshed.")
                    accessToken = data.data?.token.value ?? ""
                    refreshToken = data.data?.refreshToken ?? ""
                    KeychainHelper.setString(value: accessToken, for: .accessToken)
                    KeychainHelper.setString(value: refreshToken, for: .refreshToken)
                    completion(true)
                    
                case .failure(let error):
                    debugPrint("Token refresh Error: ", error.localizedDescription)
                    accessToken = ""
                    refreshToken = ""
                    KeychainHelper.setString(value: accessToken, for: .accessToken)
                    KeychainHelper.setString(value: refreshToken, for: .refreshToken)
                    completion(false)
                }
            }
        }
    }
}

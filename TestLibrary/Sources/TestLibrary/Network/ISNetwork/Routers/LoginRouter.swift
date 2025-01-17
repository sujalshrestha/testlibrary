//
//  LoginRouter.swift
//  iSend
//
//  Created by Sujal Shrestha on 01/04/2023.
//

import Alamofire

public enum LoginRouter {
    case login
    case register
    case customerDetails
    case updatePhone(String)
    case verifyOtp(String)
    case resendOtp
    case forgotPassword
    case resetPassword
    case refreshToken
}

extension LoginRouter: NetworkURLRequest {
    public var baseURL: String {
        switch self {
        default: return ApiConstants.baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .login: return ApiConstants.login
        case .register: return ApiConstants.register
        case .customerDetails: return ApiConstants.customerDetails
        case .updatePhone(let phone): return ApiConstants.updatePhone(phone: phone)
        case .verifyOtp(let code): return ApiConstants.verifyOtp(code: code)
        case .resendOtp: return ApiConstants.resendOtp
        case .forgotPassword: return ApiConstants.forgotPassword
        case .resetPassword: return ApiConstants.resetPassword
        case .refreshToken: return ApiConstants.refreshToken
        }
    }
    
    public var requestURL: String {
        switch self {
        default: return baseURL + path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .customerDetails: return .get
        default: return .post
        }
    }
    
    public var header: HTTPHeaders {
        switch self {
        default: return [
            "Content-Type": "application/json",
            "source": ApiConstants.source,
            "client_id": ApiConstants.clientId,
            "version": ApiConstants.version,
            "device_info": ApiConstants.getVendorId()
        ]
        }
    }
    
    public var encoder: ParameterEncoder {
        if method == .get {
            return URLEncodedFormParameterEncoder.default
        } else {
            return JSONParameterEncoder.default
        }
    }
}

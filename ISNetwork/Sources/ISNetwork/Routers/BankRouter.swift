//
//  File.swift
//  
//
//  Created by Sujal Shrestha on 15/05/2023.
//

import Alamofire

public enum BankRouter {
    case getConnectUrl
    case refreshBank
    case bankList
    case getConnectURLMicroDeposit(String)
}

extension BankRouter: ISNetwork.NetworkURLRequest {
    public var baseURL: String {
        switch self {
        default: return ApiConstants.baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .getConnectUrl: return ApiConstants.bankConnectUrl
        case .refreshBank: return ApiConstants.refreshBank
        case .bankList: return ApiConstants.bankList
        case .getConnectURLMicroDeposit(let accountId): return ApiConstants.verifyMircoDeposit(accountId: accountId)
        }
    }
    
    public var requestURL: String {
        switch self {
        default: return baseURL + path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .bankList, .getConnectURLMicroDeposit: return .get
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

//
//  File.swift
//  
//
//  Created by Sujal Shrestha on 12/04/2023.
//

import Alamofire

public enum TransactionRouter {
    case transactionList
    case transactionStatus
    case transactionDetail(String)
    case cancelTransaction(String)
    case cancellationReason
    case confirmCancelTransaction
}

extension TransactionRouter: NetworkURLRequest {
    public var baseURL: String {
        switch self {
        default: return ApiConstants.baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .transactionList: return ApiConstants.transactionList
        case .transactionStatus: return ApiConstants.transactionStatus
        case .transactionDetail(let id): return ApiConstants.transactionDetail(transactionId: id)
        case .cancelTransaction(let id): return ApiConstants.cancelTransaction(transactionId: id)
        case .cancellationReason: return ApiConstants.cancellationReason
        case .confirmCancelTransaction: return ApiConstants.confirmCancelTransaction
        }
    }
    
    public var requestURL: String {
        switch self {
        default: return baseURL + path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .confirmCancelTransaction: return .post
        default: return .get
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

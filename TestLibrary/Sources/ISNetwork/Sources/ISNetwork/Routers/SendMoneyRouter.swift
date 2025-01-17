//
//  File.swift
//  
//
//  Created by Sujal Shrestha on 26/04/2023.
//

import Alamofire

public enum SendMoneyRouter {
    case beneficiaryDetail
    case calculateTransaction
    case paymentMethod
    case purposeOfRemittance
    case transactionSend
    case transactionConfirm(String)
    case documentUpload(String)
    case generateOTP
    case verifyOTP
    case regenerateOTP
}

extension SendMoneyRouter: ISNetwork.NetworkURLRequest {
    public var baseURL: String {
        switch self {
        default: return ApiConstants.baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .beneficiaryDetail: return ApiConstants.beneficiaryDetail
        case .calculateTransaction: return ApiConstants.calculateTransaction
        case .paymentMethod: return ApiConstants.paymentMethod
        case .purposeOfRemittance: return ApiConstants.purposeOfRemittance
        case .transactionSend: return ApiConstants.transactionSend
        case .transactionConfirm(let id): return ApiConstants.transactionConfirm(transactionId: id)
        case .documentUpload(let id): return ApiConstants.documentUpload(transactionId: id)
        case .generateOTP: return ApiConstants.generateOTP
        case .verifyOTP: return ApiConstants.verifyTransactionOTP
        case .regenerateOTP: return ApiConstants.regenerateTransactionOTP
        }
    }
    
    public var requestURL: String {
        switch self {
        default: return baseURL + path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .calculateTransaction, .transactionSend, .transactionConfirm, .documentUpload, .generateOTP, .verifyOTP, .regenerateOTP: return .post
        default: return .get
        }
    }
    
    public var header: HTTPHeaders {
        switch self {
        case .documentUpload: return [
            "Content-Type": "multipart/form-data",
            "source": ApiConstants.source,
            "client_id": ApiConstants.clientId,
            "version": ApiConstants.version,
            "device_info": ApiConstants.getVendorId()
        ]
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

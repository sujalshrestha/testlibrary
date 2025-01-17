//
//  File.swift
//  
//
//  Created by Sujal Shrestha on 21/04/2023.
//

import Alamofire

public enum CheckRatesRouter {
    case countries
    case deliveryOption
    case calculate
}

extension CheckRatesRouter: NetworkURLRequest {
    public var baseURL: String {
        switch self {
        default: return ApiConstants.baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .countries: return ApiConstants.checkRateCountry
        case .deliveryOption: return ApiConstants.checkRateDeliveryOption
        case .calculate: return ApiConstants.checkRateCalculate
        }
    }
    
    public var requestURL: String {
        switch self {
        default: return baseURL + path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .calculate: return .post
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

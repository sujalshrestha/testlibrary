//
//  File.swift
//  
//
//  Created by Sujal Shrestha on 12/04/2023.
//

import Alamofire

public enum BeneficiaryRouter {
    case beneficiaryList
    case relation
    case paymentType
    case payoutLocation
    case branchName
    case addBeneficiary
    case editBeneficiary
    case beneficiaryCountry
    case fieldDetails
}

extension BeneficiaryRouter: NetworkURLRequest {
    public var baseURL: String {
        switch self {
        default: return ApiConstants.baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .beneficiaryList: return ApiConstants.beneficiaryList
        case .relation: return ApiConstants.relation
        case .paymentType: return ApiConstants.paymentType
        case .payoutLocation: return ApiConstants.payoutLocation
        case .branchName: return ApiConstants.beneficiaryBranchName
        case .addBeneficiary: return ApiConstants.addBeneficiary
        case .editBeneficiary: return ApiConstants.editBeneficiary
        case .beneficiaryCountry: return ApiConstants.beneficiaryCountry
        case .fieldDetails: return ApiConstants.fieldDetails
        }
    }
    
    public var requestURL: String {
        switch self {
        default: return baseURL + path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .addBeneficiary: return .post
        case .editBeneficiary: return .put
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

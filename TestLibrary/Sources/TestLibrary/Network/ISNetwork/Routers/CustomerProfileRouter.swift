//
//  File.swift
//  
//
//  Created by Sujal Shrestha on 06/04/2023.
//

import Alamofire

public enum CustomerProfileRouter {
    case sendingCountry
    case allCountry
    case occupation
    case sourceOfIncome
    case gender
    case states(String)
    case streetType(String)
    case customerRegister
    case getDetails
    case getOnfidoToken
    case checkEYCStatus
    case resendEmail
    case logout
    case updateCustomer
    case changePassword
    case notification
    case addressValidationRules(String)
    case pauseKycAlert
    case checkKycStatus
    case documentType
    case delete
    case reasonForDelete
    case profile
    case profilePicture
    case referralCode
    case referHistory
    case promoCode
    case validatePromoCode
    case apiConfig
}

extension CustomerProfileRouter: NetworkURLRequest {
    public var baseURL: String {
        switch self {
        default: return ApiConstants.baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .sendingCountry: return ApiConstants.sendingCountryList
        case .allCountry: return ApiConstants.allCountryList
        case .occupation: return ApiConstants.occupationList
        case .sourceOfIncome: return ApiConstants.sourceOfIncomeList
        case .gender: return ApiConstants.gender
        case .states(let country): return ApiConstants.states(country: country)
        case .streetType(let country): return ApiConstants.streetType(country: country)
        case .customerRegister: return ApiConstants.customerRegister
        case .getDetails: return ApiConstants.customerDetails
        case .getOnfidoToken: return ApiConstants.getOnfidoToken
        case .checkEYCStatus: return ApiConstants.getEYCStatus
        case .resendEmail: return ApiConstants.resendEmail
        case .logout: return ApiConstants.logout
        case .updateCustomer: return ApiConstants.updateCustomer
        case .changePassword: return ApiConstants.changePassword
        case .notification: return ApiConstants.notification
        case .addressValidationRules(let code): return ApiConstants.addressValidationRules(countryCode: code)
        case .pauseKycAlert: return ApiConstants.pauseKycAlert
        case .checkKycStatus: return ApiConstants.checkKycStatus
        case .documentType: return ApiConstants.documentType
        case .delete: return ApiConstants.delete
        case .reasonForDelete: return ApiConstants.reasonForDelete
        case .profile: return ApiConstants.profile
        case .profilePicture: return ApiConstants.profilePicture
        case .referralCode: return ApiConstants.referralCode
        case .referHistory: return ApiConstants.referHistory
        case .promoCode: return ApiConstants.promoCodeList
        case .validatePromoCode: return ApiConstants.validatePromoCode
        case .apiConfig: return ApiConstants.apiConfig
        }
    }
    
    public var requestURL: String {
        switch self {
        default: return baseURL + path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .customerRegister, .resendEmail, .logout, .changePassword, .pauseKycAlert: return .post
        case .updateCustomer: return .put
        case .delete, .profilePicture, .validatePromoCode: return .post
        default: return .get
        }
    }
    
    public var header: HTTPHeaders {
        switch self {
        case .profilePicture: return [
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
            switch self {
//            case .promoCode:
//                return CustomURLEncoder.default
            default:
                return URLEncodedFormParameterEncoder.default
            }
        } else {
            return JSONParameterEncoder.default
        }
    }
}

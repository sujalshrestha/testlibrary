// Copyright © 2021 Minor. All rights reserved.

import Foundation
import UIKit

public enum ApiConstants {
    /// The base URL for all endpoints, it changes based on the environment.
    static var baseUrl = (environment == .production) ? Self.productionUrl : Self.developmentUrl
    
    public static var productionUrl = "https://userapi.isendremit.com/api/" // "https://userapi.isendglobal.com/api/"
    public static var developmentUrl = "https://devusa.isendglobal.com/api/" // "https://devapi.isend.com.sg/api/"
    
    public static func updateBaseURL() {
        ApiConstants.baseUrl = (environment == .production) ? Self.productionUrl : Self.developmentUrl
    }
    
//    static let clientId = "?FTm[1XbY2qHbZ[N[@1eaNHJP01P{(?(LK2MS+[D*3pPVBh9!oDR?gyC[nwNGEu-"
//    static let version = "v2"
    static let clientId = "3i=ik;Z8)#(4$gxNc?Z.!C*;BKra{T}Ji+a]KadGp}D7?mC?4:nngXREmEh+8+Cm"
    static let version = "v1"
    static let source = "ios"
    
    static func getVendorId() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    static let login = "account/login"
    static let register = "account/register"
    
    // Customer
    static let customerDetails = "customer/getdetails"
    static let getOnfidoToken = "kyc/verifyekyc"
    static let getEYCStatus = "customer/checkekyc"
    static let resendEmail = "account/resendlink"
    static let updateCustomer = "customer/update"
    static let changePassword = "account/changepassword"
    static let pauseKycAlert = "customer/pausekycalert"
    static let checkKycStatus = "kyc/checkekycstatus"
    static let logout = "account/logout"
    static let reasonForDelete = "common/referencedata?typeId=102"
    static let profile = "customer/profile"
    static let profilePicture = "customer/profile_picture"
    static let referralCode = "customer/referral_code"
    static let referHistory = "customer/referred_history"
    static let promoCodeList = "campaign/promocodes"
    static let validatePromoCode = "campaign/validatepromocode"
    static let apiConfig = "config"
    
    static func addressValidationRules(countryCode: String) -> String {
        return "common/\(countryCode)/countryvalidationrules"
    }
    
    static func updatePhone(phone: String) -> String {
        return "account/updatePhoneNumber/\(phone)"
    }
    
    static func verifyOtp(code: String) -> String {
        return "account/\(code)/confirmphone"
    }
    
    static let resendOtp = "account/resendotp"
    
    static let refreshToken = "account/refreshtoken"
    
    //Customer Profile
    static let sendingCountryList = "common/sending_countrylist"
    static let allCountryList = "common/countrylist"
    static let occupationList = "common/referencedata?typeId=17"
    static let sourceOfIncomeList = "common/referencedata?typeId=6"
    static let documentType = "customer/document/acceptancelist"
    static let delete = "customer/delete"
    static let gender = "common/referencedata?typeId=42"
    
    static func states(country: String) -> String {
        return "common/\(country)/states"
    }
    
    static let customerRegister = "customer/register"
    
    static func streetType(country: String) -> String {
        return "common/\(country)/street_type"
    }
    
    static let forgotPassword = "account/forgotpassword"
    static let resetPassword = "account/resetpassword"
    
    // Banner
    static let banner = "banner"
    
    // Transaction
    static let transactionList = "transaction/list"
    static let transactionStatus = "common/referencedata?typeId=66"
    
    // Beneficiary
    static let beneficiaryList = "beneficiary/getallbycustomerid"
    static let relation = "common/referencedata?typeId=18"
    static let paymentType = "getdeliveryoption/countrywise"
    static let payoutLocation = "payoutlocation/countrywise"
    static let beneficiaryBranchName = "common/referencedata?typeId=40"
    static let addBeneficiary = "beneficiary/register"
    static let editBeneficiary = "beneficiary/update"
    static let beneficiaryCountry = "common/payout_countrylist"
    static let fieldDetails = "common/getFieldDetails"
    
    // Check rates
    static let checkRateCountry = "exchangerate/allcountrywise"
    static let checkRateDeliveryOption = "getdeliveryoption/countrywise"
    static let checkRateCalculate = "transaction/checkCalculate"
    
    // Notifications
    static let notification = "notification"
    
    // Send money
    static let beneficiaryDetail = "beneficiary/getdetails"
    static let calculateTransaction = "transaction/calculate"
    static let paymentMethod = "customer/payment"
    static let purposeOfRemittance = "common/referencedata?typeId=7"
    static let transactionSend = "transaction/send"
    static let generateOTP = "account/generateotp"
    static let verifyTransactionOTP = "account/verifyotp"
    static let regenerateTransactionOTP = "account/regenerateotp"
    
    static func transactionConfirm(transactionId: String) -> String {
        return "transaction/confirm?transaction_id=\(transactionId)"
    }
    
    static func transactionDetail(transactionId: String) -> String {
        return "transaction/details?transaction_id=\(transactionId)"
    }
    
    static func cancelTransaction(transactionId: String) -> String {
        return "transaction/cancel?transaction_id=\(transactionId)"
    }
    
    static func documentUpload(transactionId: String) -> String {
        return "transaction/docupload?transaction_id=\(transactionId)"
    }
    
    static let cancellationReason = "common/referencedata?typeId=8"
    static let confirmCancelTransaction = "transaction/confirmcancel"
    
    // Bank
    static let bankConnectUrl = "customer/addbank"
    static let refreshBank = "customer/refreshbank"
    static let bankList = "customer/bank"
    
    static func verifyMircoDeposit(accountId: String) -> String {
        return "customer/microdeposit/verify/\(accountId)"
    }
}

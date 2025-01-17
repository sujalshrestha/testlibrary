//
//  File.swift
//  
//
//  Created by Sujal Shrestha on 03/04/2023.
//

import Foundation

struct RefreshTokenParams: ISNetwork.Request {
    let access_token: String
    let refresh_token: String
}

struct RefreshTokenResponse: DataModel {
    var code: Int?
    var message: String?
    let data: RefreshTokenDataResponse?
}

struct RefreshTokenDataResponse: DataModel {
    var code: Int?
    var message: String?
    let token: RefreshTokenAccessTokenResponse
    let refreshToken: String
    let token_type: String
    let regcomplete: Bool
    let emailverified: Bool
    let phoneverified: Bool
    let country: String
    let phoneNumber: String?
    let phoneExtention: String?
    let countryIso2: String?
    let phnRejex: String?
}

struct RefreshTokenAccessTokenResponse: DataModel {
    var code: Int?
    var message: String?
    let validTo: String
    let value: String
}

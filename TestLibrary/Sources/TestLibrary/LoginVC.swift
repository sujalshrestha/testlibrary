//
//  LoginVC.swift
//  TestLibrary
//
//  Created by Sujal on 17/01/2025.
//

import UIKit
internal import ISNetwork
import Combine

class LoginVC: UIViewController {
    
    let vm = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        vm.postLoginApi(email: "bvk@yopmail.com", password: "Test@123")
    }
}

public class LoginViewModel {
    var cancellable = [AnyCancellable]()
    let service = NetworkService()
    
    let isLoading = CurrentValueSubject<Bool?, Never>(nil)
    let onApiError = CurrentValueSubject<String?, Never>(nil)
    
    let loginDataResponse = CurrentValueSubject<LoginDataResponse?, Never>(nil)
    
    func postLoginApi(email: String, password: String) {
        isLoading.send(true)
        let loginRequest = LoginParams(password: password, userId: email, fcmId: "asdasdasd", rememberMe: true)
        
        service.executeWithParams(urlRequest: LoginRouter.login, request: loginRequest, model: LoginResponse.self) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.send(false)
            switch result {
            case .success(let data):
                print(data)

            case .failure(let error):
                self.onApiError.send(error.message ?? "")
            }
        }
    }
}

struct LoginParams: Request {
    let password: String
    let userId: String
    let fcmId: String
    let rememberMe: Bool
    
    enum CodingKeys: String, CodingKey {
        case password
        case userId = "user_id"
        case fcmId = "fcm_id"
        case rememberMe = "remember_me"
    }
}

struct LoginResponse: DataModel {
    var code: Int?
    var message: String?
    let data: GenericData?
}

struct GenericData: Codable {
    let dataResponse: LoginDataResponse?
    let dataString: String

    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()

        do {
            dataResponse = try container.decode(LoginDataResponse.self)
            dataString = ""
        } catch {
            dataString = try container.decode(String.self)
            dataResponse = nil
        }
    }
}

struct LoginDataResponse: DataModel {
    var code: Int?
    var message: String?
    let token: LoginTokenResponse?
    let refreshToken: String?
    let token_type: String?
    let regcomplete: Bool?
    let emailverified: Bool?
    let phoneverified: Bool?
    let country: String?
    let phoneNumber: String?
    let phoneExtention: String?
    let countryIso2: String?
    let phnRejex: String?
}

struct LoginTokenResponse: DataModel {
    var code: Int?
    var message: String?
    let validTo: String?
    let value: String?
}


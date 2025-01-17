//
//  LoginManager.swift
//  TestLibrary
//
//  Created by Sujal on 17/01/2025.
//

import UIKit

public class LoginManager {
    public static let shared = LoginManager()

    // Private initializer to enforce singleton usage
    private init() {}

    // Method to present the LoginViewController
    public func presentLogin(from viewController: UIViewController, completion: (() -> Void)? = nil) {
        let loginVC = LoginVC()
        viewController.present(loginVC, animated: true, completion: completion)
    }
}

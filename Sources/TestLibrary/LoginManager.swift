//
//  LoginManager.swift
//  TestLibrary
//
//  Created by Sujal on 17/01/2025.
//

import UIKit

public actor LoginManager {
    public static let shared = LoginManager()

    // Private initializer to enforce singleton usage
    private init() {}

    // Method to present the LoginViewController
    @MainActor
    public func presentLogin(from viewController: UIViewController) {
        let loginVC = LoginVC()
        viewController.present(loginVC, animated: true, completion: nil)
    }
}

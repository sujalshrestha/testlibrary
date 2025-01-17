// Copyright © 2021 Minor. All rights reserved.

import Foundation
import KeychainAccess

public enum KeychainKeys: String, CaseIterable {
    case accessToken
    case password
    case userId
    case refreshToken
}

public struct KeychainHelper {
    public static let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "com.isend")
    
    public static func setString(value: String, for key: KeychainKeys) {
        keychain[key.rawValue] = value
    }
    
    public static func getString(for key: KeychainKeys) -> String {
        return keychain[key.rawValue] ?? ""
    }
    
    public static func remove(for key: KeychainKeys) {
        keychain[key.rawValue] = nil
    }
    
    public static func removeAll() {
        KeychainKeys.allCases.forEach {
            keychain[$0.rawValue] = nil
        }
    }
}

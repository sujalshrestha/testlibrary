//
//  File.swift
//  
//
//  Created by Sujal Shrestha on 10/05/2023.
//

import Foundation

public enum Environment {
    case production
    case development
}

nonisolated(unsafe) public var environment: Environment = .development

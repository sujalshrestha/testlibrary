//
//  DataModel.swift
//  Bonchon
//
//  Created by Sujal Shrestha on 04/07/2021.
//

import Foundation

public protocol DataModel: Codable {
    
    associatedtype CodeType: Codable

    var code: CodeType? { get set }
    var message: String? { get set }
}

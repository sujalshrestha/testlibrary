// Copyright © 2021 Minor. All rights reserved.

import Foundation
import Alamofire

public protocol NetworkURLRequest {
    var baseURL: String { get }
    var path: String { get }
    var requestURL: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders { get }
    var encoder: ParameterEncoder { get }
}

struct CustomURLEncoder: ParameterEncoder {
    static let `default` = CustomURLEncoder()
    
    func encode<Parameters: Encodable>(_ parameters: Parameters?, into request: URLRequest) throws -> URLRequest {
        let request = request
        guard let parameters = parameters else { return request }
        
        // Convert the parameters to a dictionary
        let dictionaryParameters: [String: Any]
        
        if let params = parameters as? [String: Any] {
            dictionaryParameters = params
        } else {
            let jsonData = try JSONEncoder().encode(parameters)
            dictionaryParameters = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] ?? [:]
        }
        
        // Encode the dictionary parameters into the URL
        let urlEncoding = URLEncoding(boolEncoding: .literal)
        return try urlEncoding.encode(request, with: dictionaryParameters)
    }
}

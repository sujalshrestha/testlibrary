// Copyright © 2021 Minor. All rights reserved.

import Foundation

public class NetworkError: Error {
    public var localizedDescription: String { message ?? "" }

    public var message: String?
    public var statusCode: Int?

    init(message: String?, statusCode: Int?) {
        self.message = message
        self.statusCode = statusCode
    }
}

// Copyright © 2021 Minor. All rights reserved.

import Foundation

public final class NetworkError: Error {
    public let localizedDescription: String

    public let message: String?
    public let statusCode: Int?

    init(message: String?, statusCode: Int?) {
        self.message = message
        self.statusCode = statusCode
        self.localizedDescription = message ?? "An unknown network error occurred"
    }
}

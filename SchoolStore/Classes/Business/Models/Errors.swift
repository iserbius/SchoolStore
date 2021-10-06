// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - Errors

enum Errors: LocalizedError {
    case failedResponse(message: String, fieelds: [FieldError]?)
    case unknown

    // MARK: Internal

    var errorDescription: String? {
        switch self {
        case let .failedResponse(message, _):
            return message
        case .unknown:
            return L10n.Common.error
        }
    }
}

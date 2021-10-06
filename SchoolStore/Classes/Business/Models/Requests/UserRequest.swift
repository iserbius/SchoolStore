// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum UserRequest: Request {
    case login(user: String, password: String)

    // MARK: Internal

    var path: String {
        switch self {
        case .login:
            return "user/signin"
        }
    }

    var method: RequestMethod {
        switch self {
        case .login:
            return .put
        }
    }

    var body: Data? {
        switch self {
        case let .login(user, password):
            return RequestBuilderImpl.encode(["login": user, "password": password])
        }
    }

    var mock: Data? {
        switch self {
        case let .login(user, password):
            if password != "pass", user != "user" {
                guard let path = Bundle.main.path(forResource: "authFailed", ofType: "json"),
                      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                else {
                    return nil
                }
                return data
            } else {
                guard let path = Bundle.main.path(forResource: "auth", ofType: "json"),
                      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                else {
                    return nil
                }
                return data
            }
        }
    }
}

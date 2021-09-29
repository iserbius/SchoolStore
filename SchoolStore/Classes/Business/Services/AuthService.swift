// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - AuthService

protocol AuthService: AnyObject {
    func authenticate(user: String, with password: String, completion: ((Result<String, Error>) -> Void)?)
}

// MARK: - AuthServiceImpl

final class AuthServiceImpl: AuthService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    // MARK: Internal

    func authenticate(user: String, with password: String, completion: ((Result<String, Error>) -> Void)?) {
        if user == "user", password == "password" {
            let token = "sampleReceivedToken"
            dataService.appState.accessToken = token
            completion?(Result.success(token))
        } else {
            completion?(Result.failure(Errors.authFailed))
        }
    }

    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}

// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum CoreFactory {
    static let networkProvider: NetworkProvider = NetworkProviderImpl()

    static let dataService: DataService = DataServiceImpl()

    static func buildAuthService() -> AuthService {
        AuthServiceImpl(networkProvider: Self.networkProvider, dataService: Self.dataService)
    }
}

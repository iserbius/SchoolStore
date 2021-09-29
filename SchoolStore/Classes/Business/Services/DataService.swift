// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - DataService

protocol DataService: AnyObject {
    var appState: AppState { get set }
}

// MARK: - DataServiceImpl

final class DataServiceImpl: DataService {
    // MARK: Lifecycle

    init() {
        appState = AppState(
            accessToken: UserDefaults.standard.string(forKey: Keys.accessToken.rawValue)
        )
    }

    // MARK: Internal

    var appState: AppState {
        didSet {
            UserDefaults.standard.setValue(appState.accessToken, forKey: Keys.accessToken.rawValue)
        }
    }

    // MARK: Private

    private enum Keys: String {
        case accessToken
    }
}

// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - NetworkProvider

protocol NetworkProvider {
    func make<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?)
}

// MARK: - NetworkProviderImpl

final class NetworkProviderImpl: NetworkProvider {
    func make<T: Decodable>(_: Request, completion _: ((Result<T, Error>) -> Void)?) {}
}

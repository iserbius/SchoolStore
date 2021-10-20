// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - NetworkProvider

protocol NetworkProvider {
    func mock<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?)
    func make<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?)
}

// MARK: - NetworkProviderImpl

final class NetworkProviderImpl: NetworkProvider {
    // MARK: Lifecycle

    init(requestBuilder: RequestBuilder) {
        self.requestBuilder = requestBuilder
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // MARK: Internal

    func mock<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?) {
        serializeData(response: request.mock, completion: completion)
    }

    func make<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?) {
        guard let urlRequest = requestBuilder.build(request) else {
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            self?.serializeData(response: data, completion: completion)
        }
        task.resume()
    }

    // MARK: Private

    private let decoder: JSONDecoder

    private let requestBuilder: RequestBuilder

    private func serializeData<T: Decodable>(response data: Data?, completion: ((Result<T, Error>) -> Void)?) {
        guard let data = data else {
            completion?(.failure(Errors.unknown))
            return
        }
        if let response = try? decoder.decode(T.self, from: data) {
            completion?(.success(response))
        } else if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
            completion?(.failure(Errors.failedResponse(message: errorResponse.message, fields: errorResponse.fields)))
        } else {
            completion?(.failure(Errors.unknown))
        }
    }
}

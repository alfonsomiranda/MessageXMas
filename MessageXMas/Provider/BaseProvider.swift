//
//  BaseProvider.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 18/3/21.
//

import Foundation
import Combine

protocol BaseProviderProtocol {
    func requestGeneric<T: Decodable>(_ entityClass : T.Type, endpoint: String, timeout: TimeInterval, retry: Int) -> AnyPublisher<T, NetworkingError>
}

class BaseProvider: BaseProviderProtocol {
    func requestGeneric<T: Decodable>(_ entityClass : T.Type, endpoint: String, timeout: TimeInterval = 60, retry: Int = 5) -> AnyPublisher<T, NetworkingError> {
        guard let url = URL(string: endpoint) else {
            preconditionFailure()
            
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError { (error) -> NetworkingError in
                NetworkingError(error: error)
            }
            .flatMap { data, response -> AnyPublisher<T, NetworkingError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkingError(errorCode: 500)).eraseToAnyPublisher()
                }
                if (200...299).contains(httpResponse.statusCode) {
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError { error in
                            NetworkingError(status: .accepted)
                        }
                        .eraseToAnyPublisher()
                } else {
                    let error = NetworkingError(errorCode: httpResponse.statusCode)
                    return Fail(error: NetworkingError(error: error))
                        .eraseToAnyPublisher()
                }
            }
            .retry(retry)
            .eraseToAnyPublisher()
    }
}

//
//  BaseProvider.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 18/3/21.
//

import Foundation
import Combine


enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

protocol BaseProviderProtocol {
    
    func requestGeneric<T>(_ url: URL,
                           entityClass : T.Type) -> AnyPublisher<T, NetworkingError> where T : Decodable
}

class BaseProvider: BaseProviderProtocol {
    
    internal func requestGeneric<T>(_ url: URL,
                                    entityClass : T.Type) -> AnyPublisher<T, NetworkingError> where T : Decodable {
        
        let urlRequest = URLRequest(url: url)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .jsonDecodingPublisher(type: T.self)
    }
}

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
    func requestGeneric<T: Decodable>(_ entityClass : T.Type, endpoint: String) -> AnyPublisher<T, APIError>
}

class BaseProvider: BaseProviderProtocol {
    func requestGeneric<T: Decodable>(_ entityClass : T.Type, endpoint: String) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: endpoint) else {
            preconditionFailure()
            
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: entityClass.self, decoder: JSONDecoder())
            .mapError { error in
                if let errorDes = error as? APIError {
                    return errorDes
                    
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                    
                }
                
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

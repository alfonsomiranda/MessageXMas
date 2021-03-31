//
//  BaseProvider.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 18/3/21.
//

import Foundation
import Combine

protocol BaseProviderProtocol {
    func requestGeneric<T: Decodable>(_ entityClass : T.Type, dto: ProviderDTO, timeout: TimeInterval, retry: Int) -> AnyPublisher<T, NetworkingError>
}

class BaseProvider: BaseProviderProtocol {
    func requestGeneric<T: Decodable>(_ entityClass : T.Type, dto: ProviderDTO, timeout: TimeInterval = 60, retry: Int = 5) -> AnyPublisher<T, NetworkingError> {
        
        guard let request = createRequest(dto: dto) else {
            return Fail(error: NetworkingError(status: .badRequest)).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { (error) -> NetworkingError in
                NetworkingError(error: error)
            }
            .flatMap { data, response -> AnyPublisher<T, NetworkingError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkingError(status: .badRequest)).eraseToAnyPublisher()
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

private extension BaseProvider {
    func requestFromBody(params: [String: Any]?) -> Data? {
        guard let params = params,
              let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return nil }
        return httpBody
    }
    
    func createRequest(dto: ProviderDTO) -> URLRequest? {
        guard let url = URL(string: dto.endpoint) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = dto.method.rawValue
        request.httpBody = requestFromBody(params: dto.body)
        
        return request
    }
}

struct ProviderDTO {
    var endpoint: String
    var method: HTTPMethod
    var body: [String: Any]?
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

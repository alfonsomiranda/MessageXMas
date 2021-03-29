//
//  BaseProvider+Helpers.swift
//  MessageXMas
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/03/2021.
//

import Foundation
import Combine

// MARK: - Endpoint
struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem]? = []
}

// MARK: - extension Endpoint
extension Endpoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "605ca20d6d85de00170dac06.mockapi.io"
        components.path = "/msgxmas/v1/" + path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    var headers: [String: Any] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
}

// MARK: - extension Endpoint static func
extension Endpoint {
    
    static func categories() -> Self {
        return Endpoint(path: "categories")
    }
    
}

enum NetworkingError: Error {
    case decoding(DecodingError)
    case incorrectStatusCode(Int)
    case network(URLError)
    case nonHTTPResponse
    case unknown(Error)
}

extension Publisher {
    func mapErrorToNetworkingError() -> AnyPublisher<Output, NetworkingError> {
        mapError { error -> NetworkingError in
            switch error {
            case let decodingError as DecodingError:
                return .decoding(decodingError)
            case let networkingError as NetworkingError:
                return networkingError
            case let urlError as URLError:
                return .network(urlError)
            default:
                return .unknown(error)
            }
        }
        .eraseToAnyPublisher()
    }
}

extension URLSession.DataTaskPublisher {
    func emptyBodyResponsePublisher() -> AnyPublisher<Void, NetworkingError> {
        httpResponseValidator()
        .map { _ in Void() }
        .eraseToAnyPublisher()
    }
}

extension URLSession.DataTaskPublisher {
    func httpResponseValidator() -> AnyPublisher<Output, NetworkingError> {
        tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkingError.nonHTTPResponse }
            let statusCode = httpResponse.statusCode
            guard (200..<300).contains(statusCode) else { throw NetworkingError.incorrectStatusCode(statusCode) }
            return (data, httpResponse)
        }
        .receive(on: RunLoop.main)
        .mapErrorToNetworkingError()
    }

    func httpResponseValidatorDataPublisher() -> AnyPublisher<Data, NetworkingError> {
        httpResponseValidator()
        .map(\.data)
        .eraseToAnyPublisher()
    }

    func jsonDecodingPublisher<T>(type: T.Type) -> AnyPublisher<T, NetworkingError> where T : Decodable {
        httpResponseValidatorDataPublisher()
            .decode(type: T.self, decoder: JSONDecoder())
            .mapErrorToNetworkingError()
    }
}

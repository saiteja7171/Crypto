//
//  NetworkingManager.swift
//  Crypto
//
//  Created by Sai Teja Atluri on 7/16/24.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "Bad response from the url \(url)"
            case .unknown: return "Unkonow error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
      return URLSession.shared.dataTaskPublisher(for: url)
             .tryMap( { try handleURLResponse(output: $0, url: url) })
             .retry(3)
             .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Publishers.Decode<AnyPublisher<Data, Error>, [CoinModel], JSONDecoder>.Failure>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

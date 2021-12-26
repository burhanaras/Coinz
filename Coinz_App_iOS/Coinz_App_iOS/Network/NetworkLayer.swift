//
//  NetworkLayer.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation
import Combine

protocol INetworkLayer {
    func getCoins() -> AnyPublisher<CoinsResponse, RequestError>
}

class NetworkLayer: INetworkLayer {
    private let decoder = JSONDecoder()
    
    func getCoins() -> AnyPublisher<CoinsResponse, RequestError> {
        guard let url = getComponentsForCoinsRequest().url else {
            return Fail<CoinsResponse, RequestError>(error: .invalidEndpoint)
                .eraseToAnyPublisher()
        }
        
        let publisher: AnyPublisher<CoinsResponse, RequestError> = fetch(url: url)
        return publisher.eraseToAnyPublisher()
    }
    
    private func fetch<NetworkModel: Codable>(url: URL?) -> AnyPublisher<NetworkModel, RequestError>{
        guard let url = url else{
            return Result<NetworkModel, RequestError>
                .Publisher(.failure(.invalidEndpoint))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        print(request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .map{
                print(String(data: $0.data, encoding: .utf8) as Any)
                return $0.data
            }
            .decode(type: NetworkModel.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .mapError{_ in return .apiError}
            .eraseToAnyPublisher()
        
    }
    
}

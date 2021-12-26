//
//  HomeViewModel.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    //MARK: - Properties
    @Published var coins = [Coin]()
    @Published var cancellables: Set<AnyCancellable> = []
    @Published var networkLayer: INetworkLayer = NetworkLayer()
    
    //MARK: - Helper functions
    func loadData() {
        networkLayer.getCoins()
            .sink { completion in
                switch completion {
                    
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: {[unowned self] coinsResponse in
                print(coinsResponse.data.coins)
                self.coins = coinsResponse.data.coins.map{ Coin.fromDTO(dto: $0)}
            }
            .store(in: &cancellables)
    }
    
}

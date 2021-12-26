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
    
    private var allCoins = [Coin]()
    private var sortType: SortType = .price
    
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
                self.allCoins = coinsResponse.data.coins.map{ Coin.fromDTO(dto: $0)}
                sortData(with: sortType)
            }
            .store(in: &cancellables)
    }
    
    func sortData(with sortType: SortType) {
        switch sortType {
        case .price:
            self.coins = allCoins.sorted(by: { $0.price.toDouble() > $1.price.toDouble() })
        case .marketCap:
            self.coins = allCoins.sorted(by: { $0.marketCap.toDouble() > $1.marketCap.toDouble() })
        case .volume:
            self.coins = allCoins.sorted(by: { $0.price > $1.price })
        case .change:
            self.coins = allCoins.sorted(by: { $0.change.toDouble() > $1.change.toDouble() })
        case .listedAt:
            self.coins = allCoins.sorted(by: { $0.price > $1.price })
        }
    }
    
}


enum SortType {
    case price, marketCap, volume, change, listedAt
}

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.00
    }
}

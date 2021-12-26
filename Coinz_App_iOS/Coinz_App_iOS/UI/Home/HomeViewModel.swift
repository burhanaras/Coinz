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
    private var cancellables: Set<AnyCancellable> = []
    private var networkLayer: INetworkLayer
    private var databaseLayer: IDatabaseLayer
    
    private var allCoins = [Coin]()
    private var sortType: SortType = .price
    @Published var sortText: String = "Price"
    @Published var errorMessage: String = ""
    
    init(networkLayer: INetworkLayer, databaseLayer: IDatabaseLayer){
        self.networkLayer = networkLayer
        self.databaseLayer = databaseLayer
    }
    
   
    
    //MARK: - Helper functions
    func loadData() {
        networkLayer.getCoins()
            .sink { completion in
                switch completion {
                    
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: {[unowned self] coinsResponse in
                print(coinsResponse.data.coins)
                self.allCoins = coinsResponse.data.coins.map{ Coin.fromDTO(dto: $0)}
                sortData(with: sortType)
                databaseLayer.save(data: allCoins)
            }
            .store(in: &cancellables)
    }
    
    func sortData(with sortType: SortType) {
        self.sortType = sortType
        switch sortType {
        case .price:
            self.sortText = "Price"
            self.coins = allCoins.sorted(by: { $0.price.toDouble() > $1.price.toDouble() })
        case .marketCap:
            self.sortText = "Market Cap"
            self.coins = allCoins.sorted(by: { $0.marketCap.toDouble() > $1.marketCap.toDouble() })
        case .change:
            self.sortText = "Change"
            self.coins = allCoins.sorted(by: { $0.change.toDouble() > $1.change.toDouble() })
        case .listedAt:
            self.sortText = "Listed At"
            self.coins = allCoins.sorted(by: { $0.listedAt > $1.listedAt })
        }
    }
    
}


enum SortType {
    case price, marketCap, change, listedAt
}

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.00
    }
}

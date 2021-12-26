//
//  DetailViewModel.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var data: [String] = []
    private var coin: Coin
    private let databaseLayer: IDatabaseLayer
    
    init(coin: Coin, databaseLayer: IDatabaseLayer){
        self.coin = coin
        self.databaseLayer = databaseLayer
        loadData()
    }
    
    
    
    func loadData() {
        databaseLayer.retrieve(for: coin.id){[unowned self] data in
            self.data = data
            print(data.count)
        }
    }
}

//
//  Coordinator.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation

final class Coordinator {
    static let shared = Coordinator()
    private let databaseLayer: IDatabaseLayer = DatabaseLayer()
    
    func getHomeView() -> HomeView {
        return HomeView(viewModel: HomeViewModel(networkLayer: NetworkLayer(),databaseLayer: databaseLayer))
    }
    
    func getDetailView(for coin: Coin) -> DetailView {
        return DetailView(viewModel: DetailViewModel(coin: coin, databaseLayer: databaseLayer), coin: coin)
    }
}

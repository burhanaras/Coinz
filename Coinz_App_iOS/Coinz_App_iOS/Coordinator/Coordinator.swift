//
//  Coordinator.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation

final class Coordinator {
    static let shared = Coordinator()
    
    func getHomeView() -> HomeView {
        return HomeView(viewModel: HomeViewModel(networkLayer: NetworkLayer()))
    }
    
    func getDetailView(for coin: Coin) -> DetailView {
        return DetailView(viewModel: DetailViewModel(), coin: coin)
    }
}

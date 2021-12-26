//
//  HomeView.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationView{
            List(viewModel.coins){ coin in
                Text(coin.name)
            }
            .task {
                viewModel.loadData()
            }
            .refreshable {
                viewModel.loadData()
            }
            .navigationTitle("₿ Coinz App")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  HomeView.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                LazyVStack{
                    topBar.padding()
                    ForEach(viewModel.coins){ coin in
                        NavigationLink{
                            Coordinator.shared.getDetailView(for: coin)
                        } label: {
                            CoinView(coin: coin)
                                .padding(4)
                        }

                    }
                }
            }.task {
                viewModel.loadData()
            }
            .navigationBarHidden(true)
        }
    }
    var topBar: some View {
        HStack {
            Text("₿ Coinz App").font(.title)
            Spacer()
            Menu {
                Button {
                    viewModel.sortData(with: SortType.price)
                } label: {
                    Text("Price")
                }
                
                Button {
                    viewModel.sortData(with: SortType.marketCap)
                } label: {
                    Text("Market Cap")
                }
                
                Button {
                    viewModel.sortData(with: SortType.change)
                } label: {
                    Text("Change")
                }

                Button {
                    viewModel.sortData(with: SortType.listedAt)
                } label: {
                    Text("Listed At")
                }
                
            } label: {
                Text(viewModel.sortText)
            }

        }
    }
}


struct CoinView: View {
    let coin: Coin
    var body: some View {
        HStack {
            AsyncImage(
                url: coin.iconUrl,
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32, alignment: .center)
                },
                placeholder: {
                    ProgressView()
                }
            )
                .padding()
            VStack(spacing: 8) {
                HStack {
                    Text(coin.symbol)
                    Spacer()
                    Text(coin.price)
                }
                HStack{
                    Text(coin.name)
                    Spacer()
                    Text(coin.change)
                }
            }
        }
        .padding(4)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(6)
        .shadow(radius: 16)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(networkLayer: NetworkLayer(), databaseLayer: DatabaseLayer()))
    }
}

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
            VStack{
                ScrollView(.vertical){
                    Text("₿ Coinz App").font(.title)
                    ForEach(viewModel.coins){ coin in
                        CoinView(coin: coin)
                            .padding(4)
                    }
                }
            }.task {
                viewModel.loadData()
            }
            .navigationBarHidden(true)
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
        HomeView()
    }
}

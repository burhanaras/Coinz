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
                Text("₿ Coinz App").font(.title)
                ScrollView(.vertical){
                    ForEach(viewModel.coins){ coin in
                        CoinView(coin: coin)
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
            Text(coin.name)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

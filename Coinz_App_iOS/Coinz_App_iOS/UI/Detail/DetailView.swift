//
//  DetailView.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    let coin: Coin
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Coin: \(coin.symbol) - \(coin.name)")
                    .font(.title)
                Text("Price: \(coin.price)")
                
                Text("History:").font(.title).padding(.vertical)
                ForEach(viewModel.data, id: \.self){ price in
                    HStack{
                        Text(price)
                    }
                    Divider()
                }
                Spacer()
                HStack{ Spacer()}
            }
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            viewModel: DetailViewModel(coin: dummyCoin, databaseLayer: DatabaseLayer()),
            coin: dummyCoin)
    }
}

let dummyCoin = Coin(id: "1", symbol: "1", name: "1", iconUrl: URL(string: "https://cdn.coinranking.com/yvUG4Qex5/solana.svg")!, price: "1", marketCap: "1", change: "1", listedAt: 1)

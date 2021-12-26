//
//  Coin.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation

struct Coin: Identifiable {
    let id: String
    let symbol: String
    let name: String
    let iconUrl: URL
    let price: String
    let marketCap: String
    let change: String
}

extension Coin {
    static func fromDTO(dto: CoinDTO) -> Coin {
        return Coin(
            id: dto.uuid, symbol: dto.symbol, name: dto.name, iconUrl: URL(string: dto.iconUrl) ?? URL(string: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg")!, price: dto.price, marketCap: dto.marketCap, change: dto.change)
    }
}

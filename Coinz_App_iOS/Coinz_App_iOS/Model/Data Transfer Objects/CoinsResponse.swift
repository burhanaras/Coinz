//
//  CoinsResponse.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation

struct CoinDTO: Codable {
    let uuid: String
    let symbol: String
    let name: String
    let iconUrl: String
    let price: String
    let marketCap: String
    let change: String
    let listedAt: Double
}

struct CoinsDataDTO: Codable {
    let coins: [CoinDTO]
}

struct CoinsResponse: Codable {
    let status: String
    let data: CoinsDataDTO
}

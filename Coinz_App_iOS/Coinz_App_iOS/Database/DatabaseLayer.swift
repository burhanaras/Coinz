//
//  DatabaseLayer.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation

protocol IDatabaseLayer {
    func save(data: [Coin])
    func retrieve(for uuid: String, completion: @escaping ([String]) -> Void)
}


class DatabaseLayer: IDatabaseLayer {
    func save(data: [Coin]) {
        
        DispatchQueue.main.async {
            let defaults = UserDefaults.standard
            let date = Date()
            for coin in data {
                var savedArray = defaults.object(forKey: coin.id) as? [String] ?? [String]()
                savedArray.append(("\(date) - \( coin.price)"))
                defaults.set(savedArray, forKey: coin.id)
            }
        }
    }
    
    func retrieve(for id: String, completion: @escaping ([String]) -> Void) {
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: id) as? [String] ?? [String]()
        completion(savedArray)
    }
    
    
}

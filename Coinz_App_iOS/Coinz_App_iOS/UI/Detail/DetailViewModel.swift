//
//  DetailViewModel.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var data: [(String, String)] = []
}
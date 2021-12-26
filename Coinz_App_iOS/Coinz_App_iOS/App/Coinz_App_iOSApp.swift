//
//  Coinz_App_iOSApp.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import SwiftUI

@main
struct Coinz_App_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            Coordinator.shared.getHomeView()
        }
    }
}

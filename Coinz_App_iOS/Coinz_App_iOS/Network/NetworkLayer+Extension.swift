//
//  NetworkLayer+Extension.swift
//  Coinz_App_iOS
//
//  Created by Burhan Aras on 26.12.2021.
//

import Foundation

extension NetworkLayer {
    struct CoinsAPI{
        static let schema = "https"
        static let host = "psp-merchantpanel-service-sandbox.ozanodeme.com.tr"
    }
    
    func getComponentsForCoinsRequest() -> URLComponents{
        var components = URLComponents()
        components.scheme = CoinsAPI.schema
        components.host = CoinsAPI.host
        components.path = "/api/v1/dummy/coins"
        return components
    }
}

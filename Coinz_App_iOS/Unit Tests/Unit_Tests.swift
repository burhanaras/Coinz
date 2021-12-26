//
//  Unit_Tests.swift
//  Unit Tests
//
//  Created by Burhan Aras on 26.12.2021.
//

import XCTest
import Combine
@testable import Coinz_App_iOS

class Unit_Tests: XCTestCase {

    func test_mapping_from_DTO_toCoin_should_work_fine(){
        // GIVEN: that we have a CoinDTO
        let dto = CoinDTO(uuid: "uuid", symbol: "symbol", name: "name", iconUrl: "url", price: "price", marketCap: "marketCap", change: "change", listedAt: 1.0)
        
        // WHEN: DTO is mapped to Coin
        let sut = Coin.fromDTO(dto: dto)
        
        // THEN: fields should be correct
        XCTAssertEqual(sut.id, dto.uuid)
        XCTAssertEqual(sut.symbol, dto.symbol)
        XCTAssertEqual(sut.name, dto.name)
        XCTAssertEqual(sut.price, "$ \(dto.price)")
    }

}

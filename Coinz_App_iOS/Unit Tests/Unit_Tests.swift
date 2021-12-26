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
        let dto = CoinDTO(uuid: "uuid", symbol: "symbol", name: "name", iconUrl: "url", price: "12.50", marketCap: "marketCap", change: "change", listedAt: 1.0)
        
        // WHEN: DTO is mapped to Coin
        let sut = Coin.fromDTO(dto: dto)
        
        // THEN: fields should be correct
        XCTAssertEqual(sut.id, dto.uuid)
        XCTAssertEqual(sut.symbol, dto.symbol)
        XCTAssertEqual(sut.name, dto.name)
        XCTAssertEqual(sut.price, "$ \(dto.price)")
    }

    func test_HomeviewModel_should_return_correct_data() {
        // GIVEN: that we have test network layer that returns some coins
        let coinsResponse = CoinsResponse(status: "success", data: CoinsDataDTO(coins: dummyData(count: 12)))
        let networkLayer: INetworkLayer = TestNetworkLayer(response: coinsResponse)
        let sut = HomeViewModel(networkLayer: networkLayer)
        
        // WHEN: HomeViewModel's loadData() is called
        sut.loadData()
        
        // THEN: HomeViewModel's coins should be same as returned data
        XCTAssertEqual(12, sut.coins.count)
    }
    
    func test_HomeviewModel_should_show_error_when_network_fails() {
        // GIVEN: that we have test network layer that returns some coins
        let networkLayer: INetworkLayer = TestFailingNetworkLayer(response: RequestError.apiError)
        let sut = HomeViewModel(networkLayer: networkLayer)
        
        // WHEN: HomeViewModel's loadData() is called
        sut.loadData()
        
        // THEN: HomeViewModel's coins should be same as returned data
        XCTAssertEqual(RequestError.apiError.localizedDescription, sut.errorMessage)
    }
}



// MARK: - Network layer that returns data
class TestNetworkLayer: INetworkLayer {
    let response: CoinsResponse
    
    init(response: CoinsResponse){
        self.response = response
    }
    
    func getCoins() -> AnyPublisher<CoinsResponse, RequestError> {
        return Result<CoinsResponse, RequestError>
            .Publisher(.success(response))
            .eraseToAnyPublisher()
    }
}

// MARK: - Network layer that fails.
class TestFailingNetworkLayer: INetworkLayer {
    let response: RequestError
    
    init(response: RequestError){
        self.response = response
    }
    
    func getCoins() -> AnyPublisher<CoinsResponse, RequestError> {
        return Result<CoinsResponse, RequestError>
            .Publisher(.failure(response))
            .eraseToAnyPublisher()
    }
}

// MARK: - Dummy data
func dummyData(count: Int) -> [CoinDTO] {
    var data = [CoinDTO]()
    for index in 0..<count {
        let coin = CoinDTO(uuid: "\(index)", symbol: "symbol", name: "name", iconUrl: "url", price: "12.5", marketCap: "marketCap", change: "change", listedAt: 1.0)
        data.append(coin)
    }
    return data
}

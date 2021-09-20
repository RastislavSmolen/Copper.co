//
//  Copper_coTests.swift
//  Copper.coTests
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import XCTest
@testable import Copper

// simple test example whit local json file
class iOSTakeHomeChallengeTests: XCTestCase {
    
    
    var networking = MockNetworking()
    var viewModel : OrderListModel?
    
    override func setUp() {
        viewModel = OrderListModel(networking: networking)
        super.setUp()
    }
    func testFetchDataSuccessScenario(){
        viewModel?.fetchData{(results,err) in
            guard let result = results else {return}
            for result in result {
                XCTAssertEqual(result.orders.count,11347)
                XCTAssertEqual(result.orders.first?.amount,"748.279727546401")
                XCTAssertEqual(result.orders.first?.createdAt,"1595770212105")
                XCTAssertEqual(result.orders.first?.orderId,"3a16aef1d2afe8af1ad52fd4ec374fae")
                XCTAssertEqual(result.orders.first?.currency.rawValue,"BTC")
                XCTAssertEqual(result.orders.first?.orderStatus.rawValue,"approved")
                XCTAssertEqual(result.orders.first?.orderType.rawValue,"deposit")
            }
        }
        func testFetchDataFailScenario(){
            
            networking.localJSONFile = "failure"
            viewModel?.fetchData{(results,err) in
                XCTAssertNil(results?.count)
                XCTAssertNil(results?.first)
            }
        }
        
    }
    class MockNetworking: NetworkingProtoccol {
        
        var localJSONFile = MockAPIEndpoitLocalized.mockJson.api()
        
        func fetchData<T: Codable>(url: URL, type: T.Type, completionHandler: @escaping (Result<T,NetworkError>) -> Void) {
            
            guard let path = Bundle.main.path(forResource: "OrderListMockData", ofType: "json") else {
                completionHandler(.failure(NetworkError.malformedLocalizedJsonFile(message: "json file not found/ is not correctly formed")))
                return
            }
            
            let url = URL(fileURLWithPath: path)
            
            let jsonData = try? Data(contentsOf: url)
            guard let data = jsonData else {return}
            do {
                let dataSummary = try JSONDecoder().decode(type, from: data)
                completionHandler(.success(dataSummary))
            } catch {
                completionHandler(.failure(NetworkError.parsingFailed(message: "\(error)")))
            }
        }
    }
}

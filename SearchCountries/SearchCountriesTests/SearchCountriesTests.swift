//
//  SearchCountriesTests.swift
//  SearchCountriesTests
//
//  Created by Chakane Shegog on 1/10/22.
//

import XCTest
@testable import SearchCountries

class SearchCountriesTests: XCTestCase {
    func testWeatherAPI() {
        var searchTerm = "new york"
        searchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let endpoint = "https://www.metaweather.com/api/location/search/?query=\(searchTerm)"
        let exp = XCTestExpectation(description: "data OK!")
        guard let url = URL(string: endpoint) else {
            XCTFail("bad url")
            return
        }
        let request = URLRequest(url: url)
        NetworkRequest.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let networkError):
                XCTFail("Network Client Error")
            case .success(let data):
                XCTAssertGreaterThan(data.count, 1000)
                exp.fulfill()
            }
        }
    }

}

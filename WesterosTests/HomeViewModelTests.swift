//
//  WesterosTests.swift
//  WesterosTests
//
//  Created by Fitzgerald Afful on 25/10/2022.
//

import XCTest
@testable import Westeros

final class HousesListViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        viewModel = HomeViewModel()
        viewModel.houseRepo = MockHouseRepository()
    }

    func testLoadHouses() throws {

        let timeInSeconds = 1.0
        let expectation = XCTestExpectation(description: "Load Houses")

        viewModel.loadHouses()

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
            XCTAssertTrue(self.viewModel.houses.count > 0)
        }

        wait(for: [expectation], timeout: timeInSeconds + 1.0)

    }

}

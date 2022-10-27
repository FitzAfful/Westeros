//
//  WesterosTests.swift
//  WesterosTests
//
//  Created by Fitzgerald Afful on 25/10/2022.
//

import XCTest
@testable import Westeros

final class HouseViewModelTests: XCTestCase {
    var viewModel: HouseViewModel!

    override func setUpWithError() throws {
        viewModel = HouseViewModel(house: House.random())
        viewModel.houseRepo = MockHouseRepository()
        viewModel.characterRepo = MockCharacterRepository()
    }

    func testInit() throws {
        XCTAssertNotNil(viewModel.house)
    }

}

//
//  BalanceViewModelTests.swift
//  HomeWorkTests
//
//  Created by Giau Huynh on 11/05/2024.
//

import XCTest
@testable import HomeWork

class BalanceViewModelTests: XCTestCase {
    var viewModel: BalanceViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = BalanceViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testLoadFirstOpen() {
        let expectation = XCTestExpectation(description: "Test Load First Open")
        XCTAssertTrue(viewModel.usdProgress == 1, "usdProgress should 1 before start")
        XCTAssertTrue(viewModel.usdBalance == 0, "usdBalance should 0 before start")
        XCTAssertTrue(viewModel.khrProgress == 1, "khrProgress should 1 before start")
        XCTAssertTrue(viewModel.khrBalance == 0, "khrBalance should 0 before start")
        
        viewModel.loadFirstOpen()
        
        XCTAssertTrue(viewModel.usdProgress == 0, "usdProgress should 0 when starting")
        XCTAssertTrue(viewModel.khrProgress == 0, "khrProgress should 0 when starting")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // TODO: change later
            XCTAssertTrue(self.viewModel.usdProgress == 1, "usdProgress should 1 when complete")
            XCTAssertTrue(self.viewModel.usdBalance >= 0, "usdBalance >= 0 when complete")
            XCTAssertTrue(self.viewModel.khrProgress == 1, "khrProgress should 1 when complete")
            XCTAssertTrue(self.viewModel.khrBalance >= 0, "khrBalance >= 0 when complete")

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 6) // TODO: change later
    }

    func testLoadPullRefresh() {
        let expectation = XCTestExpectation(description: "Test Load First Open")
        XCTAssertTrue(viewModel.usdProgress == 1, "usdProgress should 1 before start")
        XCTAssertTrue(viewModel.usdBalance == 0, "usdBalance should 0 before start")
        XCTAssertTrue(viewModel.khrProgress == 1, "khrProgress should 1 before start")
        XCTAssertTrue(viewModel.khrBalance == 0, "khrBalance should 0 before start")
        
        viewModel.loadPullRefresh()
        
        XCTAssertTrue(viewModel.usdProgress == 0, "usdProgress should 0 when starting")
        XCTAssertTrue(viewModel.khrProgress == 0, "khrProgress should 0 when starting")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // TODO: change later
            XCTAssertTrue(self.viewModel.usdProgress == 1, "usdProgress should 1 when complete")
            XCTAssertTrue(self.viewModel.usdBalance >= 0, "usdBalance >= 0 when complete")
            XCTAssertTrue(self.viewModel.khrProgress == 1, "khrProgress should 1 when complete")
            XCTAssertTrue(self.viewModel.khrBalance >= 0, "khrBalance >= 0 when complete")

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 6) // TODO: change later
    }
}

//
//  APITests.swift
//  HomeWorkTests
//
//  Created by Giau Huynh on 11/05/2024.
//

import XCTest
@testable import HomeWork

class APITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Notification
    func testGetNotificationListFirstOpen() {
        let urlString = "https://willywu0201.github.io/data/emptyNotificationList.json"
        let expectation = XCTestExpectation(description: "Test API: \(urlString)")
        
        HTTPService().getRequest(
            urlString: urlString,
            responseType: Response<NotificationMessages>.self
        ) { result in
            switch result {
            case .success(_):
                XCTFail("This API doesn't have data")
            case .failure(let error):
                if case APIError.invalidData(let urlError, _) = error {
                    XCTAssertEqual(urlString, urlError, "2 urls should be same")
                } else {
                    XCTFail("Wrong APIError returned")
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetNotificationListPullRefresh() {
        let urlString = "https://willywu0201.github.io/data/notificationList.json"
        let expectation = XCTestExpectation(description: "Test API: \(urlString)")
        
        HTTPService().getRequest(
            urlString: urlString,
            responseType: Response<NotificationMessages>.self
        ) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "This API should have data")
            case .failure(_):
                XCTFail("This API should not failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: Favorite
    func testGetFavoriteListFirstOpen() {
        let urlString = "https://willywu0201.github.io/data/emptyFavoriteList.json"
        let expectation = XCTestExpectation(description: "Test API: \(urlString)")
        
        HTTPService().getRequest(
            urlString: urlString,
            responseType: Response<FavoriteList>.self
        ) { result in
            switch result {
            case .success(_):
                XCTFail("This API doesn't have data")
            case .failure(let error):
                if case APIError.invalidData(let urlError, _) = error {
                    XCTAssertEqual(urlString, urlError, "2 urls should be same")
                } else {
                    XCTFail("Wrong APIError returned")
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetFavoriteListPullRefresh() {
        let urlString = "https://willywu0201.github.io/data/favoriteList.json"
        let expectation = XCTestExpectation(description: "Test API: \(urlString)")
        
        HTTPService().getRequest(
            urlString: urlString,
            responseType: Response<FavoriteList>.self
        ) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "This API should have data")
            case .failure(_):
                XCTFail("This API should not failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: Banner
    func testGetBannerList() {
        let urlString = "https://willywu0201.github.io/data/banner.json"
        let expectation = XCTestExpectation(description: "Test API: \(urlString)")
        
        HTTPService().getRequest(
            urlString: urlString,
            responseType: Response<BannerList>.self
        ) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "This API should have data")
            case .failure(_):
                XCTFail("This API should not failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

//
//  HomeViewModelTests.swift
//  HomeWorkTests
//
//  Created by Giau Huynh on 11/05/2024.
//

import XCTest
@testable import HomeWork

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockHTTPService: MockHTTPService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockHTTPService = MockHTTPService()
        viewModel = HomeViewModel(httpService: mockHTTPService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockHTTPService = nil
    }

    // MARK: Notification
    func testGetNotificationListFirstOpenSuccess() {
        let notifications = [Notification(status: true, updateDateTime: "", title: "abc", message: "def")]
        let notificationMessages = NotificationMessages(messages: notifications)
        let response = Response(msgCode: "200", msgContent: "Success", result: notificationMessages)
        mockHTTPService.mockResult = Result<Response<NotificationMessages>, Error>.success(response)
        
        viewModel.getNotificationListFirstOpen()
        
        XCTAssertFalse(viewModel.notificationList.isEmpty)
        XCTAssertEqual(
            viewModel.notificationList.count, notifications.count,
            "Notification list should have the same number of elements as in the mock response"
        )
        
        if let firstNotification = viewModel.notificationList.first {
            XCTAssertEqual(
                firstNotification.status, notifications.first?.status,
                "The status of the notification should match the mock data"
            )
            XCTAssertEqual(
                firstNotification.updateDateTime, notifications.first?.updateDateTime,
                "The updateDateTime of the notification should match the mock data"
            )
            XCTAssertEqual(
                firstNotification.title, notifications.first?.title,
                "The title of the notification should match the mock data"
            )
            XCTAssertEqual(
                firstNotification.message, notifications.first?.message,
                "The message of the notification should match the mock data"
            )
        }
    }
    
    func testGetNotificationListFirstOpenFailure() {
        // prepare data
        viewModel.notificationList = [Notification(status: true, updateDateTime: "", title: "abc", message: "def")]
        // mock
        let error = APIError.requestFailed(url: "testURL", code: 400, message: "Bad Request")
        mockHTTPService.mockResult = Result<Response<NotificationMessages>, Error>.failure(error)
        viewModel.getNotificationListFirstOpen()
        XCTAssertTrue(viewModel.notificationList.isEmpty)
    }
    
    func testGetNotificationListPullRefreshSuccess() {
        let notifications = [Notification(status: true, updateDateTime: "", title: "abc", message: "def")]
        let notificationMessages = NotificationMessages(messages: notifications)
        let response = Response(msgCode: "200", msgContent: "Success", result: notificationMessages)
        mockHTTPService.mockResult = Result<Response<NotificationMessages>, Error>.success(response)
        
        viewModel.getNotificationListPullRefresh()
        
        XCTAssertFalse(viewModel.notificationList.isEmpty)
        XCTAssertEqual(
            viewModel.notificationList.count, notifications.count,
            "Notification list should have the same number of elements as in the mock response"
        )
        
        if let firstNotification = viewModel.notificationList.first {
            XCTAssertEqual(
                firstNotification.status, notifications.first?.status,
                "The status of the notification should match the mock data"
            )
            XCTAssertEqual(
                firstNotification.updateDateTime, notifications.first?.updateDateTime,
                "The updateDateTime of the notification should match the mock data"
            )
            XCTAssertEqual(
                firstNotification.title, notifications.first?.title,
                "The title of the notification should match the mock data"
            )
            XCTAssertEqual(
                firstNotification.message, notifications.first?.message,
                "The message of the notification should match the mock data"
            )
        }
    }
    
    func testGetNotificationListPullRefreshFailure() {
        // prepare data
        viewModel.notificationList = [Notification(status: true, updateDateTime: "", title: "abc", message: "def")]
        // mock
        let error = APIError.requestFailed(url: "testURL", code: 400, message: "Bad Request")
        mockHTTPService.mockResult = Result<Response<NotificationMessages>, Error>.failure(error)
        viewModel.getNotificationListPullRefresh()
        XCTAssertTrue(viewModel.notificationList.isEmpty)
    }
    
    // MARK: Favorite
    func testGetFavoriteListFirstOpenSuccess() {
        let favorites = [Favorite(nickname: "nameNe", transType: .Mobile)]
        let favoriteList = FavoriteList(favoriteList: favorites)
        let response = Response(msgCode: "200", msgContent: "Success", result: favoriteList)
        mockHTTPService.mockResult = Result<Response<FavoriteList>, Error>.success(response)
                
        viewModel.getFavoriteListFirstOpen()
        
        XCTAssertFalse(viewModel.favoriteList.isEmpty)
        XCTAssertEqual(
            viewModel.favoriteList.count, favorites.count,
            "Favorite list should have the same number of elements as in the mock response"
        )
        
        if let firstFavorite = viewModel.favoriteList.first {
            XCTAssertEqual(
                firstFavorite.nickname, favorites.first?.nickname,
                "The nickname of the favorite should match the mock data"
            )
            XCTAssertEqual(
                firstFavorite.transType, favorites.first?.transType,
                "The transType of the favorite should match the mock data"
            )
        }
    }
    
    func testGetFavoriteListFirstOpenFailure() {
        // prepare data
        viewModel.favoriteList = [Favorite(nickname: "nameNe", transType: .Mobile)]
        // mock
        let error = APIError.requestFailed(url: "testURL", code: 400, message: "Bad Request")
        mockHTTPService.mockResult = Result<Response<FavoriteList>, Error>.failure(error)
        viewModel.getFavoriteListFirstOpen()
        XCTAssertTrue(viewModel.favoriteList.isEmpty)
    }
    
    func testGetFavoriteListPullRefreshSuccess() {
        let favorites = [Favorite(nickname: "nameNe", transType: .Mobile)]
        let favoriteList = FavoriteList(favoriteList: favorites)
        let response = Response(msgCode: "200", msgContent: "Success", result: favoriteList)
        mockHTTPService.mockResult = Result<Response<FavoriteList>, Error>.success(response)

        viewModel.getFavoriteListPullRefresh()
        
        XCTAssertFalse(viewModel.favoriteList.isEmpty)
        XCTAssertEqual(
            viewModel.favoriteList.count, favorites.count,
            "Favorite list should have the same number of elements as in the mock response"
        )
        
        if let firstFavorite = viewModel.favoriteList.first {
            XCTAssertEqual(
                firstFavorite.nickname, favorites.first?.nickname,
                "The nickname of the favorite should match the mock data"
            )
            XCTAssertEqual(
                firstFavorite.transType, favorites.first?.transType,
                "The transType of the favorite should match the mock data"
            )
        }
    }
    
    func testGetFavoriteListPullRefreshFailure() {
        // prepare data
        viewModel.favoriteList = [Favorite(nickname: "nameNe", transType: .Mobile)]
        // mock
        let error = APIError.requestFailed(url: "testURL", code: 400, message: "Bad Request")
        mockHTTPService.mockResult = Result<Response<FavoriteList>, Error>.failure(error)
        viewModel.getFavoriteListPullRefresh()
        XCTAssertTrue(viewModel.favoriteList.isEmpty)
    }
    
    // MARK: Banner
    func testGetBannerListSuccess() {
        let banners = [Banner(adSeqNo: 10, linkUrl: "http://")]
        let bannerList = BannerList(bannerList: banners)
        let response = Response(msgCode: "200", msgContent: "Success", result: bannerList)
        mockHTTPService.mockResult = Result<Response<BannerList>, Error>.success(response)

        viewModel.getBannerList()
        
        XCTAssertFalse(viewModel.bannerList.isEmpty)
        XCTAssertEqual(
            viewModel.bannerList.count, banners.count,
            "Banner list should have the same number of elements as in the mock response"
        )
        
        if let firstBanner = viewModel.bannerList.first {
            XCTAssertEqual(
                firstBanner.adSeqNo, banners.first?.adSeqNo,
                "The adSeqNo of the banner should match the mock data"
            )
            XCTAssertEqual(
                firstBanner.linkUrl, banners.first?.linkUrl,
                "The linkUrl of the banner should match the mock data"
            )
        }
    }
    
    func testGetBannerListFailure() {
        // prepare data
        viewModel.bannerList = [Banner(adSeqNo: 10, linkUrl: "http://")]
        // mock
        let error = APIError.requestFailed(url: "testURL", code: 400, message: "Bad Request")
        mockHTTPService.mockResult = Result<Response<BannerList>, Error>.failure(error)
        viewModel.getBannerList()
        XCTAssertTrue(viewModel.bannerList.isEmpty)
    }
}

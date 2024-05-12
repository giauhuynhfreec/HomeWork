//
//  HomeViewModel.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let httpService: HTTPServiceProtocol
    
    @Published var notificationList: [Notification] = []
    // favorite
    @Published var isLoadingFavorite = false
    @Published var favoriteList: [Favorite] = []
    // banner
    @Published var isLoadingBanner = false
    @Published var bannerList: [Banner] = []
    
    // MARK: Constructor
    init(httpService: HTTPServiceProtocol = HTTPService()) {
        self.httpService = httpService
    }
    
    // MARK: Load FirstOpen/PullRefersh
    func loadFirstOpen() {
        // notification
        notificationList = []
        getNotificationListFirstOpen()
        
        // favorite
        favoriteList = []
        getFavoriteListFirstOpen()
        
        // banner
        bannerList = []
    }
    
    func loadPullRefresh() {
        getNotificationListPullRefresh()
        getFavoriteListPullRefresh()
        getBannerList()
    }
    
    // MARK: Notification
    func getNotificationListFirstOpen() {
        httpService.getRequest(
            urlString: "https://willywu0201.github.io/data/emptyNotificationList.json",
            responseType: Response<NotificationMessages>.self
        ) { result in
            switch result {
            case .success(let data):
                self.notificationList =  data.result.messages
            case .failure(let error):
                print(error)
                self.notificationList = []
            }
        }
    }
    
    func getNotificationListPullRefresh() {
        httpService.getRequest(
            urlString: "https://willywu0201.github.io/data/notificationList.json",
            responseType: Response<NotificationMessages>.self
        ) { result in
            switch result {
            case .success(let data):
                self.notificationList =  data.result.messages
            case .failure(let error):
                print(error)
                self.notificationList = []
            }
        }
    }
    
    // MARK: Favorite
    func getFavoriteListFirstOpen() {
        isLoadingFavorite = true
        httpService.getRequest(
            urlString: "https://willywu0201.github.io/data/emptyFavoriteList.json",
            responseType: Response<FavoriteList>.self
        ) { result in
            self.isLoadingFavorite = false
            switch result {
            case .success(let data):
                self.favoriteList =  data.result.favoriteList
            case .failure(let error):
                print(error)
                self.favoriteList = []
            }
        }
    }
    
    func getFavoriteListPullRefresh() {
        isLoadingFavorite = true
        httpService.getRequest(
            urlString: "https://willywu0201.github.io/data/favoriteList.json",
            responseType: Response<FavoriteList>.self
        ) { result in
            self.isLoadingFavorite = false
            switch result {
            case .success(let data):
                self.favoriteList =  data.result.favoriteList
            case .failure(let error):
                print(error)
                self.favoriteList = []
            }
        }
    }
    
    // MARK: Banner
    func getBannerList() {
        isLoadingBanner = true
        httpService.getRequest(
            urlString: "https://willywu0201.github.io/data/banner.json",
            responseType: Response<BannerList>.self
        ) { result in
            self.isLoadingBanner = false
            switch result {
            case .success(let data):
                self.bannerList = data.result.bannerList
            case .failure(let error):
                print(error)
                self.bannerList = []
            }
        }
    }
}

//
//  NotificationViewModel.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import Foundation

class NotificationViewModel: ObservableObject {
    private let httpService: HTTPServiceProtocol
    
    @Published var notificationList: [Notification] = []
    @Published var isLoading = false
    
    // MARK: Constructor
    init(httpService: HTTPServiceProtocol = HTTPService()) {
        self.httpService = httpService
    }
    
    // MARK: Notification
    func getNotificationList() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { // TODO: remove later
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/notificationList.json",
                responseType: Response<NotificationMessages>.self
            ) { result in
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.notificationList =  data.result.messages
                case .failure(let error):
                    print(error)
                    self.notificationList = []
                }
                
            }
        }
    }
}

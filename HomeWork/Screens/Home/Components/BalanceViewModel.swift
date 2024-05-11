//
//  BalanceViewModel.swift
//  HomeWork
//
//  Created by Giau Huynh on 11/05/2024.
//

import Foundation

class BalanceViewModel: ObservableObject {
    private let httpService: HTTPServiceProtocol
    
    @Published var isShowAccountBalance = false
    // usd
    @Published var usdProgress = 1.0
    @Published var usdBalance = 0.0
    // khr
    @Published var khrProgress = 1.0
    @Published var khrBalance = 0.0
    
    // MARK: Constructor
    init(httpService: HTTPServiceProtocol = HTTPService()) {
        self.httpService = httpService
    }
    
    // MARK: Load FirstOpen/PullRefersh
    func loadFirstOpen() {
        getUSDBalanceFirstOpen()
        getKHRBalanceFirstOpen()
    }
    
    func loadPullRefresh() {
        getUSDBalancePullRefresh()
        getKHRBalancePullRefresh()
    }
    
    // MARK: USD
    private func getUSDBalanceFirstOpen() {
        usdProgress = 0.0
        var savingsList: [Balance] = []
        var fixedDepositList: [Balance] = []
        var digitalList: [Balance] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/usdSavings1.json",
                responseType: Response<SavingsList>.self
            ) { result in
                self.usdProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    savingsList = data.result.savingsList
                case .failure(let error):
                    print(error)
                    savingsList = []
                }
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/usdFixed1.json",
                responseType: Response<FixedDepositList>.self
            ) { result in
                self.usdProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    fixedDepositList = data.result.fixedDepositList
                case .failure(let error):
                    print(error)
                    fixedDepositList = []
                }
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/usdDigital1.json",
                responseType: Response<DigitalList>.self
            ) { result in
                self.usdProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    digitalList = data.result.digitalList
                case .failure(let error):
                    print(error)
                    digitalList = []
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // Because the request doesn't specify how to display values from 3 lists: savings, fixedDeposit, digital.
            // So I came up with the logic below to be able to use all the lists.
            let savingsBalance = savingsList.filter { $0.curr == "USD" }.reduce(0) { $0 + $1.balance }
            let fixedDepositBalance = fixedDepositList.filter { $0.curr == "USD" }.reduce(0) { $0 + $1.balance }
            let digitalBalance = digitalList.filter { $0.curr == "USD" }.reduce(0) { $0 + $1.balance }
            self.usdBalance = savingsBalance + fixedDepositBalance + digitalBalance
            
            self.usdProgress = 1
        }
    }
    
    private func getUSDBalancePullRefresh() {
        usdProgress = 0.0
        var savingsList: [Balance] = []
        var fixedDepositList: [Balance] = []
        var digitalList: [Balance] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/usdSavings2.json",
                responseType: Response<SavingsList>.self
            ) { result in
                self.usdProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    savingsList = data.result.savingsList
                case .failure(let error):
                    print(error)
                    savingsList = []
                }
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/usdFixed2.json",
                responseType: Response<FixedDepositList>.self
            ) { result in
                self.usdProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    fixedDepositList = data.result.fixedDepositList
                case .failure(let error):
                    print(error)
                    fixedDepositList = []
                }
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/usdDigital2.json",
                responseType: Response<DigitalList>.self
            ) { result in
                self.usdProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    digitalList = data.result.digitalList
                case .failure(let error):
                    print(error)
                    digitalList = []
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // Because the request doesn't specify how to display values from 3 lists: savings, fixedDeposit, digital.
            // So I came up with the logic below to be able to use all the lists.
            let savingsBalance = savingsList.filter { $0.curr == "USD" }.reduce(0) { $0 + $1.balance }
            let fixedDepositBalance = fixedDepositList.filter { $0.curr == "USD" }.reduce(0) { $0 + $1.balance }
            let digitalBalance = digitalList.filter { $0.curr == "USD" }.reduce(0) { $0 + $1.balance }
            self.usdBalance = savingsBalance + fixedDepositBalance + digitalBalance
            
            self.usdProgress = 1
        }
    }
    
    // MARK: KHR
    private func getKHRBalanceFirstOpen() {
        khrProgress = 0.0
        var savingsList: [Balance] = []
        var fixedDepositList: [Balance] = []
        var digitalList: [Balance] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/khrSavings1.json",
                responseType: Response<SavingsList>.self
            ) { result in
                self.khrProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    savingsList = data.result.savingsList
                case .failure(let error):
                    print(error)
                    savingsList = []
                }
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/khrFixed1.json",
                responseType: Response<FixedDepositList>.self
            ) { result in
                self.khrProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    fixedDepositList = data.result.fixedDepositList
                case .failure(let error):
                    print(error)
                    fixedDepositList = []
                }
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // TODO: test
            self.httpService.getRequest( // TODO: remove self
                urlString: "https://willywu0201.github.io/data/khrDigital1.json",
                responseType: Response<DigitalList>.self
            ) { result in
                self.khrProgress += 1/3
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    digitalList = data.result.digitalList
                case .failure(let error):
                    print(error)
                    digitalList = []
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // Because the request doesn't specify how to display values from 3 lists: savings, fixedDeposit, digital.
            // So I came up with the logic below to be able to use all the lists.
            let savingsBalance = savingsList.filter { $0.curr == "KHR" }.reduce(0) { $0 + $1.balance }
            let fixedDepositBalance = fixedDepositList.filter { $0.curr == "KHR" }.reduce(0) { $0 + $1.balance }
            let digitalBalance = digitalList.filter { $0.curr == "KHR" }.reduce(0) { $0 + $1.balance }
            self.khrBalance = savingsBalance + fixedDepositBalance + digitalBalance
            
            self.khrProgress = 1
        }
    }
    
    private func getKHRBalancePullRefresh() {
        khrProgress = 0.0
        var savingsList: [Balance] = []
        var fixedDepositList: [Balance] = []
        var digitalList: [Balance] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.httpService.getRequest( // TODO: remove self
            urlString: "https://willywu0201.github.io/data/khrSavings2.json",
            responseType: Response<SavingsList>.self
        ) { result in
            self.khrProgress += 1/3
            dispatchGroup.leave()
            switch result {
            case .success(let data):
                savingsList = data.result.savingsList
            case .failure(let error):
                print(error)
                savingsList = []
            }
        }
        
        dispatchGroup.enter()
        self.httpService.getRequest( // TODO: remove self
            urlString: "https://willywu0201.github.io/data/khrFixed2.json",
            responseType: Response<FixedDepositList>.self
        ) { result in
            self.khrProgress += 1/3
            dispatchGroup.leave()
            switch result {
            case .success(let data):
                fixedDepositList = data.result.fixedDepositList
            case .failure(let error):
                print(error)
                fixedDepositList = []
            }
        }
        
        dispatchGroup.enter()
        self.httpService.getRequest( // TODO: remove self
            urlString: "https://willywu0201.github.io/data/khrDigital2.json",
            responseType: Response<DigitalList>.self
        ) { result in
            self.khrProgress += 1/3
            dispatchGroup.leave()
            switch result {
            case .success(let data):
                digitalList = data.result.digitalList
            case .failure(let error):
                print(error)
                digitalList = []
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // Because the request doesn't specify how to display values from 3 lists: savings, fixedDeposit, digital.
            // So I came up with the logic below to be able to use all the lists.
            let savingsBalance = savingsList.filter { $0.curr == "KHR" }.reduce(0) { $0 + $1.balance }
            let fixedDepositBalance = fixedDepositList.filter { $0.curr == "KHR" }.reduce(0) { $0 + $1.balance }
            let digitalBalance = digitalList.filter { $0.curr == "KHR" }.reduce(0) { $0 + $1.balance }
            self.khrBalance = savingsBalance + fixedDepositBalance + digitalBalance
            
            self.khrProgress = 1
        }
    }
}

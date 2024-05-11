//
//  Favorite.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import Foundation

struct FavoriteList: Decodable {
    let favoriteList: [Favorite]
}

struct Favorite: Decodable {
    let nickname: String
    let transType: TransType
}

enum TransType: String, Decodable {
    case CUBC, Mobile, PMF, CreditCard
    
    var image: String {
        switch self {
        case .CUBC:
            return "button00ElementScrollTree"
        case .Mobile:
            return "button00ElementScrollMobile"
        case .PMF:
            return "button00ElementScrollBuilding"
        case .CreditCard:
            return "button00ElementScrollCreditCard"
        }
    }
}

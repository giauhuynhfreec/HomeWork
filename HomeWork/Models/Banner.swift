//
//  Banner.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import Foundation

struct BannerList: Decodable {
    let bannerList: [Banner]
}

struct Banner: Decodable {
    let adSeqNo: Int
    let linkUrl: String
}

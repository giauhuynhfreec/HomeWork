//
//  Response.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import Foundation

struct Response<Result: Decodable>: Decodable {
    let msgCode: String
    let msgContent: String
    let result: Result
}

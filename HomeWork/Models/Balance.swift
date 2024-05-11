//
//  Balance.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import Foundation

struct Balance: Decodable {
    let account: String
    let curr: String
    let balance: Double
}

struct SavingsList: Decodable {
    let savingsList: [Balance]
}

struct FixedDepositList: Decodable {
    let fixedDepositList: [Balance]
}

struct DigitalList: Decodable {
    let digitalList: [Balance]
}

//
//  Notification.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import Foundation

struct NotificationMessages: Decodable {
    let messages: [Notification]
}

struct Notification: Decodable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}

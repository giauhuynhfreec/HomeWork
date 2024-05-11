//
//  TopBarView.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

struct TopBarView: View {
    @Binding var isActiveNotificationView: Bool
    let hasUnreadNotification: Bool
    
    var body: some View {
        HStack {
            Image("avatar")
                .resizable()
                .frame(width: 40, height: 40)
            Spacer()
            Image(hasUnreadNotification ? "iconBell02Active" : "iconBell01Nomal")
                .resizable()
                .frame(width: 24, height: 24)
                .asButton {
                    isActiveNotificationView = true
                }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .padding(.horizontal, 24)
    }
}

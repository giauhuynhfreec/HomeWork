//
//  HomeNavigationView.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

struct HomeNavigationView: View {
    @State private var isActiveNotificationView = false
    
    var body: some View {
        NavigationView {
            VStack {
                HomeView(isActiveNotificationView: $isActiveNotificationView)
                notificationLink
            }
            .navigationBarHidden(true)
        }
    }
    
    private var notificationLink: some View {
        NavigationLink(isActive: $isActiveNotificationView, destination: {
            NotificationView()
        }, label: {
            EmptyView()
        })
    }
}



//
//  TabBarView.swift
//  HomeWork
//
//  Created by Giau Huynh on 11/05/2024.
//

import SwiftUI

enum Tab: CaseIterable {
    case home, account, location, service
    
    var name: String {
        switch self {
        case .home:
            return "Home"
        case .account:
            return "Account"
        case .location:
            return "Location"
        case .service:
            return "Service"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "icTabbarHome"
        case .account:
            return "icTabbarAccount"
        case .location:
            return "icTabbarLocation"
        case .service:
            return "icTabbarService"
        }
    }
}

struct TabBarView: View {
    @State private var selection: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            container
            bar
        }
    }
    
    private var container: some View {
        Group {
            switch selection {
            case .home:
                HomeNavigationView()
            case .account:
                AccountView()
            case .location:
                LocationView()
            case .service:
                ServiceView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white1)
    }
    
    private var bar: some View {
        ZStack {
            Capsule()
                .fill(.white)
                .frame(height: 50)
                .padding(.horizontal, 24)
            
            HStack(spacing: 36) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    TabBarItem(tab: tab, isSelected: selection == tab)
                        .asButton {
                            selection = tab
                        }
                }
            }
        }
    }
}

struct TabBarItem: View {
    let tab: Tab
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 1) {
            Image(tab.icon)
                .renderingMode(.template)
                .resizable()
                .foregroundColor(isSelected ? .orange1 : .gray7)
                .frame(width: 24, height: 24)
                
            Text(tab.name)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(isSelected ? .orange1 : .gray7)
        }
    }
}

//
//  HomeView.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var balanceViewModel = BalanceViewModel()
    @Binding var isActiveNotificationView: Bool
        
    var body: some View {
        List {
            VStack(spacing: 0) {
                TopBarView(
                    isActiveNotificationView: $isActiveNotificationView,
                    hasUnreadNotification: !viewModel.notificationList.filter { $0.status == false }.isEmpty
                )
                    .padding(.bottom, 16)
                BalanceView(viewModel: balanceViewModel)
                    .padding(.bottom, 16)
                FeatureView()
                    .padding(.bottom, 30)
                FavoriteView(
                    favoriteList: viewModel.favoriteList,
                    isLoading: viewModel.isLoadingFavorite
                )
                    .padding(.bottom, 16)
                BannerView(
                    bannerList: viewModel.bannerList,
                    isLoading: viewModel.isLoadingBanner
                )
                    .padding(.bottom, 16)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color.white1)
        }
        .listStyle(.plain)
        .background(Color.white1)
        .onAppear {
            viewModel.loadFirstOpen()
            balanceViewModel.loadFirstOpen()
        }
        .refreshable {
            viewModel.loadPullRefresh()
            balanceViewModel.loadPullRefresh()
        }
    }
}

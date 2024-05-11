//
//  BannerView.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

struct BannerView: View {
    let bannerList: [Banner]
    let isLoading: Bool
    
    var body: some View {
        if isLoading {
            loading
        } else if bannerList.isEmpty {
            empty
        } else {
            BannerListView(bannerList: bannerList)
        }
    }
    
    private var loading: some View {
        VStack {
            ProgressView()
                .tint(.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 88)
    }
    
    private var empty: some View {
        ZStack {
            Rectangle()
                .fill(Color.white4)
                .cornerRadius(6)
            
            Rectangle()
                .fill(Color.white5)
                .frame(width: 48, height: 24)
                .cornerRadius(6)
            
            Text("AD")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 88)
        .padding(.horizontal, 24)
    }
}

struct BannerListView: View {
    let bannerList: [Banner]
    @State private var selection = 0
    @State private var lastDateChangedIndex = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 12) {
            tab
            indicator
        }
        .onChange(of: selection) { _ in
            lastDateChangedIndex = Date()
        }
        .onReceive(timer) { _ in
            if Date().timeIntervalSince(lastDateChangedIndex) >= 3 {
                withAnimation {
                    selection = (selection + 1) % bannerList.count
                }
            }
        }
    }
    
    private var tab: some View {
        TabView(selection: $selection) {
            ForEach(bannerList.indices, id: \.self) { index in
                AsyncImage(url: URL(string: bannerList[index].linkUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    ProgressView()
                        .tint(.black)
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle())
        .frame(height: 88)
        .padding(.horizontal, 24)
    }
    
    private var indicator: some View {
        HStack(spacing: 12) {
            ForEach(bannerList.indices, id: \.self) { index in
                Circle()
                    .fill(.black)
                    .opacity(selection == index ? 1 : 0.3)
                    .frame(width: 8, height: 8)
                    .asButton {
                        selection = index
                    }
            }
        }
    }
}

//
//  FavoriteView.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

struct FavoriteView: View {
    let favoriteList: [Favorite]
    let isLoading: Bool
    
    var body: some View {
        VStack {
            title
            if isLoading {
                loading
            } else if favoriteList.isEmpty {
                empty
            } else {
                list
            }
        }
    }
    
    private var title: some View {
        HStack {
            Text("My Favorite")
                .font(.system(size: 18, weight: .heavy))
                .foregroundColor(.gray5)
            Spacer()
            HStack {
                Text("More")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray7)
                Image("iconArrow01Next")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
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
        HStack(spacing: 12) {
            FavoriteItem(
                image: "button00ElementScrollEmpty",
                name: "- - -"
            )
            Text("You can add a favorite through the transfer or payment function.")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray6)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 16)
        }
        
        .frame(height: 88)
        .padding(.horizontal, 24)
    }
    
    private var list: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 24) {
                ForEach(favoriteList.indices, id: \.self) { index in
                    FavoriteItem(
                        image: favoriteList[index].transType.image,
                        name: favoriteList[index].nickname
                    )
                    .if(index == 0) {
                        $0.padding(.leading, 24)
                    }
                    .if(index == (favoriteList.count - 1)) {
                        $0.padding(.trailing, 24)
                    }
                }
            }
        }
        .frame(height: 88)
    }
}

struct FavoriteItem: View {
    let image: String
    let name: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 56, height: 56)
            Text(name)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray7)
        }
    }
}

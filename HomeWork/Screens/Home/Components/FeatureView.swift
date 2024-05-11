//
//  FeatureView.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

struct FeatureView: View {
    private let features = [
        Feature(name: "Transfer", icon: "button00ElementMenuTransfer"),
        Feature(name: "Payment", icon: "button00ElementMenuPayment"),
        Feature(name: "Utility", icon: "button00ElementMenuUtility"),
        Feature(name: "QR pay scan", icon: "button01Scan"),
        Feature(name: "My QR code", icon: "button00ElementMenuQRcode"),
        Feature(name: "Top up", icon: "button00ElementMenuTopUp"),
    ]
        
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())], spacing: 20) {
            ForEach(features.indices, id: \.self) { index in
                FeatureItem(feature: features[index])
            }
        }
    }
}

struct FeatureItem: View {
    let feature: Feature
    
    var body: some View {
        VStack {
            Image(feature.icon)
                .resizable()
                .frame(width: 56, height: 56)
            Text(feature.name)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray7)
        }
    }
}

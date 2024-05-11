//
//  BalanceView.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

struct BalanceView: View {
    @ObservedObject var viewModel: BalanceViewModel
        
    var body: some View {
        VStack(spacing: 16) {
            title

            BalanceItem(
                currency: "USD",
                isShowAccountBalance: viewModel.isShowAccountBalance,
                progress: viewModel.usdProgress,
                balance: viewModel.usdBalance
            )
            
            BalanceItem(
                currency: "KHR",
                isShowAccountBalance: viewModel.isShowAccountBalance,
                progress: viewModel.khrProgress,
                balance: viewModel.khrBalance
            )
        }
        .padding(.horizontal, 24)
    }
    
    private var title: some View {
        HStack {
            Text("My Account Balance")
                .font(.system(size: 18, weight: .heavy))
                .foregroundColor(.gray5)
            Image(viewModel.isShowAccountBalance ? "iconEye01On" : "iconEye02Off")
                .resizable()
                .frame(width: 24, height: 24)
                .asButton {
                    viewModel.isShowAccountBalance.toggle()
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BalanceItem: View {
    let currency: String
    let isShowAccountBalance: Bool
    let progress: Double
    let balance: Double
    
    private var balanceString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.string(from: NSNumber(value: balance)) ?? ""
    }
    
    var body: some View {
        VStack {
            title
            
            VStack {
                if progress < 1 {
                    loading
                } else {
                    value
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 24)
            
        }
    }
    
    private var title: some View {
        Text(currency)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.gray7)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var value: some View {
        Text(isShowAccountBalance ? balanceString : "********")
            .font(.system(size: 24, weight: .medium))
            .foregroundColor(.gray8)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var loading: some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(
                    stops: [
                        Gradient.Stop(color: .white1, location: 0.0),
                        Gradient.Stop(color: .white3, location: 1.0)],
                    startPoint: .trailing,
                    endPoint: UnitPoint(x: 0.3, y: 0.5)))
                .cornerRadius(6.0)
                .frame(width: progress * geometry.size.width, height: 24)
                .animation(.linear, value: progress)
        }
    }
}



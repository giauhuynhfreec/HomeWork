//
//  NotificationView.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

struct NotificationView: View {
    @StateObject private var viewModel = NotificationViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // set toolbar principal to change title color instead navigationTitle
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Notification")
                            .bold()
                            .foregroundColor(Color.gray10)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("iconArrowWTailBack")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .aspectRatio(contentMode: .fit)
                        .asButton {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .onAppear {
                viewModel.getNotificationList()
            }
    }
    
    private var content: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .tint(.black)
            } else {
                list
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white1)
    }
    
    private var list: some View {
        List(viewModel.notificationList.indices, id: \.self) { index in
            NotificationItem(notification: viewModel.notificationList[index])
                .if(index == viewModel.notificationList.count - 1) {
                    $0.padding(.bottom, 48)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .background(Color.white1)
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.getNotificationList()
        }
    }
}

struct NotificationItem: View {
    let notification: Notification
    
    var body: some View {
        VStack(spacing: 0) {
            Text(notification.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.gray10)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
                .if(!notification.status) { $0
                    .overlay(alignment: .topLeading) {
                        unread
                    }
                }
            
            Text(notification.updateDateTime)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray10)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 6)
            
            Text(notification.message)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.notificationMessage)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 16))
    }
    
    private var unread: some View {
        Circle()
            .fill(Color.orange1)
            .frame(width: 12, height: 12)
            .offset(x: -20, y: 4)
    }
}

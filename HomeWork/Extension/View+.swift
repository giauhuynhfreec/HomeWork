//
//  View+.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition { transform(self) } else { self }
    }
    
    @ViewBuilder
    func `if`<IfTransform: View, ElseTransform: View>(
        _ condition: Bool,
        if ifTransform: (Self) -> IfTransform,
        else elseTransform: (Self) -> ElseTransform
    ) -> some View {
        if condition { ifTransform(self) } else { elseTransform(self) }
    }
    
    func asButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self })
            .buttonStyle(.plain)
    }
}

struct LoadingViewModifier: ViewModifier {
    var isLoading: Bool
    
    init(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        if isLoading {
            ZStack {
                content
                ProgressView()
                    .tint(.red) // TODO: change later
            }
        } else {
            content
        }
    }
}

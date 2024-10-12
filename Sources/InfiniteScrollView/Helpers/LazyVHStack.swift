//
//  LazyVHStack.swift
//  InfiniteScrollView
//
//  Created by Brian Moyou on 12.10.24.
//

import SwiftUI

@available(macOS 12.0, *)
public struct LazyVHStack<Content: View>: View {
    let axis: Axis
    let spacing: CGFloat
    @ViewBuilder let content: () -> Content

    public var body: some View {
        Group {
            switch axis {
            case .vertical:
                LazyVStack(spacing: spacing) {
                    content()
                }
            case .horizontal:
                LazyHStack(spacing: spacing) {
                    content()
                }
            }
        }
    }
}

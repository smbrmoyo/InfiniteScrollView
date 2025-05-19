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
    let contentInsets: EdgeInsets
    @ViewBuilder let content: () -> Content
    
    public init(
            axis: Axis,
            spacing: CGFloat,
            contentInsets: EdgeInsets = .init(),
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.axis = axis
            self.spacing = spacing
            self.contentInsets = contentInsets
            self.content = content
        }

    public var body: some View {
        Group {
            switch axis {
            case .vertical:
                LazyVStack(spacing: spacing) {
                    content()
                }
                .padding(contentInsets)
            case .horizontal:
                LazyHStack(spacing: spacing) {
                    content()
                }
                .padding(contentInsets)
            }
        }
    }
}

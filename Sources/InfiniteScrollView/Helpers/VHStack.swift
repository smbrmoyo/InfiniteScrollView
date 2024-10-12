//
//  VHStack.swift
//  InfiniteScrollView
//
//  Created by Brian Moyou on 12.10.24.
//

import SwiftUI

@available(macOS 12.0, *)
public struct VHStack<Content: View>: View {
    var axis: Axis = .vertical
    @ViewBuilder let content: () -> Content

    public var body: some View {
        Group {
            switch axis {
            case .vertical:
                VStack {
                    content()
                }
            case .horizontal:
                HStack {
                    content()
                }
            }
        }
    }
}

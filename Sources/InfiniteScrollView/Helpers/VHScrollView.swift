//
//  VHScrollView.swift
//  InfiniteScrollView
//
//  Created by Brian Moyou on 12.10.24.
//

import SwiftUI

@available(macOS 12.0, *)
public struct VHScrollView<Content: View>: View {
    var axis: Axis = .vertical
    var refresh: () async -> () = {}
    @ViewBuilder let content: () -> Content

    public var body: some View {
        Group {
            switch axis {
            case .vertical:
                ScrollView {
                    content()
                }
                .refreshable {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    await refresh()
                }
            case .horizontal:
                ScrollView(.horizontal) {
                    content()
                }
            }
        }
    }
}


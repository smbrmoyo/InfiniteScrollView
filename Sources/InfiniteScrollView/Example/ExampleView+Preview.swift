//
//  ExampleView+Preview.swift
//  InfiniteScrollView
//
//  Created by Brian Moyou on 18.05.25.
//

import SwiftUI

#if DEBUG

struct PreviewItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
}

struct InfiniteScrollViewPreviewWrapper: View {
    @State private var items: [PreviewItem] = (1...20).map { PreviewItem(name: "Item \($0)") }
    @State private var canLoadMore = true
    
    var body: some View {
        TabView {
            InfiniteScrollView(
                items: items,
                canLoadMore: $canLoadMore,
                uiState: .idle,
                spacing: 8,
                loadMoreItems: {
                    await simulateLoadMore()
                },
                refresh: {
                    await simulateRefresh()
                },
                emptyView: {
                    Text("No items")
                },
                row: { item in
                    Text(item.name)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            )
            .contentInsets(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
            .tabItem {
                Image(systemName: "house")
            }
        }
    }
    
    private func simulateLoadMore() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let nextItems = (items.count+1...items.count+20).map {
            PreviewItem(name: "Item \($0)")
        }
        
        items.append(contentsOf: nextItems)
        canLoadMore = items.count < 100
    }
    
    private func simulateRefresh() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        items = (1...20).map { PreviewItem(name: "Item \($0)") }
        canLoadMore = true
    }
}

#Preview {
    InfiniteScrollViewPreviewWrapper()
}
#endif

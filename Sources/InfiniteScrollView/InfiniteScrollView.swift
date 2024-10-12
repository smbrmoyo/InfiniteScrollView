// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// `InfiniteScrollView` is a reusable view component that supports lazy loading and infinite scrolling.
/// It also allows refreshing of items via a pull-to-refresh gesture.
/// The component is generic over:
/// - `T`: The type of the items to be displayed, which must conform to `Identifiable` and `Equatable`.
/// - `EmptyContent`: A view type to display when there are no items (empty state).
/// - `Content`: A view type that represents a row of items in the scrollable list.
@available(iOS 15.0, macOS 12.0, tvOS 13.0, *)
public struct InfiniteScrollView<
    T: Identifiable & Equatable,
    EmptyContent: View,
    Content: View
>: View {
    
    // MARK: - Properties
    
    public var items: [T]
    @State public var isLoadingMore = false
    @Binding public var canLoadMore: Bool
    public var uiState: UIState
    public var spacing: CGFloat = 8
    
    public var loadMoreItems: () async -> ()
    public var refresh: () async -> ()
    @ViewBuilder public var emptyView: () -> EmptyContent
    @ViewBuilder public var row: (T) -> Content
    
    // MARK: - Initializer
    
    /**
     Initializes an `InfiniteScrollView` with the required parameters.
     - Parameters:
     - items: The `Array` of items to be displayed.
     - canLoadMore: A `Binding` to a `Bool` that determines if more items can be loaded.
     - uiState: The current state of the UI, used to show loading indicators or empty views.
     - spacing: The spacing between rows in the stack (default is 8).
     - loadMoreItems: A closure that is called to load more items when scrolling to the bottom.
     - refresh: A closure that is called to refresh the `ScrollView`  by pulling down.
     - emptyView: A `View` to display when the list is empty.
     - row: A `View` to display for each item in the list.
     */
    public init(items: [T],
                canLoadMore: Binding<Bool>,
                uiState: UIState,
                spacing: CGFloat = 8,
                loadMoreItems: @escaping () async -> () = {},
                refresh: @escaping () async -> () = {},
                @ViewBuilder emptyView: @escaping () -> EmptyContent,
                @ViewBuilder row: @escaping (T) -> Content) {
        self.items = items
        self._canLoadMore = canLoadMore
        self.uiState = uiState
        self.spacing = spacing
        self.loadMoreItems = loadMoreItems
        self.refresh = refresh
        self.emptyView = emptyView
        self.row = row
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack {
            if !items.isEmpty && uiState == .idle {
                ScrollView {
                    LazyVStack(spacing: spacing) {
                        ForEach(items) { item in
                            row(item)
                        }
                        
                        if canLoadMore {
                            ProgressView()
                                .padding()
                                .onAppear {
                                    loadMore()
                                }
                        }
                    }
                }
                .refreshable {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    await refresh()
                }
            } else if items.isEmpty && uiState == .loading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if items.isEmpty && uiState == .idle {
                emptyView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            await refresh()
        }
    }
    
    // MARK: - Functions
    
    /// Function to load more items. This prevents multiple concurrent loading requests.
    private func loadMore() {
        guard !isLoadingMore else { return }
        
        Task {
            isLoadingMore = true
            try? await Task.sleep(nanoseconds: 300_000_000)
            await loadMoreItems()
            isLoadingMore = false
        }
    }
}

import XCTest
import Testing
import SwiftUI
import ViewInspector
@testable import InfiniteScrollView

final class InfiniteScrollViewTests: XCTestCase {
    
    // Mock item model
    struct MockItem: Identifiable, Equatable {
        let id = UUID()
        let name: String
    }
    
    // Test for displaying the empty view when items are empty and UI is idle
    @MainActor
    func testEmptyView_whenItemsAreEmpty_andUIStateIdle() throws {
        // Given
        let items: [MockItem] = []
        let uiState: UIState = .idle
        let canLoadMore = Binding.constant(false)
        
        // Create the InfiniteScrollView
        let sut = InfiniteScrollView(
            items: items,
            canLoadMore: canLoadMore,
            uiState: uiState,
            emptyView: {
                Text("No items available")
            },
            row: { _ in
                Text("Row")
            }
        )
        
        // When: Inspect the view
        let inspection = try sut.inspect()
        
        // Then: Verify that the empty view is shown
        XCTAssertNoThrow(try inspection.find(text: "No items available"))
    }
    
    // Test for displaying a progress view when loading items
    @MainActor
    func testProgressView_whenItemsAreEmpty_andUIStateLoading() throws {
        // Given
        let items: [MockItem] = []
        let uiState: UIState = .loading
        let canLoadMore = Binding.constant(false)
        
        // Create the InfiniteScrollView
        let sut = InfiniteScrollView(
            items: items,
            canLoadMore: canLoadMore,
            uiState: uiState,
            emptyView: {
                Text("No items available")
            },
            row: { _ in
                Text("Row")
            }
        )
        
        // When: Inspect the view
        let inspection = try sut.inspect()
        
        // Then: Verify that the ProgressView is shown
        XCTAssertNoThrow(try inspection.find(ViewType.ProgressView.self))
    }
    
    // Test for loading more items when the user scrolls to the bottom
    @MainActor
    func testLoadMore_whenCanLoadMoreIsTrue() throws {
        // Given
        let items: [MockItem] = [
            MockItem(name: "Item 1"),
            MockItem(name: "Item 2")
        ]
        let canLoadMore = Binding.constant(true)
        let uiState: UIState = .idle
        
        // Closure to simulate loading more items
        let loadMoreItems: () async -> () = {
            
        }
        
        // Create the InfiniteScrollView
        let sut = InfiniteScrollView(
            items: items,
            canLoadMore: canLoadMore,
            uiState: uiState,
            loadMoreItems: loadMoreItems,
            refresh: {},
            emptyView: {
                Text("No items available")
            },
            row: { item in
                Text(item.name)
            }
        )
        
        // When: Inspect the view
        let inspection = try sut.inspect()
        // Trigger the loading more by simulating the ProgressView onAppear
        XCTAssertNoThrow(try inspection.find(ViewType.ProgressView.self))
    }
}


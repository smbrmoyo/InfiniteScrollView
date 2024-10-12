# InfiniteScrollView

![Swift Package](https://img.shields.io/badge/Swift-5.7-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%2013%2C%20macOS%2010.15-lightgrey.svg)

`InfiniteScrollView` is a customizable SwiftUI component that provides an infinite scrolling interface, enabling users to load more items dynamically. This package is perfect for applications that require pagination or continuous data loading, with built-in support for loading states, empty views, and refresh actions.

## Features

- **Dynamic Loading**: Automatically loads more items as the user scrolls.
- **Loading States**: Displays a loading indicator when fetching data.
- **Empty View Support**: Shows a customizable view when no items are available.
- **Refresh Functionality**: Allows users to refresh the list by pulling down.
- **Lightweight & Easy to Use**: Simple API and flexible customization options.

## Installation

### Swift Package Manager

You can add `InfiniteScrollView` to your project using Swift Package Manager. Add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/smbrmoyo/InfiniteScrollView.git", from: "1.0.0")
]
```

## Xcode

- Open your project in Xcode.
- Navigate to File > Add Packages.
- Enter the URL of the repository: https://github.com/<username>/<repo>.
- Choose the version you want to install and click Add Package.

## Usage

Here's a simple example of how to use InfiniteScrollView in your SwiftUI project:

```swift
import SwiftUI
import InfiniteScrollViewPackage

struct ContentView: View {
    @State private var items: [YourItemType] = []
    @State private var canLoadMore: Bool = true
    @State private var uiState: UIState = .idle

    var body: some View {
        InfiniteScrollView(
            items: items,
            canLoadMore: $canLoadMore,
            uiState: uiState,
            loadMoreItems: loadMore,
            refresh: refresh,
            emptyView: {
                Text("No items available")
            },
            row: { item in
                Text(item.title)
            }
        )
    }

    private func loadMore() async {
        // Load more items logic
    }

    private func refresh() async {
        // Refresh items logic
    }
}
]```

### Parameters
- items: An array of items to display.
- canLoadMore: A binding that indicates whether more items can be loaded.
- uiState: The current UI state (idle, loading, etc.).
- loadMoreItems: A closure that loads more items asynchronously.
- refresh: A closure that refreshes the item list asynchronously.
- emptyView: A view displayed when there are no items.
- row: A closure to define how each item should be displayed.

## Contribution

Contributions are welcome! Please feel free to submit a pull request or open an issue.

Fork the repository.
Create your feature branch: git checkout -b feature/MyFeature.
Commit your changes: git commit -m 'Add some feature'.
Push to the branch: git push origin feature/MyFeature.
Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

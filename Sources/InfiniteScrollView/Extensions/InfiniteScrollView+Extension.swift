//
//  InfiniteScrollView+Extension.swift
//  InfiniteScrollView
//
//  Created by Brian Moyou on 14.05.25.
//

import SwiftUI

extension InfiniteScrollView {
    public func contentInsets(_ insets: EdgeInsets) -> InfiniteScrollView {
        var copy = self
        copy.insets = insets
        return copy
    }
}

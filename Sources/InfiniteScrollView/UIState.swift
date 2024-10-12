//
//  UIState.swift
//  InfiniteScrollView
//
//  Created by Brian Moyou on 12.10.24.
//

import Foundation

/**
 `UIState` represents the current state of the infinite scroll view.
 - `idle`: The default state where the list is displayed or is empty.
 - `loading`: The state where the list is being loaded or refreshed.
 */
public enum UIState {
    case idle
    case loading
}

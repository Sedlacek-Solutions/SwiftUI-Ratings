//
//  Collection+SafeSubscript.swift
//
//  Created by James Sedlacek on 3/14/25.
//

/// A safe subscript for accessing elements in a collection.
extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

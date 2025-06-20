//
//  LocalizedStringKey+.swift
//
//  Created by James Sedlacek on 2/1/25.
//

import SwiftUI

@MainActor
extension LocalizedStringKey {
    public static let giveARating = LocalizedStringKey("Give a Rating")
    public static let helpUsGrow = LocalizedStringKey("Help Us Grow!")
    public static let maybeLater = LocalizedStringKey("Maybe Later")
    public static let networkError = LocalizedStringKey("Network Error!")
    public static let noRatingsYet = LocalizedStringKey("Be the first to rate us!")
    public static let noReviewsYet = LocalizedStringKey("No Reviews Yet")
    public static let tryAgain = LocalizedStringKey("Try Again")

    public static func ratings(_ count: Int) -> LocalizedStringKey {
        .init("\(count) ratings")
    }
}

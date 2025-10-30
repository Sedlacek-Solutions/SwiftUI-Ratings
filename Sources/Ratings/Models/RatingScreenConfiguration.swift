//
//  RatingScreenConfiguration.swift
//  Ratings
//
//  Created by Alpay Calalli on 11.03.25.
//

import SwiftUI

/// Configuration for customizing the appearance and content of the rating screen.
///
/// Use this struct to customize various aspects of the rating screen, including:
/// - The screen title
/// - Button titles
/// - Memoji images displayed
///
/// Example usage:
/// ```swift
/// let config = RatingScreenConfiguration(
///     screenTitle: .init("Rate Our App"),
///     primaryButtonTitle: .init("Rate Now"),
///     secondaryButtonTitle: .init("Not Now")
/// )
/// ```
@MainActor
public struct RatingScreenConfiguration {
    /// The main title displayed at the top of the rating screen.
    let screenTitle: LocalizedStringKey

    /// The title for the primary action button that initiates the rating process.
    let primaryButtonTitle: LocalizedStringKey

    /// The title for the secondary action button that allows users to postpone rating.
    let secondaryButtonTitle: LocalizedStringKey

    /// An array of memoji images to be displayed in the rating screen.
    let memojis: [Image]

    /// Creates a new rating screen configuration.
    ///
    /// - Parameters:
    ///   - screenTitle: The title shown at the top of the rating screen. Defaults to "Help Us Grow".
    ///   - primaryButtonTitle: The text for the main rating button. Defaults to "Give a Rating".
    ///   - secondaryButtonTitle: The text for the postpone button. Defaults to "Maybe Later".
    ///   - memojis: An array of images to be displayed as memojis. Defaults to a predefined set of memojis.
    public init(
        screenTitle: LocalizedStringKey = .helpUsGrow,
        primaryButtonTitle: LocalizedStringKey = .giveARating,
        secondaryButtonTitle: LocalizedStringKey = .maybeLater,
        memojis: [Image] = .defaultMemojis
    ) {
        self.screenTitle = screenTitle
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.memojis = memojis
    }
}

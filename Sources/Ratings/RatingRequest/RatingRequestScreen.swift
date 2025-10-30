//
//  RatingRequestScreen.swift
//
//  Created by James Sedlacek on 3/7/25.
//

import SwiftUI

/// An app rating request screen.
///
/// This structure handles fetching app ratings and reviews, managing the view state,
/// and providing actions for user interactions like submitting a rating or deferring.
@MainActor
public struct RatingRequestScreen {
    /// Action to perform when the user taps on the secondary button.
    let secondaryButtonAction: (() -> Void)?

    /// Configuration for the rating request screen.
    let configuration: RatingScreenConfiguration

    /// The App Store ID of the app for which ratings are being requested.
    private let appId: String

    /// The provider used to fetch app rating data.
    private let appRatingProvider: any AppRatingProviding

    /// Action to perform when the user taps on the primary button.
    private let primaryButtonAction: () -> Void

    /// Handler for errors that occur during data fetching.
    private let onError: ((Error) -> Void)?

    /// Environment value used to open URLs (like App Store review links).
    @Environment(\.openURL) private var openURL

    /// The current state of the view (loading, loaded with data, or error).
    @State var state: ViewState<AppRatingResponse> = .loading

    /// A subset of reviews to display in the UI.
    ///
    /// Returns at most 7 reviews from the loaded data, or an empty array if no data is available.
    var reviews: [Review] {
        let allReviews = state.value?.reviews ?? []
        return Array(allReviews.prefix(configuration.memojis.count))
    }

    /// The average rating of the app.
    ///
    /// Returns the loaded average rating or 5.0 if no data is available.
    var averageRating: Double {
        state.value?.averageRating ?? 5.0
    }

    /// The total number of ratings for the app.
    ///
    /// Returns the loaded total ratings count or 0 if no data is available.
    var totalRatings: Int {
        state.value?.totalRatings ?? 0
    }

    /// Indicates whether the view should show a "no ratings" state.
    var isShowingNoRatings: Bool {
        state.value?.totalRatings == 0 && !state.isLoading
    }

    /// Indicates whether the view should show a "no reviews" state.
    var isShowingNoReviews: Bool {
        reviews.isEmpty && !state.isLoading
    }

    /// Creates a new rating request screen view.
    ///
    /// - Parameters:
    /// 
    ///   - appId: The App Store ID of the app.
    ///   - appRatingProvider: The provider used to fetch app rating data.
    ///   - primaryButtonAction: Action to perform when the user taps on the primary button.
    ///   - secondaryButtonAction: Optional action to perform when the user taps on the secondary button.
    ///   - onError: Optional handler for errors that occur during data fetching.
    public init(
        configuration: RatingScreenConfiguration = .init(),
        appId: String,
        appRatingProvider: any AppRatingProviding,
        primaryButtonAction: @escaping () -> Void = {},
        secondaryButtonAction: (() -> Void)? = nil,
        onError: ((Error) -> Void)? = nil
    ) {
        self.configuration = configuration
        self.appId = appId
        self.appRatingProvider = appRatingProvider
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonAction = secondaryButtonAction
        self.onError = onError
    }

    /// Opens the App Store review page and performs the requested rating action.
    func ratingRequestAction() {
        guard let url = URL?.reviewRequest(for: appId) else { return }

        openURL(url)

        primaryButtonAction()
    }

    /// Fetches app rating data asynchronously.
    ///
    /// Updates the view state based on the result (loading, loaded, or error).
    @Sendable func fetchData() async {
        state = .loading
        do {
            let response = try await appRatingProvider.fetch()
            withAnimation {
                state = .loaded(response)
            }
        } catch {
            state = .error(error.localizedDescription)
            onError?(error)
        }
    }

    /// Retries fetching app rating data after an error occurs.
    func tryAgainAction() {
        Task {
            await fetchData()
        }
    }
}

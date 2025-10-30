import Foundation

/// A mock implementation of the `AppRatingProviding` protocol for testing and preview purposes.
///
/// This provider returns predefined app rating data and can simulate network delays and errors.
public struct MockAppRatingProvider: AppRatingProviding {
    /// The predefined response that will be returned by the `fetch` method.
    private let response: AppRatingResponse
    
    /// A flag indicating whether the `fetch` method should throw an error.
    private let shouldThrowError: Bool

    /// Errors that can be thrown by the mock provider.
    enum MockError: LocalizedError {
        /// A generic error used for testing error handling.
        case genericError

        /// A localized description of the error.
        public var errorDescription: String? {
            "A generic error occurred while fetching the app rating."
        }
    }

    /// Creates a new mock app rating provider with specified behavior.
    ///
    /// - Parameters:
    ///   - response: The predefined response that will be returned by the `fetch` method.
    ///   - shouldThrowError: A flag indicating whether the `fetch` method should throw an error.
    public init(
        response: AppRatingResponse,
        shouldThrowError: Bool = false
    ) {
        self.response = response
        self.shouldThrowError = shouldThrowError
    }

    /// Fetches the mock app rating data with a simulated delay.
    ///
    /// - Returns: The predefined `AppRatingResponse`.
    /// - Throws: `MockError.genericError` if `shouldThrowError` is `true`.
    public func fetch() async throws -> AppRatingResponse {
        // Simulating network delay
        try? await Task.sleep(nanoseconds: 3_000_000_000)

        if shouldThrowError {
            throw MockError.genericError
        }

        return response
    }
}

extension MockAppRatingProvider {
    /// A provider that returns an app with ratings but no reviews.
    public static let noReviews = MockAppRatingProvider(response: .init(
        averageRating: 4.8,
        totalRatings: 15,
        reviews: []
    ))

    /// A provider that returns an app with no ratings and no reviews.
    public static let noRatingsOrReviews = MockAppRatingProvider(response: .init(
        averageRating: 0.0,
        totalRatings: 0,
        reviews: []
    ))

    /// A provider that returns an app with ratings and a collection of mock reviews.
    public static let withMockReviews = MockAppRatingProvider(response: .init(
        averageRating: 4.2,
        totalRatings: 1250,
        reviews: .mock()
    ))

    /// A provider that simulates a network error when trying to fetch ratings.
    public static let throwsError = MockAppRatingProvider(
        response: .init(
            averageRating: 0.0,
            totalRatings: 0,
            reviews: []
        ),
        shouldThrowError: true
    )
}

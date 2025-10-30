import Foundation

/// A protocol defining the requirements for an app rating data provider.
///
/// Implementers of this protocol are responsible for fetching app rating and review data
/// from various sources such as app stores, databases, or mock data providers.
public protocol AppRatingProviding: Sendable {
    /// Fetches the app rating data asynchronously.
    ///
    /// - Returns: An `AppRatingResponse` containing the app rating information and reviews.
    /// - Throws: An error if the data cannot be fetched successfully.
    func fetch() async throws -> AppRatingResponse
}

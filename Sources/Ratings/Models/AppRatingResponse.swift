import Foundation

/// A model representing the response containing app rating information and reviews.
///
/// This structure encapsulates all the data related to an app's ratings and reviews,
/// including the average rating score, the total number of ratings received,
/// and a collection of individual reviews.
public struct AppRatingResponse: Decodable, Sendable {
    /// The average rating score of the app (typically on a scale of 1.0-5.0).
    public let averageRating: Double
    
    /// The total number of ratings the app has received.
    public let totalRatings: Int
    
    /// A collection of individual user reviews.
    public let reviews: [Review]
    
    /// Creates a new app rating response with the specified details.
    ///
    /// - Parameters:
    ///   - averageRating: The average rating score of the app.
    ///   - totalRatings: The total number of ratings the app has received.
    ///   - reviews: A collection of individual user reviews.
    public init(
        averageRating: Double,
        totalRatings: Int,
        reviews: [Review]
    ) {
        self.averageRating = averageRating
        self.totalRatings = totalRatings
        self.reviews = reviews
    }
}

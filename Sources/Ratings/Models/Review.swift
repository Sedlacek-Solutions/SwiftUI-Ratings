import Foundation

/// A model representing a user review with rating and metadata.
///
/// This struct encapsulates all information related to a single review, including
/// the review title, content, rating score, author information, and date.
public struct Review: Decodable, Sendable, Hashable {
    /// The title or headline of the review.
    public let title: String
    
    /// The main content or body text of the review.
    public let content: String
    
    /// The numerical rating given by the reviewer (typically on a scale of 1-5).
    public let rating: Int
    
    /// The name of the person who wrote the review.
    public let author: String
    
    /// The date when the review was submitted.
    public let date: Date

    /// Creates a new review with the specified details.
    ///
    /// - Parameters:
    ///   - title: The title or headline of the review.
    ///   - content: The main content or body text of the review.
    ///   - rating: The numerical rating given by the reviewer (typically 1-5).
    ///   - author: The name of the person who wrote the review.
    ///   - date: The date when the review was submitted.
    public init(
        title: String,
        content: String,
        rating: Int,
        author: String,
        date: Date
    ) {
        self.title = title
        self.content = content
        self.rating = rating
        self.author = author
        self.date = date
    }
}

extension Review {
    /// Creates a mock review for testing and preview purposes.
    ///
    /// - Parameter rating: The rating value to assign to the mock review (defaults to 4).
    /// - Returns: A fully populated mock `Review` instance.
    static func mock(rating: Int = 4) -> Review {
        Review(
            title: "Absolutely Love This App!",
            content: "This is an incredible app that has completely transformed how I work. The interface is intuitive, and the features are exactly what I needed. Highly recommend to everyone!",
            rating: rating,
            author: "John Appleseed",
            date: Date()
        )
    }
}

extension [Review] {
    /// Creates an array of mock reviews with different ratings and dates for testing and preview purposes.
    ///
    /// - Returns: An array containing 6 different mock review instances with varying content.
    static func mock() -> Self {
        [
            .mock(rating: 5),
            Review(
                title: "Great Potential",
                content: "Very promising app with some really useful features. Looking forward to future updates!",
                rating: 4,
                author: "Sarah Wilson",
                date: Date().addingTimeInterval(-86400) // Yesterday
            ),
            Review(
                title: "Needs Improvement",
                content: "Good concept but needs some work on performance.",
                rating: 3,
                author: "Mike Thompson",
                date: Date().addingTimeInterval(-172800) // 2 days ago
            ),
            Review(
                title: "Life Changing App",
                content: "I've been using this app for months now and it has completely changed how I organize my work. The recent updates make it even better!",
                rating: 5,
                author: "Emily Chen",
                date: Date().addingTimeInterval(-7776000) // 3 months ago
            ),
            Review(
                title: "Could Be Better",
                content: "The app is okay but crashes sometimes. Hope this gets fixed soon.",
                rating: 2,
                author: "David Brown",
                date: Date().addingTimeInterval(-15552000) // 6 months ago
            ),
            Review(
                title: "Basic Functionality",
                content: "It does what it promises but nothing extraordinary. Would like to see more features.",
                rating: 3,
                author: "Lisa Martinez",
                date: Date().addingTimeInterval(-31536000) // 1 year ago
            )
        ]
    }
}

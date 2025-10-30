//
//  RatingView.swift
//
//  Created by James Sedlacek on 3/7/25.
//

import SwiftUI

struct RatingView: View {
    private let rating: Double
    private let starCount: Int = 5
    private let spacing: CGFloat = 4

    init(rating: Double) {
        self.rating = rating
    }

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ratingWithLaurels
            starsView
        }
        .font(.title.bold())
    }

    private var ratingWithLaurels: some View {
        HStack(spacing: spacing) {
            Image(.laurelLeading)

            Text(rating.formatted(
                .number.precision(.fractionLength(1))
            ))
            .monospaced()

            Image(.laurelTrailing)
        }
    }

    private var starsView: some View {
        HStack(spacing: spacing) {
            ForEach(1...starCount, id: \.self) { position in
                starView(for: position)
            }
        }
    }

    private func starView(for position: Int) -> some View {
        Image(.star)
            .symbolVariant(.fill)
            .imageScale(.small)
            .foregroundStyle(starGradient(for: position))
    }

    private func starGradient(for position: Int) -> LinearGradient {
        LinearGradient(
            stops: [
                .init(color: .orange, location: getFillRatio(for: position)),
                .init(color: .secondary, location: getFillRatio(for: position))
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private func getFillRatio(for position: Int) -> CGFloat {
        let fill = Double(position) - rating
        return min(max(1 - fill, 0), 1)
    }
}

#Preview {
    @Previewable @State var rating: Double = 5.0

    VStack {
        RatingView(rating: rating)

        Slider(value: $rating, in: 0...5)
    }
    .padding(24)
}

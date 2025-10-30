//
//  ReviewCard.swift
//
//  Created by James Sedlacek on 3/7/25.
//

import SwiftUI

struct ReviewCard: View {
    let review: Review
    let memoji: Image

    init(
        review: Review,
        memoji: Image
    ) {
        self.review = review
        self.memoji = memoji
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            VStack(alignment: .leading, spacing: 6) {
                Text(review.title)
                    .font(.headline.weight(.semibold))
                Text(review.content)
                    .font(.body)
                Spacer(minLength: .zero)
            }
            HStack(spacing: 12) {
                memoji
                    .resizable()
                    .frame(width: 40, height: 40)
                    .background(.background.secondary)
                    .clipShape(.circle)

                VStack(alignment: .leading, spacing: 6) {
                    starRatingView

                    HStack(spacing: .zero) {
                        Text(review.author)
                            .foregroundStyle(.primary)
                        Text(" • ") + Text(review.date.relativeTime)
                            .foregroundStyle(.secondary)
                    }
                    .font(.caption.weight(.medium))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            .background.secondary,
            in: .rect(cornerRadius: 12)
        )
    }

    private var starRatingView: some View {
        HStack(spacing: 1.5) {
            ForEach(1...5, id: \.self) { index in
                Image(.star)
                    .symbolVariant(index <= review.rating ? .fill : .none)
                    .imageScale(.small)
                    .foregroundColor(.orange)
            }
        }
    }
}

#Preview {
    List {
        ReviewCard(
            review: .mock(),
            memoji: Image(.person1)
        )
        .listRowSeparator(.hidden)

        ReviewCard(
            review: .mock(),
            memoji: Image(.person1)
        )
        .redacted(reason: .placeholder)
        .listRowSeparator(.hidden)
    }
    .scrollContentBackground(.hidden)
    .listSectionSeparator(.hidden)
    .listSectionSpacingIfAvailable()
    .listStyle(.plain)
    .padding()
}

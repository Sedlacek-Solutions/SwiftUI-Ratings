//
//  TryAgainView.swift
//
//  Created by James Sedlacek on 3/14/25.
//

import SwiftUI

/// A view that displays an error state with a try again button.
struct TryAgainView: View {
    let errorMessage: String
    let tryAgainAction: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label(.networkError, symbol: .exclamationmarkTriangle)
        } description: {
            Text(errorMessage)
        } actions: {
            Button(
                action: tryAgainAction,
                label: {
                    Text(.tryAgain)
                        .font(.headline.weight(.semibold))
                        .frame(height: 42)
                        .padding(.horizontal)
                }
            )
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}

#Preview {
    TryAgainView(
        errorMessage: "Failed to load content",
        tryAgainAction: {}
    )
}

//
//  NoReviewsView.swift
//
//  Created by James Sedlacek on 3/14/25.
//

import SwiftUI

struct NoReviewsView: View {
    var body: some View {
        ContentUnavailableView(.noReviewsYet, symbol: .squareAndPencil)
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(
                .background.secondary,
                in: .rect(cornerRadius: 20)
            )
            .padding(20)
    }
}

#Preview {
    NoReviewsView()
}

//
//  MemojisStack.swift
//
//  Created by James Sedlacek on 3/7/25.
//

import SwiftUI

struct MemojisStack: View {
    let memojis: [Image]
    var body: some View {
        HStack(alignment: .center, spacing: -10) {
            memoji(at: 1)
                .zIndex(3)

            memoji(at: 2)
                .zIndex(2)

            memoji(at: 3)
                .zIndex(1)
        }
    }

    @ViewBuilder
    private func memoji(at index: Int) -> some View {
        if let memoji = memojis[safe: index] {
            memoji
                .resizable()
                .frame(width: 40, height: 40)
                .background(.background.secondary)
                .clipShape(.circle)
                .background(
                    Circle()
                        .stroke(.background, lineWidth: 4)
                )
        }
    }
}

#Preview {
    MemojisStack(memojis: .defaultMemojis)
        .padding()
}

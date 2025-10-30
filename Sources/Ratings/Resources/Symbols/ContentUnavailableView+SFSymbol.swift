//
//  ContentUnavailableView+SFSymbol.swift
//
//  Created by James Sedlacek on 3/10/25.
//

import SwiftUI

extension ContentUnavailableView where Label == SwiftUI.Label<Text, Image>, Description == Text? {
    package nonisolated init(
        _ titleKey: LocalizedStringKey,
        symbol: Image.SFSymbol,
        description: LocalizedStringKey? = nil,
        @ViewBuilder actions: () -> Actions = { EmptyView() }
    ) {
        self.init(
            label: {
                Label(titleKey, systemImage: symbol.rawValue)
            },
            description: {
                if let description {
                    Text(description)
                }
            },
            actions: actions
        )
    }
}

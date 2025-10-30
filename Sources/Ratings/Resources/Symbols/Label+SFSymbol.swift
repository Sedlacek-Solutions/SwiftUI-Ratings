//
//  Label+SFSymbol.swift
//
//  Created by James Sedlacek on 3/10/25.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    package nonisolated init(
        _ titleKey: LocalizedStringKey,
        symbol: Image.SFSymbol
    ) {
        self.init(titleKey, systemImage: symbol.rawValue)
    }

    package nonisolated init(
        _ titleKey: String,
        symbol: Image.SFSymbol
    ) {
        self.init(titleKey, systemImage: symbol.rawValue)
    }
}

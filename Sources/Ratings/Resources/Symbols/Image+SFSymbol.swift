//
//  Image+SFSymbol.swift
//
//  Created by James Sedlacek on 3/10/25.
//

import SwiftUI

extension Image {
    package enum SFSymbol: String {
        case exclamationmarkTriangle = "exclamationmark.triangle"
        case laurelLeading = "laurel.leading"
        case laurelTrailing = "laurel.trailing"
        case squareAndPencil = "square.and.pencil"
        case star
    }

    package init(_ symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}

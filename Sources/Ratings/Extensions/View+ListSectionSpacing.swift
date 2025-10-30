//
//  View+ListSectionSpacing.swift
//
//  Created by James Sedlacek on 3/8/25.
//

import SwiftUI

extension View {
    func listSectionSpacingIfAvailable(_ spacing: CGFloat = 8) -> some View {
        #if os(iOS)
        if #available(iOS 17.0, *) {
            return listSectionSpacing(spacing)
        } else {
            return self
        }
        #else
        return self
        #endif
    }
}

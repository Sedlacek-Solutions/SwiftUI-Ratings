//
//  URL+Constants.swift
//
//  Created by James Sedlacek on 3/10/25.
//

import Foundation

extension URL? {
    static func reviewRequest(for appId: String) -> URL? {
        URL(string: "https://apps.apple.com/app/id\(appId)?action=write-review")
    }
}

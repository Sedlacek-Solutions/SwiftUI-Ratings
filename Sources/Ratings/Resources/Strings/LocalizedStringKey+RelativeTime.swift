//
//  LocalizedStringKey+RelativeTime.swift
//
//  Created by James Sedlacek on 3/8/25.
//

import SwiftUI

@MainActor
extension LocalizedStringKey {
    // Relative time strings
    static let oneYearAgo = LocalizedStringKey("1 year ago")
    static func yearsAgo(_ years: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(years) years ago")
    }
    
    static let oneMonthAgo = LocalizedStringKey("1 month ago")
    static func monthsAgo(_ months: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(months) months ago")
    }
    
    static let oneDayAgo = LocalizedStringKey("1 day ago")
    static func daysAgo(_ days: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(days) days ago")
    }
    
    static let oneHourAgo = LocalizedStringKey("1 hour ago")
    static func hoursAgo(_ hours: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(hours) hours ago")
    }
    
    static let oneMinuteAgo = LocalizedStringKey("1 minute ago")
    static func minutesAgo(_ minutes: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(minutes) minutes ago")
    }
    
    static let justNow = LocalizedStringKey("Just now")
}


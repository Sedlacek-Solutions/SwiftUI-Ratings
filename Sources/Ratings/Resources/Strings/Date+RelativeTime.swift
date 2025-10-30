//
//  Date+RelativeTime.swift
//
//  Created by James Sedlacek on 3/8/25.
//

import Foundation
import SwiftUI

extension Date {
    /// Returns a localized relative time string using the LocalizedStringKey extension
    @MainActor
    public var relativeTime: LocalizedStringKey {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: now)

        if let years = components.year, years > 0 {
            return years == 1 ? .oneYearAgo :  .yearsAgo(years)
        }
        if let months = components.month, months > 0 {
            return months == 1 ? .oneMonthAgo :  .monthsAgo(months)
        }
        if let days = components.day, days > 0 {
            return days == 1 ? .oneDayAgo :  .daysAgo(days)
        }
        if let hours = components.hour, hours > 0 {
            return hours == 1 ? .oneHourAgo :  .hoursAgo(hours)
        }
        if let minutes = components.minute, minutes > 0 {
            return minutes == 1 ? .oneMinuteAgo :  .minutesAgo(minutes)
        }
        return .justNow
    }
}

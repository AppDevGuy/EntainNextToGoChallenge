//
//  RaceCountDownStringHelper.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import Foundation

public class RaceCountDownStringHelper {}

// MARK: - Private Functions

fileprivate extension RaceCountDownStringHelper {


    func getDisplayTime(for epochTime: Double, date: Date) -> String {
        // Convert epoch time to Date
        let epochDate = Date(timeIntervalSince1970: epochTime)
        // Calculate the difference in seconds
        let diffInSeconds = Int(epochDate.timeIntervalSince(date))
        // Determine if there is a negative time difference for display.
        let isNegative = diffInSeconds < 0
        let absoluteSeconds = abs(diffInSeconds)
        // Determine what values need to be displayed.
        let hours = absoluteSeconds / 3600
        let minutes = (absoluteSeconds % 3600) / 60
        let seconds = (absoluteSeconds % 3600) % 60

        if hours > 0 {
            return "\(isNegative ? "-" : "")\(hours)h"
        } else if minutes >= 5 {
            return "\(isNegative ? "-" : "")\(minutes)m"
        } else if minutes > 0 {
            return "\(isNegative ? "-" : "")\(minutes)m \(seconds)s"
        } else {
            return "\(isNegative ? "-" : "")\(seconds)s"
        }
    }

}

// MARK: - Public Functions

public extension RaceCountDownStringHelper {

    /// Returns the display string for the provided race start time.
    func getDisplayString(for epochTime: Double, from date: Date = Date()) -> String {
        getDisplayTime(for: epochTime, date: date)
    }

}

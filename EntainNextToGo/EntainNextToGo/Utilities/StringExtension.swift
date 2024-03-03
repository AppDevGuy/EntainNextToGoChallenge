//
//  StringExtension.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation

extension String {
    
    /// Based on the categoryId string from the RaceSummary, will return a race category or .unknown.
    var raceCategory: RaceCategory {
        guard !self.isEmpty, let category = RaceCategory(rawValue: self) else { return .unknown }
        return category
    }

}

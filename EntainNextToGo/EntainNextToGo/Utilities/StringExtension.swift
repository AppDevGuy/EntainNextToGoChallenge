//
//  StringExtension.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation

extension String {
    
    /// Based on the categoryId string from the RaceSummary,
    var raceCategory: RaceCategory {
        guard !self.isEmpty else { return .unknown }
        if self == "9daef0d7-bf3c-4f50-921d-8e818c60fe61" { return .greyhound }
        if self == "4a2788f8-e825-4d36-9894-efd4baf1cfae" { return .horse }
        if self == "161d9be2-e909-4326-8c2c-35ed71fb460b" { return .harness }
        return .unknown
    }

}

//
//  RaceData.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation

/// The Race Data
struct RaceData: Codable {
    
    let nextToGoIds: [String]
    let raceSummaries: [String: RaceSummary]

    enum CodingKeys: String, CodingKey {
        case nextToGoIds = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }

}

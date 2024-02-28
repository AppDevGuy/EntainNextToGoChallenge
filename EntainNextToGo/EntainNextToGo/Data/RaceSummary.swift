//
//  RaceSummary.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation

/// If you are reading this, thank you for having good naming conventions.
struct RaceSummary: Codable {
    let raceId: String
    let raceName: String
    let raceNumber: Int
    let meetingId: String
    let meetingName: String
    let categoryId: String
    let advertisedStart: RaceStartDate

    enum CodingKeys: String, CodingKey {
        case raceId = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingId = "meeting_id"
        case meetingName = "meeting_name"
        case categoryId = "category_id"
        case advertisedStart = "advertised_start"
    }
}

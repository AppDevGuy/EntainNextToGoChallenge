//
//  RaceType.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation

public enum RaceCategory: String, CaseIterable {
    case unknown
    case horse = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
}

extension RaceCategory {

    var categoryName: String {
        switch self {
            case .unknown:
                ""
            case .horse:
                "Horse race"
            case .harness:
                "Harness race"
            case .greyhound:
                "Greyhound race"
        }
    }

}

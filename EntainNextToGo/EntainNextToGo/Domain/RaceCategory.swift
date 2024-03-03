//
//  RaceType.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation

/// The three race categorys which use the Neds Category ID.
///
/// You can generate a race category with RaceCategory(rawValue: String).
public enum RaceCategory: String, CaseIterable {
    /// If the category is unknown, unknown will be returned.
    case unknown
    /// Horse racing category
    case horse = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    /// Harness racing category
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    /// Greyhound racing category
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
}

extension RaceCategory {
    /// Will return a meaningful display description for the category.
    ///
    /// - Returns: "Horse race" for .horse, "Harness race" for .harness and "Greyhound race" for .greyhound.
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

//
//  Icons.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import Foundation

struct Icons {}

extension RaceCategory {

    /// Returns a SF Symbol Name
    var iconName: String {
        switch self {
            case .horse: "figure.equestrian.sports"
            case .harness: "figure.seated.side"
            case .greyhound: "dog.fill"
            case .unknown: "questionmark.diamond"
        }
    }

}

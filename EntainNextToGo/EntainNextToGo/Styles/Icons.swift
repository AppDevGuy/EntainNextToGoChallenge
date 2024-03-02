//
//  Icons.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import Foundation

struct Icons {
    static let chevronRight = "chevron.right"
    static let filter = "line.3.horizontal.decrease.circle"
    static let binoculars = "binoculars.fill"
    static let wifi = "wifi.exclamationmark"
}

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

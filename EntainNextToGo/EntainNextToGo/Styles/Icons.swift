//
//  Icons.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import SwiftUI

struct Icons {

    enum RaceType {
        case horse
        case harness
        case greyhound

        var iconName: String {
            switch self {
                case .horse:
                    "figure.equestrian.sports"
                case .harness:
                    "figure.seated.side"
                case .greyhound:
                    "dog.fill"
            }
        }
    }

}

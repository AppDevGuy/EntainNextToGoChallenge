//
//  RaceCategoryViewModel.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation
import SwiftUI

public final class RaceCategoryViewModel {
    /// The display categories
    let categories: [RaceCategory] = [.greyhound, .harness, .horse]
    /// The active categories
    @Binding private(set) var activeCategories: [RaceCategory]

    init(activeCategories: Binding<[RaceCategory]>) {
        self._activeCategories = activeCategories
    }
}

// MARK: - Public Methods

public extension RaceCategoryViewModel {

    func didTap(raceCategory category: RaceCategory) {
        if let index = activeCategories.firstIndex(of: category) {
            activeCategories.remove(at: index)
        } else {
            activeCategories.append(category)
        }
    }

}

//
//  RaceCategoryViewModel.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation
import SwiftUI

/// Race Category View Model recieves and displays the available and active routes. It response to user events to update the filters.
public final class RaceCategoryViewModel {
    /// The display categories
    let categories: [RaceCategory] = [.greyhound, .harness, .horse]
    /// The active categories which is bound to the root object in order to update the root object categories. 
    @Binding private(set) var activeCategories: [RaceCategory]

    init(activeCategories: Binding<[RaceCategory]>) {
        self._activeCategories = activeCategories
    }
}

// MARK: - Public Methods

public extension RaceCategoryViewModel {

    /// When the user selects a category, it will either be removed or added to the active routes.
    func didTap(raceCategory category: RaceCategory) {
        if let index = activeCategories.firstIndex(of: category) {
            activeCategories.remove(at: index)
        } else {
            activeCategories.append(category)
        }
    }

}

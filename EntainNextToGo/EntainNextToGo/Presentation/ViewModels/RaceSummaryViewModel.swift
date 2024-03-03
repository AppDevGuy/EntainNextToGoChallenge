//
//  RaceSummaryViewModel.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation

/// The Race Summary View Model  manages the content for each row in the Race List View.
@Observable public class RaceSummaryViewModel {
    /// The Race Summary Data Model.
    private(set) var raceSummary: RaceSummary
    /// The Race Count Down String Helper which is used for formatting the count down time display.
    private(set) var raceCountDownStringHelper = RaceCountDownStringHelper()
    /// The current date which by default is always now.
    var currentDate: Date = Date()

    init(raceSummary: RaceSummary) {
        self.raceSummary = raceSummary
    }

}

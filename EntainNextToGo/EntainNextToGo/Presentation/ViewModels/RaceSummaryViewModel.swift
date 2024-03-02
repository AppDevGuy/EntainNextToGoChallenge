//
//  RaceSummaryViewModel.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation

@Observable public class RaceSummaryViewModel {

    private(set) var raceSummary: RaceSummary
    private(set) var raceCountDownStringHelper = RaceCountDownStringHelper()
    var currentDate: Date = Date()

    init(raceSummary: RaceSummary) {
        self.raceSummary = raceSummary
    }

}

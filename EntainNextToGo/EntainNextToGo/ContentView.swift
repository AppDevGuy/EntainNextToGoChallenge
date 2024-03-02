//
//  ContentView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        RaceListView(
            viewModel:
                RaceListViewModel(
                    displayUpdateTimer: TimerManager(interval: 1),
                    raceSummaries: [
                        RaceSummary(
                            raceId: "1",
                            raceName: "The Neds Classic",
                            raceNumber: 1,
                            meetingId: "12345",
                            meetingName: "Sheffield Bags",
                            categoryId: RaceCategory.horse.rawValue,
                            advertisedStart: RaceStartDate(
                                seconds: Date().timeIntervalSince1970 + 10
                            )
                        ),
                        RaceSummary(
                            raceId: "1",
                            raceName: "The Neds Classic",
                            raceNumber: 2,
                            meetingId: "12345",
                            meetingName: "Sheffield Bags",
                            categoryId: RaceCategory.harness.rawValue,
                            advertisedStart: RaceStartDate(
                                seconds: Date().timeIntervalSince1970 + 25
                            )
                        ),
                        RaceSummary(
                            raceId: "1",
                            raceName: "The Neds Classic",
                            raceNumber: 3,
                            meetingId: "12345",
                            meetingName: "Sheffield Bags",
                            categoryId: RaceCategory.greyhound.rawValue,
                            advertisedStart: RaceStartDate(
                                seconds: Date().timeIntervalSince1970 + 140
                            )
                        ),
                        RaceSummary(
                            raceId: "1",
                            raceName: "The Neds Classic",
                            raceNumber: 4,
                            meetingId: "12345",
                            meetingName: "Sheffield Bags",
                            categoryId: RaceCategory.horse.rawValue,
                            advertisedStart: RaceStartDate(
                                seconds: Date().timeIntervalSince1970 + 340
                            )
                        ),
                    ]))
    }
}

#Preview {
    ContentView()
}

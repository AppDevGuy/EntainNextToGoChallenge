//
//  RaceListView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

struct RaceListView: View {
    
    private var viewModel: RaceListViewModel

    init(viewModel: RaceListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        // The main content
        List {
            ForEach(viewModel.raceSummaries, id: \.self.id) { summary in
                RaceSummaryView(viewModel: RaceSummaryViewModel(raceSummary: summary))
                    .background(Colors.Background.primary)
                    .listRowBackground(Colors.Background.primary)
            }
        }
        .background(Colors.Background.secondary)
        .id(viewModel.currentDate)
    }
}

#Preview {
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
                            seconds: Date().timeIntervalSince1970 + 40
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
                            seconds: Date().timeIntervalSince1970 + 240
                        )
                    ),
                ]))
}

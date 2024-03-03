//
//  RaceSummaryExpandedView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

/// When selecting a row in the Race List View, this view will appear showing more content about the race. 
struct RaceSummaryInformationView: View {
    
    @EnvironmentObject var router: Router
    private var raceSummary: RaceSummary

    init(raceSummary: RaceSummary) {
        self.raceSummary = raceSummary
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Sizes.Space.regular) {
            HStack(alignment: .top) {
                Text("Race Name:")
                    .subtitleStyle()
                Text(raceSummary.raceName)
                    .bodyStyle()
                Spacer()
            }
            HStack(alignment: .top) {
                Text("Meet Name:")
                    .subtitleStyle()
                Text(raceSummary.meetingName)
                    .bodyStyle()
                Spacer()
            }
            HStack(alignment: .top) {
                Text("State:")
                    .subtitleStyle()
                Text(raceSummary.venueState)
                    .bodyStyle()
                Spacer()
            }
            HStack(alignment: .top) {
                Text("Country:")
                    .subtitleStyle()
                Text(raceSummary.venueCountry)
                    .bodyStyle()
                Spacer()
            }
            HStack(alignment: .top) {
                Text("Category:")
                    .subtitleStyle()
                Text(raceSummary.categoryId.raceCategory.categoryName)
                    .bodyStyle()
                Spacer()
            }
            HStack(alignment: .top) {
                Text("Start Time:")
                    .subtitleStyle()
                Text("\(Date(timeIntervalSince1970: raceSummary.advertisedStart.seconds))")
                    .bodyStyle()
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, Sizes.Space.large)
        .navigationTitle("Race information")
        .accessibilityLabel(Text("Race Information: Race category \(raceSummary.categoryId.raceCategory.categoryName) for Meet \(raceSummary.meetingName). Race number \(raceSummary.raceNumber)"))
    }
}

#Preview {
    RaceSummaryInformationView(
        raceSummary: RaceSummary(
            raceId: "1",
            raceName: "The Neds Classic",
            raceNumber: 1,
            meetingId: "12345",
            meetingName: "Sheffield Bags",
            categoryId: RaceCategory.horse.rawValue,
            venueState: "WA",
            venueCountry: "AUS",
            advertisedStart: RaceStartDate(
                seconds: Date().timeIntervalSince1970 + 200
            )
        )
    )
}

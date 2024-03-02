//
//  RaceSummaryView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

struct RaceSummaryView: View {

    private var viewModel: RaceSummaryViewModel

    init(viewModel: RaceSummaryViewModel) {
        self.viewModel = viewModel
    }

    private var raceStartTimeTextColor: Color {
        let startTime = viewModel.raceSummary.advertisedStart.seconds
        let currentDiff = startTime - Date().timeIntervalSince1970
        let hasStarted = currentDiff < 0
        if hasStarted {
            return .red
        }
        let diff = abs(currentDiff)
        // Less than 5 minutes
        if diff < 5 * 60 {
            return Colors.Brand.primary
        }
        return Colors.Foreground.primary
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Sizes.Space.small) {
            HStack(spacing: Sizes.Space.small) {
                Image(systemName: viewModel.raceSummary.categoryId.raceCategory.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Sizes.Icon.large, height: Sizes.Icon.large)
                VStack(alignment: .leading, spacing: Sizes.Space.small) {
                    Text("\(viewModel.raceSummary.meetingName)")
                        .boldBodyStyle()
                    Text("Race: \(viewModel.raceSummary.raceNumber)")
                        .captionStyle()
                }
                .padding(.horizontal, Sizes.Space.regular)
                Spacer()
                Text(viewModel
                    .raceCountDownStringHelper
                    .getDisplayString(
                        for: viewModel.raceSummary.advertisedStart.seconds,
                        from: viewModel.currentDate
                    ))
                    .foregroundStyle(raceStartTimeTextColor)
                    .boldBodyStyle()
                    .padding(.horizontal, Sizes.Space.small)
                Image(systemName: Icons.chevronRight)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Colors.Foreground.secondary)
                    .frame(width: Sizes.Icon.small, height: Sizes.Icon.small)
            }
        }
        .accessibilityLabel(Text("\(viewModel.raceSummary.categoryId.raceCategory.categoryName) for Meet \(viewModel.raceSummary.meetingName) happening in \(viewModel.raceCountDownStringHelper.getDisplayString(for: viewModel.raceSummary.advertisedStart.seconds)). Race \(viewModel.raceSummary.raceNumber). Tap row to see more information."))
    }
}

#Preview {
    RaceSummaryView(
        viewModel: RaceSummaryViewModel(
            raceSummary:
                RaceSummary(
                    raceId: "1",
                    raceName: "The Neds Classic",
                    raceNumber: 1,
                    meetingId: "12345",
                    meetingName: "Sheffield Bags",
                    categoryId: RaceCategory.horse.rawValue,
                    advertisedStart: RaceStartDate(
                        seconds: Date().timeIntervalSince1970 + 200
                    )
                )
        )
    )
}

//
//  RaceListView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

/// The Race List View shows up-coming races and serves as the root view for the app.
struct RaceListView: View {
    
    @EnvironmentObject var router: Router
    private var viewModel: RaceListViewModel

    init(viewModel: RaceListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            if viewModel.raceSummaries.count < 1 {
                VStack(spacing: Sizes.Space.extraLarge) {
                    Spacer()
                    Image(systemName: viewModel.networkConnectivity.isNetworkConnected ? Icons.binoculars : Icons.wifi)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Colors.Brand.primary)
                    Spacer()
                    Text(
                        viewModel.isFetching ? "Sit tight, we're looking for your races." :
                        viewModel.networkConnectivity.isNetworkConnected ?
                        viewModel.activeRaceCategories.count < 1 ?
                        "Please update your filter selection." :
                            "No races available. Please check back later." :
                            "Please check your internet connection."
                    )
                    .multilineTextAlignment(.center)
                    .subtitleStyle()
                    Spacer()
                }
                .padding(Sizes.Space.extraLarge)
            } else {
                ForEach(viewModel.raceSummaries.indices, id: \.self) { index in
                    let summary = viewModel.raceSummaries[index]
                    RaceSummaryView(viewModel: RaceSummaryViewModel(raceSummary: summary))
                        .background(Colors.Background.primary)
                        .listRowBackground(Colors.Background.primary)
                        .onTapGesture {
                            router.navigateTo(.raceInformationView(summary))
                        }
                        .id(viewModel.currentDate)
                        .accessibilityIdentifier("\(AccessibilityIdentifiers.RaceListView.raceSummaryListRow)_\(index)")
                        .accessibilityAction {
                            router.navigateTo(.raceInformationView(summary))
                        }
                }
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifiers.RaceListView.raceList)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if viewModel.isFetching {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.0)
                } else if !viewModel.networkConnectivity.isNetworkConnected {
                    Image(systemName: Icons.wifi)
                        .foregroundColor(.red)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    router.navigateTo(.raceFilterView)
                }, label: {
                    Image(systemName: Icons.filter)
                })
                .accessibilityIdentifier(AccessibilityIdentifiers.RaceListView.categoryNavigationButton)
                .accessibilityAction {
                    router.navigateTo(.raceFilterView)
                }
            }
        }
        .navigationTitle("Next to go")
        .background(Colors.Background.secondary)
        .onAppear() {
            if viewModel.raceSummaries.count > 1 { return }
            viewModel.fetchData()
        }
    }
}

#Preview {
    RaceListView(
        viewModel:
            RaceListViewModel(displayUpdateTimer: TimerManager(interval: 1), raceDataServiceTimer: TimerManager(interval: 30), raceDataService: RaceDataService(), raceDataDisplayService: RaceDisplayDataService(currentDateTime: {
                Date()
            }), networkConnectivity: ConnectivityMonitor())
    )
}



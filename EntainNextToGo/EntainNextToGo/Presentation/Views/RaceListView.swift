//
//  RaceListView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

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
                ForEach(viewModel.raceSummaries, id: \.self.id) { summary in
                    RaceSummaryView(viewModel: RaceSummaryViewModel(raceSummary: summary))
                        .background(Colors.Background.primary)
                        .listRowBackground(Colors.Background.primary)
                        .onTapGesture {
                            router.navigateTo(.raceInformationView(summary))
                        }
                        .id(viewModel.currentDate)
                }
            }
        }
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
                }) {
                    Image(systemName: Icons.filter)
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



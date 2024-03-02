//
//  Router.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

/// @Observable macro is not playing nice with environmentObject yet so have to conform to ObservableObject
class Router: ObservableObject {

    /// Routes definition
    enum Route: Hashable {
        /// Default route
        case raceListView
        /// To view an individual race
        case raceInformationView(RaceSummary)
    }

    // Used to programatically control our navigation stack
    @Published var path: NavigationPath = NavigationPath()

    var raceListViewModel: RaceListViewModel

    // MARK: - Lifecycle

    init(raceListViewModel: RaceListViewModel) {
        self.raceListViewModel = raceListViewModel
    }

    // Builds the views
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
            case .raceListView:
                RaceListView(viewModel: raceListViewModel)
            case .raceInformationView(let raceSummary):
                RaceSummaryInformationView(raceSummary: raceSummary)
        }
    }

    // Used by views to navigate to another view
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }

    // Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }

    // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
}

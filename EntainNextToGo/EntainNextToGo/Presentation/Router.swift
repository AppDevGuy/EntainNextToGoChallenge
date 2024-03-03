//
//  Router.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

/// The Router is an observable object which is used for decoupling views and view models for the purpose of app navigation.
///
/// @Observable macro is not playing nice with environmentObject yet so have to conform to ObservableObject
class Router: ObservableObject {

    /// Routes definition.
    ///
    /// We only have 3 routes in the app:
    /// - The Race List View which is the default route.
    /// - The Race Information View which is displayed when selecting a row in the Race List View.
    /// - The Race Filter View which navigates to the catgeory selection view.
    enum Route: Hashable {
        /// Default route
        case raceListView
        /// To view an individual race
        case raceInformationView(RaceSummary)
        /// Race Filter View
        case raceFilterView
    }

    /// Used to programatically control our navigation stack
    @Published var path: NavigationPath = NavigationPath()
    /// Observe race list view model updates.
    @Bindable var raceListViewModel: RaceListViewModel

    // MARK: - Lifecycle

    /// The app home screen is the RaceListView and has depdency on a view model.
    init(raceListViewModel: RaceListViewModel) {
        self.raceListViewModel = raceListViewModel
    }

    /// Builds the views to conform to the routes.
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
            case .raceListView:
                RaceListView(viewModel: raceListViewModel)
            case .raceInformationView(let raceSummary):
                RaceSummaryInformationView(raceSummary: raceSummary)
            case .raceFilterView:
                RaceCategoryView(viewModel: RaceCategoryViewModel(activeCategories: $raceListViewModel.activeRaceCategories))
        }
    }

    /// Using the navigation controller, we can navigate to the specified route without tightly coupling references to any specific views.
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }

    /// Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }

    /// Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
}

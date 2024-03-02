//
//  EntainNextToGoApp.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import SwiftUI

@main
struct EntainNextToGoApp: App {

    let raceListViewModel = RaceListViewModel(
        displayUpdateTimer: TimerManager(interval: 1),
        raceDataServiceTimer: TimerManager(interval: 15),
        raceDataService: RaceDataService(),
        raceDataDisplayService:
            RaceDisplayDataService(
                raceExpirySeconds: Constants.RaceExpiryPeriod.seconds,
                currentDateTime: {
                    Date()
                }
            ),
        networkConnectivity: ConnectivityMonitor()
    )

    var body: some Scene {
        WindowGroup {
            // Create the Router instance
            let router = Router(raceListViewModel: raceListViewModel)

            // Pass the Router instance to RouterView
            RouterView(router: router) {
                router.view(for: .raceListView)
            }
        }
    }}

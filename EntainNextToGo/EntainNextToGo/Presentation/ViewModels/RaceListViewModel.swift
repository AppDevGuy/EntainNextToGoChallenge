//
//  RaceListViewModel.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation
import Combine

@Observable class RaceListViewModel {

    // MARK: - Variables

    private var cancellables: [AnyCancellable] = []
    // Timer for updating display
    private var displayUpdateTimer: TimerManager
    // Race Summary Data
    private(set) var raceSummaries: [RaceSummary]
    private(set) var currentDate = Date()

    // MARK: - Lifecycle

    init(displayUpdateTimer: TimerManager, raceSummaries: [RaceSummary]) {
        self.displayUpdateTimer = displayUpdateTimer
        self.raceSummaries = raceSummaries
        setupObservers()
    }

    deinit {
        cancellables.removeAll()
    }

}

// MARK: - Private Methods

private extension RaceListViewModel {

    func setupObservers() {
        displayUpdateTimer.start()
            .sink(receiveValue: { [weak self] updatedDate in
                guard let self else { return }
                self.currentDate = updatedDate
            })
            .store(in: &cancellables)
    }

}

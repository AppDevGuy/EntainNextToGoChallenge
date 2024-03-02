//
//  RaceListViewModel.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import Foundation
import Combine

@Observable public class RaceListViewModel {

    // MARK: - Variables

    private var cancellables: [AnyCancellable] = []
    /// Timer for updating display
    private let displayUpdateTimer: TimerManager
    /// Timer for fetching updated data
    private let raceDataServiceTimer: TimerManager
    /// The race data service which handles fetching new data.
    private let raceDataService: RaceDataService
    /// The Race Data Display Service
    private let _raceDataDisplayService: RaceDisplayDataService
    /// Observe changes in network connectivity,
    let networkConnectivity: NetworkMonitoringInterface
    /// Race Summary Data
    private(set) var raceSummaries: [RaceSummary] = []
    /// Setup the filter categories
    var activeRaceCategories: [RaceCategory] = [.greyhound, .harness, .horse] {
        didSet {
            _raceDataDisplayService.raceSummaryFilters = activeRaceCategories
            raceSummaries = _raceDataDisplayService.displayRaceSummaries
        }
    }
    /// Current date object is used to update the display.
    private(set) var currentDate = Date()
    /// Loading state
    private(set) var isFetching = true

    // MARK: - Lifecycle

    init(displayUpdateTimer: TimerManager, raceDataServiceTimer: TimerManager, raceDataService: RaceDataService, raceDataDisplayService: RaceDisplayDataService, networkConnectivity: NetworkMonitoringInterface) {
        self.displayUpdateTimer = displayUpdateTimer
        self.raceDataServiceTimer = raceDataServiceTimer
        self.raceDataService = raceDataService
        self._raceDataDisplayService = raceDataDisplayService
        self.networkConnectivity = networkConnectivity
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
                if self._raceDataDisplayService.shouldUpdateDisplay() {
                    self.updateRaceSummaries()
                }
            })
            .store(in: &cancellables)
        raceDataServiceTimer.start()
            .sink(receiveValue: { [weak self] updatedDate in
                guard let self else { return }
                self.isFetching = true
                self.fetchRaceData()
            })
            .store(in: &cancellables)
    }

    func fetchRaceData() {
        raceDataService.fetchRaceData(from: Constants.APIEndpoint.nextToGoMaximumURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                if case .failure(let error) = completion {
                    // Display an appropriate error.
                    self.isFetching = false
                }
            }, receiveValue: {[weak self] response in
                /// Use the result.
                self?.updateRaceDisplayService(with: response.data)
            })
            .store(in: &cancellables)
    }

    func updateRaceDisplayService(with raceData: RaceData) {
        let raceDataSummaries = raceData.raceSummaries.values
        let summaries = Array(raceDataSummaries)
        _raceDataDisplayService.updateRaceSummaries(with: summaries)
        updateRaceSummaries()
        isFetching = false
    }

    func updateRaceSummaries() {
        raceSummaries = _raceDataDisplayService.displayRaceSummaries
    }
}

// MARK: - Public Methods

public extension RaceListViewModel {

    func fetchData() {
        fetchRaceData()
    }

}

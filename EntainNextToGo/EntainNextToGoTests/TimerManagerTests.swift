//
//  TimerManagerTests.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 28/2/2024.
//

import XCTest
@testable import EntainNextToGo
import Combine

final class TimerManagerTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        cancellables = []
    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    // MARK: - Test Timer Fires at Expected Interval

    func testTimerPublishesUpdatesEverySecond() {
        // Use 1 second interval
        let timerManager = TimerManager(interval: 1)
        let expectation = XCTestExpectation(description: "Timer publishes updates")

        var updatesCount = 0

        timerManager.start()
            .sink { _ in
                updatesCount += 1
                // Wait for 2 updates to confirm timer is repeating
                if updatesCount == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Slightly more than 2 seconds to allow for timer setup and firing
        wait(for: [expectation], timeout: 2.5)

        XCTAssertEqual(updatesCount, 2, "Timer should have published 2 updates.")
    }

    func testTimerPublishesUpdatesEveryThreeSeconds() {
        // Use 1 second interval
        let timerManager = TimerManager(interval: 3)
        let expectation = XCTestExpectation(description: "Timer publishes updates")

        var updatesCount = 0

        timerManager.start()
            .sink { _ in
                updatesCount += 1
                // Wait for 2 updates to confirm timer is repeating
                if updatesCount == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Slightly more than 6 seconds to allow for timer setup and firing
        wait(for: [expectation], timeout: 6.5)

        XCTAssertEqual(updatesCount, 2, "Timer should have published 2 updates.")
    }

}

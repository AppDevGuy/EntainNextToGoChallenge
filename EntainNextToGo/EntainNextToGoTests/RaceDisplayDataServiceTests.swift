//
//  RaceDataFilteringTests.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 28/2/2024.
//

import XCTest
@testable import EntainNextToGo
import Combine

/// This test will use the 100 data results to ensure testing on races that have expired, filtering for 5 events and more.
final class RaceDisplayDataServiceTests: XCTestCase {

    // MARK: - Variables

    var jsonHelper: JSONFileHelper!
    var cancellables: Set<AnyCancellable> = []
    /// The time and date for creating the default data file was 27th Feb 19:56
    private let mockDefaultDate = Date(fromString: "27 02 2024 19:56:09")
    /// The time and date for creating the 100 results file was 28th Feb 21:52
    private let mock100Date = Date(fromString: "2 03 2024 14:32:56")
    /// Race Expiry Period
    private let expiry = Constants.RaceExpiryPeriod.seconds

    // MARK: - Life Cycle

    override func setUpWithError() throws {
        jsonHelper = JSONFileHelper()
        cancellables = []
    }

    override func tearDownWithError() throws {
        jsonHelper = nil
        cancellables.removeAll()
    }

    // MARK: - Show all valid races

    func testShouldReturnEmptyArrayOfDataForNoResults() throws {
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: []) {
            Date()
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 0)
    }

    /// -60 seconds hours worth of races
    func testShouldReturnListOfAllValidDefaultResults() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries) {
            date
        }
        // Three races have expired in the default data, should be only 7 valid results. 
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 7)
    }

    /// -24 hours worth of races
    func testShouldReturnListOfAllValidDefaultResultsForTheWholeDay() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceExpirySeconds: 60 * 60 * 24) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 10)
    }

    func testShouldReturnListOfAllValid100ResultsDefaultTime() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 44)
    }

    func testShouldReturnZeroResultsAllValid100ResultsNegative24Hours() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceExpirySeconds: -(60 * 60 * 24)) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 0)
    }

    // MARK: - Show only Horses & Harness

    /// Default data contains 0 races for horse and harness - all greyhounds
    func testShouldReturnListOfAllValidHorseAndHarnessRacesDefaultResults() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.horse, .harness]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 2)
    }

    /// 100 data only contains 19 races for horse and harness
    func testShouldReturnListOfAllValidHorseAndHarnessRaces100DataResults() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.horse, .harness]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 28)
    }

    // MARK: - Show only Harness & Hounds

    /// Default data only contains 7 races for harness & hounds
    func testShouldReturnListOfAllValidHarnessAndHoundsRacesDefaultResults() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.harness, .greyhound]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 7)
    }

    /// 100 data only contains 25 races for hounds and harness
    func testShouldReturnListOfAllValidHarnessAndHoundsRaces100DataResults() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.harness, .greyhound]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 25)
    }

    // MARK: - Show only Hounds & Horses

    /// Default data only contains 5 races for horse and hounds - all grey hound, no horse
    func testShouldReturnListOfAllValidHorseAndHoundsRacesDefaultResults() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.horse, .greyhound]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 5)
    }

    /// 100 data only contains 35 races for horse and harness
    func testShouldReturnListOfAllValidHorseAndHoundsRaces100DataResults() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.horse, .greyhound]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 35)
    }

    // MARK: - Show only Horses

    /// Default data only contains 0 races for horse
    func testShouldReturnListOfAllValidHorseRacesDefaultResults() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.horse]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 0)
    }

    /// 100 data only contains 19 races for horses
    func testShouldReturnListOfAllValidHorseRaces100DataResults() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.horse]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 19)
    }

    // MARK: - Show only Hounds

    /// Default data only contains 5 races for hounds
    func testShouldReturnListOfAllValidHoundsRacesDefaultResults() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.greyhound]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 5)
    }

    /// 100 data only contains 16 races for greyhound
    func testShouldReturnListOfAllValidHoundsRaces100DataResults() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.greyhound]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 16)
    }

    // MARK: - Show only Harness

    /// Default data only contains 2 races for harness
    func testShouldReturnListOfAllValidHarnessRacesDefaultResults() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.harness]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 2)
    }

    /// 100 data only contains 9 harness races
    func testShouldReturnListOfAllValidHarnessRaces100DataResults() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.harness]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 9)
    }

    // MARK: - Update the filters

    /// Default data only contains 2 races for harness and 5 for hounds
    func testShouldReturnListOfAllValidHarnessRacesDefaultResultsAfterUpdatingToHarnessAndHounds() throws {
        let date = try XCTUnwrap(mockDefaultDate)
        let raceSummaries = try getRaceData(for: .defaultRaceData)
        XCTAssertEqual(raceSummaries.count, 10)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.harness]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 2)
        raceDisplayDataService.raceSummaryFilters = [.harness, .greyhound]
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 7)
    }

    /// 100 data only contains 9 harness races and 16 hounds
    func testShouldReturnListOfAllValidHarnessRaces100DataResultsAfterUpdatingToHarnessAndHounds() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.harness]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 9)
        raceDisplayDataService.raceSummaryFilters = [.harness, .greyhound]
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 25)
    }

    /// 100 data only contains 9 harness races and 16 hounds and 19 horses
    func testShouldReturnListOfAllValidHarnessRaces100DataResultsAfterUpdatingToHorseAndHounds() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.harness]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 9)
        raceDisplayDataService.raceSummaryFilters = [.horse, .greyhound]
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 35)
    }

    /// 100 data only contains 9 harness races and 19 horses
    func testShouldReturnListOfAllValidHarnessRaces100DataResultsAfterUpdatingToHorseAndHarness() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries, raceSummaryFilters: [.harness]) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 9)
        raceDisplayDataService.raceSummaryFilters = [.horse, .harness]
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 28)
    }

    // MARK: - Data should be ordered

    func testShouldReturnResultsAreOrderedLowestEpochToHighestEpochDate() throws {
        let date = try XCTUnwrap(mock100Date)
        let raceSummaries = try getRaceData(for: .oneHundredRacesData)
        XCTAssertEqual(raceSummaries.count, 45)
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: raceSummaries) {
            date
        }
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 44)
        let lowest = try XCTUnwrap(raceDisplayDataService.displayRaceSummaries.first?.advertisedStart.seconds.rounded(.toNearestOrAwayFromZero))
        let highest = try XCTUnwrap(raceDisplayDataService.displayRaceSummaries.last?.advertisedStart.seconds.rounded(.toNearestOrAwayFromZero))
        XCTAssertTrue(lowest < highest)
    }

    // MARK: - Data Should Be Updated

    func testShouldReturnRaceSummaryDataNeedsUpdate() throws {
        let date = Date()
        let raceDisplayDataService = RaceDisplayDataService(raceSummaries: [RaceSummary(raceId: "", raceName: "", raceNumber: 1, meetingId: "", meetingName: "", categoryId: RaceCategory.harness.rawValue, advertisedStart: RaceStartDate(seconds: date.timeIntervalSince1970))], raceExpirySeconds: expiry) {
            Date()
        }
        XCTAssertFalse(raceDisplayDataService.shouldUpdateDisplay())
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 1)
        // Calling update should trigger the update and remove the number of items
        raceDisplayDataService.updateRaceSummaries(with: [RaceSummary(raceId: "", raceName: "", raceNumber: 1, meetingId: "", meetingName: "", categoryId: RaceCategory.harness.rawValue, advertisedStart: RaceStartDate(seconds: date.timeIntervalSince1970 - 61))])
        XCTAssertFalse(raceDisplayDataService.shouldUpdateDisplay())
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 0)
        raceDisplayDataService.updateRaceSummaries(with: [RaceSummary(raceId: "", raceName: "", raceNumber: 1, meetingId: "", meetingName: "", categoryId: RaceCategory.harness.rawValue, advertisedStart: RaceStartDate(seconds: date.timeIntervalSince1970 - 58))])
        XCTAssertFalse(raceDisplayDataService.shouldUpdateDisplay())
        XCTAssertEqual(raceDisplayDataService.displayRaceSummaries.count, 1)
        // Should need to be updated after 3 second
        sleep(3)
        XCTAssertTrue(raceDisplayDataService.shouldUpdateDisplay())
    }

}

private extension RaceDisplayDataServiceTests {

    func getRaceData(for jsonFileName: JSONFileName) throws -> [RaceSummary] {
        XCTAssertNoThrow(jsonHelper.getJSON(from: jsonFileName))
        // Create an expectation
        let expectation = XCTestExpectation(description: "Decode completes and returns a 200 status code and 10 results.")
        // Unwrapping success value, throw error if fails.
        let jsonData = try XCTUnwrap(jsonHelper.getJSON(from: jsonFileName).get())
        var summaries: [RaceSummary] = []
        // Decode the Data into the RaceResponse
        JSONUtility.decode(type: RaceResponse.self, from: jsonData)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        // Fail immediately on fail.
                        XCTFail("Decoding failed with error: \(error)")
                }
                // Fulfill the expectation when the stream completes
                expectation.fulfill()
            }, receiveValue: { response in
                let raceData = response.data
                let raceSummaries = raceData.raceSummaries.values
                // Convert Dictionary.Values to Array
                let summariesArray = Array(raceSummaries)
                summaries = summariesArray
            })
            .store(in: &cancellables)
        // Wait for the expectations to be fulfilled
        wait(for: [expectation], timeout: 2.0)
        return summaries
    }

}

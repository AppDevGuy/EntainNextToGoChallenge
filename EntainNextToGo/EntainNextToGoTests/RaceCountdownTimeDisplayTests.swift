//
//  RaceCountdownTimeDisplayTests.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 27/2/2024.
//

import XCTest
@testable import EntainNextToGo

/// Tests the conversion of date time into display time
///
/// These tests aim to reflect the experience provided on neds.com.au in the Next to Go feature.
final class RaceCountdownTimeDisplayTests: XCTestCase {

    // MARK: - Variables
    private let raceCountDownStringHelper = RaceCountDownStringHelper()

    // The time and date for creating the file was 27th February 19:55:09
    // Maintain this time for reference.
    private let mockDate = Date(fromString: "27 02 2024 19:56:09")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Test Seconds

    /// Should return "XXs" for no minutes and double digit seconds
    func testShouldReturnTwoDigitSecondsForZeroMinutesDoubleDigitSeconds() throws {
        let date = try XCTUnwrap(mockDate)
    }

    /// Should return "Xs" for no minutes and single digit seconds
    func testShouldReturnSingleDigitSecondsForZeroMinutesSingleDigitSeconds() throws {
        // TODO: Implement Test
        let date = try XCTUnwrap(mockDate)
    }

    /// Should return "-XXs" for negative no minutes and  double digit seconds
    func testShouldReturnNegativeTwoDigitSecondsForNegativeZeroMinutesDoubleDigitSeconds() throws {
        // TODO: Implement Test
    }

    /// Should return "Xs" for negative no minutes and single digit seconds
    func testShouldReturnNegativeSingleDigitSecondsForNegativeZeroMinutesSingleDigitSeconds() throws {
        // TODO: Implement Test
        let date = try XCTUnwrap(mockDate)
    }

    // MARK: - Test Minutes

    /// Should return "Xm Xs" for single digit minutes and single digit seconds under 4 minutes 59 seconds
    func testShouldReturnSingleDigitMinutesSingleDigitSecondsForSingleDigitMinutesSingleDigitSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709035215
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "4m 6s")
    }

    /// Should return "-Xm Xs" for negative single digit minutes and single digit seconds under 4 minutes 59 seconds
    func testShouldReturnNegativeSingleDigitMinutesSingleDigitSecondsForNegativeSingleDigitMinutesSingleDigitSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709034720
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "-4m 9s")
    }

    /// Should return "Xm XXs" for single digit minutes and single digit seconds under 4 minutes 59 seconds
    func testShouldReturnSingleDigitMinutesDoubleDigitSecondsForSingleDigitMinutesDoubleDigitSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709035220
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "4m 11s")
    }

    /// Should return "-Xm XXs" for negative single digit minutes and double digit seconds under 4 minutes 59 seconds
    func testShouldReturnNegativeSingleDigitMinutesDoubleDigitSecondsForNegativeSingleDigitMinutesDoubleDigitSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709034680
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "-4m 49s")
    }

    /// Should return "Xm" for single digit minutes and single digit seconds above 4 minutes 59 seconds
    func testShouldReturnSingleDigitMinutesForSingleDigitMinutesAnyDigitSeconds() throws {
        // Approximately 5 minutes
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709035320
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "5m")
    }

    /// Should return "XXm" for double digit minutes and single digit seconds above 9 minutes 59 seconds
    func testShouldReturnDoubleDigitMinutesForDoubleDigitMinutesAnyDigitSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709035620
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "10m")
    }

    // MARK: - Test Hours

    /// Should return "Xh" for single digit hour any digit minutes and any digit seconds above 59 minutes 59 seconds
    func testShouldReturnSingleDigitHourForSingleDigitHourAnyMinutesAnyDigitSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709038620
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "1h")
    }

    /// Should return "XXh" for double digit hour any digit minutes and any digit seconds above 9 hours 59 minutes 59 seconds
    func testShouldReturnDoubleDigitHourForDoubleDigitHourAnyMinutesAnyDigitSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709073080
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "10h")
    }

    // MARK: - Test Edge Cases

    /// Should return "5m" for exactly 5 minutes
    func testShouldReturn5mForFiveMinutesZeroSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709035269
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "5m")
    }

    /// Should return "4m 59s" for exactly 00:04:59
    func testShouldReturn4m59sForFourMinutesFiftyNineSeconds() throws {
        let date = try XCTUnwrap(mockDate)
        let epoch: TimeInterval = 1709035268
        let displayTime = raceCountDownStringHelper.getDisplayString(for: epoch, from: date)
        XCTAssertEqual(displayTime, "4m 59s")
    }

    /// Should return "59m 59s" for exactly 00:59:59
    func testShouldReturn59m59sForFiftyNineMinutesFiftyNineSeconds() throws {
        // TODO: Implement Test
        let date = try XCTUnwrap(mockDate)
    }

    /// Should return "-59s" for exactly -00:00:59
    func testShouldReturnNegative59sForNegativeFiftyNineSeconds() throws {
        // TODO: Implement Test
        let date = try XCTUnwrap(mockDate)
    }

    /// Should return "-1m 59s" for exactly -00:01:59
    func testShouldReturnNegative1m59sForNegative1minuteFiftyNineSeconds() throws {
        // TODO: Implement Test
        let date = try XCTUnwrap(mockDate)
    }

}

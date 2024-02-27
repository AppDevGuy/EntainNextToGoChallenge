//
//  RaceCountdownTimeDisplayTests.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 27/2/2024.
//

import XCTest

/// Tests the conversion of date time into display time
///
/// These tests aim to reflect the experience provided on neds.com.au in the Next to Go feature.
final class RaceCountdownTimeDisplayTests: XCTestCase {

    // TODO: Create RaceCountdownTimeDisplay property

    // TODO: Create a Custom Date Object that can work with the mock data
    // The time and date for creating the file was 27th February 7:55pm
    // Maintain this time for reference.

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Test Positive Time

    // MARK: Test Seconds

    /// Should return "XXs" for no minutes and double digit seconds
    func testShouldReturnTwoDigitSecondsForZeroMinutesDoubleDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "Xs" for no minutes and single digit seconds
    func testShouldReturnSingleDigitSecondsForZeroMinutesSingleDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "-XXs" for negative no minutes and  double digit seconds
    func testShouldReturnNegativeTwoDigitSecondsForNegativeZeroMinutesDoubleDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "Xs" for negative no minutes and single digit seconds
    func testShouldReturnNegativeSingleDigitSecondsForNegativeZeroMinutesSingleDigitSeconds() {
        // TODO: Implement Test
    }

    // MARK: Test Minutes

    /// Should return "Xm Xs" for single digit minutes and single digit seconds under 4 minutes 59 seconds
    func testShouldReturnSingleDigitMinutesSingleDigitSecondsForSingleDigitMinutesSingleDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "-Xm Xs" for negative single digit minutes and single digit seconds under 4 minutes 59 seconds
    func testShouldReturnNegativeSingleDigitMinutesSingleDigitSecondsForNegativeSingleDigitMinutesSingleDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "Xm XXs" for single digit minutes and single digit seconds under 4 minutes 59 seconds
    func testShouldReturnSingleDigitMinutesDoubleDigitSecondsForSingleDigitMinutesDoubleDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "-Xm XXs" for negative single digit minutes and double digit seconds under 4 minutes 59 seconds
    func testShouldReturnNegativeSingleDigitMinutesDoubleDigitSecondsForNegativeSingleDigitMinutesDoubleDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "Xm" for single digit minutes and single digit seconds above 4 minutes 59 seconds
    func testShouldReturnSingleDigitMinutesForSingleDigitMinutesAnyDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "XXm" for double digit minutes and single digit seconds above 9 minutes 59 seconds
    func testShouldReturnDoubleDigitMinutesForDoubleDigitMinutesAnyDigitSeconds() {
        // TODO: Implement Test
    }

    // MARK: Test Hours

    /// Should return "Xh" for single digit hour any digit minutes and any digit seconds above 59 minutes 59 seconds
    func testShouldReturnSingleDigitHourForSingleDigitHourAnyMinutesAnyDigitSeconds() {
        // TODO: Implement Test
    }

    /// Should return "XXh" for double digit hour any digit minutes and any digit seconds above 9 hours 59 minutes 59 seconds
    func testShouldReturnDoubleDigitHourForDoubleDigitHourAnyMinutesAnyDigitSeconds() {
        // TODO: Implement Test
    }

    // MARK: - Test Edge Cases

    /// Should return "5m" for exactly 5 minutes
    func testShouldReturn5mForFiveMinutesZeroSeconds() {
        // TODO: Implement Test
    }

    /// Should return "4m 59s" for exactly 00:04:59
    func testShouldReturn4m59sForFourMinutesFiftyNineSeconds() {
        // TODO: Implement Test
    }

    /// Should return "59m 59s" for exactly 00:59:59
    func testShouldReturn59m59sForFiftyNineMinutesFiftyNineSeconds() {
        // TODO: Implement Test
    }

    /// Should return "-59s" for exactly -00:00:59
    func testShouldReturnNegative59sForNegativeFiftyNineSeconds() {
        // TODO: Implement Test
    }

    /// Should return "-1m 59s" for exactly -00:01:59
    func testShouldReturnNegative1m59sForNegative1minuteFiftyNineSeconds() {
        // TODO: Implement Test
    }


}

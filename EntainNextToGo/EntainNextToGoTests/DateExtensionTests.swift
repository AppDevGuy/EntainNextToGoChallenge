//
//  DateExtensionTests.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 27/2/2024.
//

import XCTest

/// We create mock dates and therefore need to ensure our data is correct. 
final class DateExtensionTests: XCTestCase {

    // Helper function to create date components
    private func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.timeZone = TimeZone(identifier: "Australia/Perth")
        return Calendar.current.date(from: components)
    }

    // MARK: - Actual Mock Date

    func testMockDate() {
        let dateString = "27 02 2024 19:56:09"
        let expectedDate = createDate(year: 2024, month: 2, day: 27, hour: 19, minute: 56, second: 9)
        let dateFromString = Date(fromString: dateString)
        XCTAssertNotNil(dateFromString)
        XCTAssertEqual(dateFromString, expectedDate)
    }

    // MARK: - Valid Dates

    func testValidDate1() {
        let dateString = "24 02 2024 00:12:01"
        let expectedDate = createDate(year: 2024, month: 2, day: 24, hour: 0, minute: 12, second: 1)
        let dateFromString = Date(fromString: dateString)
        XCTAssertNotNil(dateFromString)
        XCTAssertEqual(dateFromString, expectedDate)
    }

    func testValidDate2() {
        let dateString = "24 02 2024 23:12:01"
        let expectedDate = createDate(year: 2024, month: 2, day: 24, hour: 23, minute: 12, second: 1)
        let dateFromString = Date(fromString: dateString)
        XCTAssertNotNil(dateFromString)
        XCTAssertEqual(dateFromString, expectedDate)
    }

    func testValidDate3() {
        let dateString = "24 12 2023 03:58:51"
        let expectedDate = createDate(year: 2023, month: 12, day: 24, hour: 03, minute: 58, second: 51)
        let dateFromString = Date(fromString: dateString)
        XCTAssertNotNil(dateFromString)
        XCTAssertEqual(dateFromString, expectedDate)
    }

    // MARK: - Invalid Dates

    func testInvalidDateMonth() {
        let dateString = "24 22 2024 00:12:01"
        XCTAssertNil(Date(fromString: dateString))
    }

    func testInvalidDateDay() {
        let dateString = "4 22 2024 00:12:01"
        XCTAssertNil(Date(fromString: dateString))
    }

    func testInvalidDateString() {
        let dateString = "Hello World"
        XCTAssertNil(Date(fromString: dateString))
    }

    func testEmptyDateString() {
        let dateString = ""
        XCTAssertNil(Date(fromString: dateString))
    }

}

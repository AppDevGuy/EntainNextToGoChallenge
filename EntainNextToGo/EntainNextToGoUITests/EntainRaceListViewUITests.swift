//
//  EntainRaceListViewUITests.swift
//  EntainNextToGoUITests
//
//  Created by Sean Smith on 3/3/2024.
//

import XCTest
@testable import EntainNextToGo

final class EntainRaceListViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Simple UI test to navigate to and from the Category View.
    func testNavigationFromRaceListViewToRaceCategoryAndBack() throws {
        let button = app.buttons["RaceCategoriesNavigationButton"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        // Go back
        let backButton = app.buttons["Next to go"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 3))
        backButton.tap()
    }

}

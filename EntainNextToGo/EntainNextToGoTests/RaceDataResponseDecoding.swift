//
//  RaceDataDecoding.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 28/2/2024.
//

import XCTest
@testable import EntainNextToGo
import Combine

final class RaceDataResponseDecoding: XCTestCase {

    // MARK: - Variables
    var jsonHelper: JSONFileHelper!
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Life Cycle

    override func setUpWithError() throws {
        jsonHelper = JSONFileHelper()
        cancellables = []
    }

    override func tearDownWithError() throws {
        jsonHelper = nil
        cancellables.removeAll()
    }

    // MARK: - Test the JSON Data Files

    func testDefaultJSONMockFileExists() throws {
        XCTAssertNoThrow(jsonHelper.getJSON(from: .defaultRaceData))
    }

    func testJSONDataIsValidStatusCode() throws {
        // Create an expectation
        let expectation = XCTestExpectation(description: "Decode completes and returns a 200 status code.")

        // Unwrapping success value, throw error if fails.
        let jsonData = try XCTUnwrap(jsonHelper.getJSON(from: .defaultRaceData).get())

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
                XCTAssertEqual(response.status, 200)
            })
            .store(in: &cancellables)

        // Wait for the expectations to be fulfilled
        wait(for: [expectation], timeout: 2.0)
    }

    func testJSONDataIsFileNotFound() throws {
        // Specify the expected error
        let expectedError = JSONLoadingError.fileNotFound(fileName: JSONFileName.noFileFound.rawValue)

        // Get the JSON Data eror
        let result = jsonHelper.getJSON(from: .noFileFound)

        // Check the error.
        switch result {
            case .success:
                XCTFail("Function was expected to fail, but returned data successfully.")
            case .failure(let error as JSONLoadingError):
                // If the error is of type JSONLoadingError, we can compare it
                XCTAssertEqual(error, expectedError, "The thrown error does not match the expected error.")
            case .failure:
                // This case handles any other Error types that might be thrown
                XCTFail("An unexpected error type was thrown.")
        }
    }

    // MARK: - Test Valid Mock Data Response

    func testJSONDataIsValid() throws {
        // Create an expectation
        let expectation = XCTestExpectation(description: "Decode completes and returns a 200 status code and 10 results.")

        // Unwrapping success value, throw error if fails.
        let jsonData = try XCTUnwrap(jsonHelper.getJSON(from: .defaultRaceData).get())

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
            }, receiveValue: { [weak self] response in
                do {
                    try self?.defaultRaceDataAssertions(for: response)
                } catch {
                    XCTFail("Default Race checks should be valid. \(error)")
                }
            })
            .store(in: &cancellables)

        // Wait for the expectations to be fulfilled
        wait(for: [expectation], timeout: 2.0)
    }

}

fileprivate extension RaceDataResponseDecoding {

    func defaultRaceDataAssertions(for response: RaceResponse) throws {
        XCTAssertEqual(response.status, 200)
        XCTAssertNotNil(response.data.raceSummaries)
        XCTAssertEqual(response.data.raceSummaries.count, 10)

        // Test race that has already started
        let oldRaceId = "d5048316-b424-47a3-8051-c31c76fc2141"
        XCTAssertNotNil(response.data.nextToGoIds.contains(oldRaceId))
        let oldRace = try XCTUnwrap(response.data.raceSummaries[oldRaceId])
        XCTAssertEqual(oldRace.raceName, "A1 Salvage & Hardware")
        XCTAssertEqual(oldRace.meetingName, "Mandurah")
        XCTAssertEqual(oldRace.meetingId, "51942b1a-08bc-4727-bc27-25a085539ec6")
        XCTAssertEqual(oldRace.advertisedStart.seconds, 1709034720)

        // Test race that is upcoming
        let upcomingRaceId = "bd7736b0-0f52-40e7-943f-ceb4dbd750c9"
        XCTAssertNotNil(response.data.nextToGoIds.contains(upcomingRaceId))
        let newRace = try XCTUnwrap(response.data.raceSummaries[upcomingRaceId])
        XCTAssertEqual(newRace.raceName, "Join Trotsynd Ms Pace")
        XCTAssertEqual(newRace.meetingName, "Gloucester Park")
        XCTAssertEqual(newRace.meetingId, "134aa709-d6bb-4974-86aa-12dc3731140b")
        XCTAssertEqual(newRace.advertisedStart.seconds, 1709035500)
    }

}

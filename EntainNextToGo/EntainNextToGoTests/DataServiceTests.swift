//
//  DataServiceTests.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 28/2/2024.
//

import XCTest
@testable import EntainNextToGo
import Combine

final class DataServiceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        cancellables.removeAll()
    }
    
    func testShouldHaveCorrectAPIEndpoint() {
        XCTAssertEqual(Constants.APIEndpoint.baseURL, "https://api.neds.com.au/rest/v1/racing/")
        XCTAssertEqual(Constants.APIEndpoint.nextToGoDefaultURL, "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=10")
        XCTAssertEqual(Constants.APIEndpoint.nextToGoMaximumURL, "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=100")
    }

    func testFetchRaceDataSuccess() {
        let mockFetcher = MockNetworkFetcher(jsonFileName: .defaultRaceData)
        let dataService = RaceDataService(networkFetcher: mockFetcher)
        let expectation = XCTestExpectation(description: "Fetch race data")

        dataService.fetchRaceData(from: URL(string: "https://example.com/data")!)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            }, receiveValue: {[weak self] response in
                do {
                    try self?.defaultRaceDataAssertions(for: response)
                } catch {
                    XCTFail("Default Race checks should be valid. \(error)")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchRaceDataFailedInvalidData() {
        let mockFetcher = MockNetworkFetcher(jsonFileName: .emptyRaceData)
        let dataService = RaceDataService(networkFetcher: mockFetcher)
        let expectation = XCTestExpectation(description: "Fail to fetch race data")

        dataService.fetchRaceData(from: URL(string: "https://example.com/data")!)
            .sink(receiveCompletion: { completion in
                if case .finished = completion {
                    XCTFail("Should not finish without error")
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Should fail to return a valid response.")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchRaceDataFailedError() {
        let urlError = URLError(.badURL)
        let mockFetcher = MockNetworkFetcher(jsonFileName: .emptyRaceData, mockError: urlError)
        let dataService = RaceDataService(networkFetcher: mockFetcher)
        let expectation = XCTestExpectation(description: "Fail to fetch race data")

        dataService.fetchRaceData(from: URL(string: "https://example.com/data")!)
            .sink(receiveCompletion: { completion in
                if case .failure(let failure as URLError) = completion {
                    XCTAssertEqual(failure, urlError)
                } else {
                    XCTFail("Should not finish without error")
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Should fail to return a valid response.")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

}

private extension DataServiceTests {

    func defaultRaceDataAssertions(for response: RaceResponse) throws {
        XCTAssertEqual(response.status, 200)
        XCTAssertNotNil(response.data.raceSummaries)
        XCTAssertEqual(response.data.raceSummaries.count, 10)

        // Test race that has already started
        // This race also contains some funci ASCII in the race name
        // Make sure it decodes fine.
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


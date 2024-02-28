//
//  MockNetworkManager.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation
import Combine
import EntainNextToGo

final class MockNetworkFetcher: NetworkInterface {

    private var jsonFileName: JSONFileName
    private var mockError: URLError?

    init(jsonFileName: JSONFileName, mockError: URLError? = nil) {
        self.jsonFileName = jsonFileName
        self.mockError = mockError
    }

    func fetchData(from url: URL) -> AnyPublisher<Data, URLError> {
        if let mockError = mockError {
            return Fail(outputType: Data.self, failure: mockError).eraseToAnyPublisher()
        }
        do {
            let data = try getJSONDecodData()
            return Just(data).setFailureType(to: URLError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: Data.self, failure: URLError(.cannotDecodeRawData)).eraseToAnyPublisher()
        }
    }

}

private extension MockNetworkFetcher {

    func getJSONDecodData() throws -> Data {
        let jsonFileHelper = JSONFileHelper()
        return try jsonFileHelper.getJSON(from: jsonFileName).get()
    }

}


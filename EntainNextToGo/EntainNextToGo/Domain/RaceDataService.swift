//
//  RaceDataService.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation
import Combine

/// Handle scenario for invalid URL.
public enum RaceDateServiceError: Error, Equatable {
    /// In the event the URL is invalid, return this error with the URL string.
    case invalidURL(String)
    /// In the event that the network request fails, return the network error.
    case networkError(URLError)
    /// In the event we recieved data but it did not conform to the Race Data Model, return this error.
    case decodingError(Error)

    public static func ==(lhs: RaceDateServiceError, rhs: RaceDateServiceError) -> Bool {
        switch (lhs, rhs) {
            case (.invalidURL(let a), .invalidURL(let b)):
                return a == b
            case (.networkError(let a), .networkError(let b)):
                return a == b
            case (.decodingError(let a), .decodingError(let b)):
                return a.localizedDescription == b.localizedDescription && (a as NSError).code == (b as NSError).code && (a as NSError).domain == (b as NSError).domain
            default:
                return false
        }
    }
}

/// Responsible for fetching the race data results from the endpoint.
class RaceDataService {

    private let networkFetcher: NetworkInterface

    /// Dependency inject the NetworkInterface. Default is the NetworkManager.
    init(networkFetcher: NetworkInterface = NetworkManager()) {
        self.networkFetcher = networkFetcher
    }

    /// Will fetch the RaceData.
    ///
    /// Using Combine, we will receive the error or race response data for processing.
    ///
    /// - Returns: A publisher with either a the RaceResponse resiult or an Error formatted to the RaceDataServiceError.
    func fetchRaceData(from urlString: String) -> AnyPublisher<RaceResponse, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: RaceDateServiceError.invalidURL("Invalid URL: \(urlString)")).eraseToAnyPublisher()
        }
        return networkFetcher.fetchData(from: url)
            .mapError { RaceDateServiceError.networkError($0) } // First, convert URLError to Error
            .flatMap { data in
                JSONUtility.decode(type: RaceResponse.self, from: data)
                    .mapError { RaceDateServiceError.decodingError($0) }
            }
            .eraseToAnyPublisher()
    }

}

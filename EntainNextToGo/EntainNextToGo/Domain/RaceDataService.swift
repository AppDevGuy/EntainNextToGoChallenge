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
    case invalidURL(String)
    case networkError(URLError)
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

    init(networkFetcher: NetworkInterface = NetworkManager()) {
        self.networkFetcher = networkFetcher
    }

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

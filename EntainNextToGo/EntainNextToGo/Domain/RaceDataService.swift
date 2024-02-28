//
//  RaceDataService.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation
import Combine

class RaceDataService {

    private let networkFetcher: NetworkInterface

    init(networkFetcher: NetworkInterface = NetworkManager()) {
        self.networkFetcher = networkFetcher
    }

    func fetchRaceData(from url: URL) -> AnyPublisher<RaceResponse, Error> {
        networkFetcher.fetchData(from: url)
            .mapError { $0 as Error } // First, convert URLError to Error
            .flatMap { data in
                JSONUtility.decode(type: RaceResponse.self, from: data)
            }
            .eraseToAnyPublisher()
    }

}

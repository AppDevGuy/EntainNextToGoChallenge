//
//  NetworkManager.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation
import Combine

class NetworkManager: NetworkInterface {

    func fetchData(from url: URL) -> AnyPublisher<Data, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
}

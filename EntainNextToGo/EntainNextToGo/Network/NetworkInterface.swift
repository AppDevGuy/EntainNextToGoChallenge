//
//  NetworkInterface.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation
import Combine

/// Network interface offers the function for fetching data from a URL.
public protocol NetworkInterface {
    /// Fetch data from a URL and using Combine, respond to success and fail. 
    func fetchData(from url: URL) -> AnyPublisher<Data, URLError>
}

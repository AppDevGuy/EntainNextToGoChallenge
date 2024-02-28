//
//  NetworkInterface.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation
import Combine

public protocol NetworkInterface {
    func fetchData(from url: URL) -> AnyPublisher<Data, URLError>
}

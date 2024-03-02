//
//  Constants.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation

enum Constants {

    struct APIEndpoint {
        /// The Base API URL
        static let baseURL = "https://api.neds.com.au/rest/v1/racing/"
        /// Default 10 races route
        static let currentTenRacesEndpoint = "?method=nextraces&count=10"
        /// Maximum results route
        static let currentMaximumRacesEndpoint = "?method=nextraces&count=100"
        /// Default route uses the next 10 races
        static let nextToGoDefaultURL = "\(baseURL)\(currentTenRacesEndpoint)"
        /// Maximum route uses next 100 races
        static let nextToGoMaximumURL = "\(baseURL)\(currentMaximumRacesEndpoint)"
    }

    struct RaceExpiryPeriod {
        /// The expiry time for the races is if they started 60 seconds ago
        static let seconds = 60
    }

}

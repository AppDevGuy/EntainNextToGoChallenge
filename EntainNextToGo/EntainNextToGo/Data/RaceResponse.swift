//
//  RaceResponse.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation

/// This model is the parent object for the Race Data response.
struct RaceResponse: Codable {
    /// HTTP Status Code.
    let status: Int
    /// The response data.
    let data: RaceData
}

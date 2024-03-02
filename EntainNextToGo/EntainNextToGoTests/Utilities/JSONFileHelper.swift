//
//  JSONFileHelper.swift
//  EntainNextToGoTests
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation

enum JSONLoadingError: Error, Equatable {
    /// If file is not found in bundle, throw this error
    case fileNotFound(fileName: String)
    /// If faile failed to load, throw this error.
    case unableToLoadData(fileName: String)
}

/// Cover some scenarios for network and possible states purposes.
enum JSONFileName: String {
    case defaultRaceData = "MockRaceData"
    case emptyRaceData = "EmptyRaceData"
    case fourHundredCodeRaceData = "FourHundredCodeRaceData"
    case oneHundredRacesData = "Mock100Races"
    // Do not create a file for this data
    case noFileFound = "no file found"
    // File is not json data
    // Do not create a file for this data
    case invalidData = "InvalidJSONData"
}

class JSONFileHelper {

    public func getJSON(from fileName: JSONFileName) -> Result<Data, Error> {
        guard let url = Bundle(for: type(of: self)).url(forResource: fileName.rawValue, withExtension: "json") else {
            return .failure(JSONLoadingError.fileNotFound(fileName: fileName.rawValue))
        }
        do {
            let jsonData = try Data(contentsOf: url)
            return .success(jsonData)
        } catch {
            return .failure(JSONLoadingError.unableToLoadData(fileName: fileName.rawValue))
        }
    }

}

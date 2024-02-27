//
//  DateExtension.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import Foundation

extension Date {

    /// Provide a date string in format "DD MM YYYY HH:MM:SS"
    ///
    /// We use a fixed string to ensure mock dates and mock data can be tested correctly.
    init?(fromString dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy HH:mm:ss"
        dateFormatter.locale = .current
        dateFormatter.timeZone = TimeZone(identifier: "Australia/Perth")
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        self = date
    }

}

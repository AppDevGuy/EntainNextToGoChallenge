//
//  URLValidator.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 3/3/2024.
//

import Foundation

extension String {
    
    /// Will determine if the String is a valid URL scheme.
    var isValidURLScheme: Bool {
        let components = URLComponents(string: self)
        // Check if the scheme is one of the allowed ones (e.g., http or https)
        guard let scheme = components?.scheme, ["http", "https"].contains(scheme) else {
            return false
        }
        // Check that host is present and only ASCII
        guard let host = components?.host, host.canBeConverted(to: .ascii) else {
            return false
        }
        return true
    }

}

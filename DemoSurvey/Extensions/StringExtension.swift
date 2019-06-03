//
//  StringExtension.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation

/// Concat URL string and add a '/' between them
///
/// - Parameters:
///   - lhs: The string stands before '/'
///   - rhs: The string needs to add after '/'
/// - Returns: URL
func / (lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}

extension String {

    /// Indicating whether a string has value or not
    var isNotEmpty: Bool {
        return !isEmpty
    }

    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

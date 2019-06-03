//
//  Session.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation

final class Session {

    static let shared = Session()

    private init() {}

    func getValue(for key: Key) -> String? {
        guard let value = ud.string(forKey: key.rawValue), value.isNotEmpty else {
            return nil
        }
        return value
    }

    func setValue(_ value: String, for key: Key) {
        guard value.trimmed.isNotEmpty else {
            ud.setValue(nil, forKey: key.rawValue)
            return
        }
        ud.set(value, forKey: key.rawValue)
    }
}

// MARK: - Key
extension Session {

    enum Key: String {
        case accessToken = "kAccessToken"
        case username = "kUsername"
        case password = "kPassword"
    }
}

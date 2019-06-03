//
//  AccessTokenInfo.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import ObjectMapper

final class AccessTokenInfo: Mappable {

    var accessToken: String = ""
    var tokenType: String = ""
    var expitesIn: Int = 0
    var createAt: Double = 0

    required init?(map: Map) {}

    init() {}

    func mapping(map: Map) {
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        expitesIn <- map["expires_in"]
        createAt <- map["created_at"]
    }
}

//
//  SupportTests.swift
//  DemoSurveyTests
//
//  Created by Tam Nguyen M. on 6/6/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

extension OHHTTPStubsResponse {

    func setRequestTime(requestTime req: TimeInterval = 0.01, responseTime res: TimeInterval = 0.01) -> Self {
        requestTime(req, responseTime: res)
        return self
    }
}

extension QuickSpec {

    func success() {
        expect(true) == true
    }
}

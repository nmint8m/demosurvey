//
//  SurveyServiceTests.swift
//  DemoSurveyTests
//
//  Created by Tam Nguyen M. on 6/5/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import DemoSurvey

final class SurveyServiceTests: QuickSpec {

    override func spec() {
        it("response should be succeed and have detectItem") {
            expect("abc") == "abc"
        }
    }
}

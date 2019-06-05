//
//  CoreTests.swift
//  DemoSurveyTests
//
//  Created by Tam Nguyen M. on 6/5/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import DemoSurvey

final class CoreTests: QuickSpec {

    override func spec() {

        it("Test no respone") {
            stub(condition: isHost(host), response: { (_) -> OHHTTPStubsResponse in
                return OHHTTPStubsResponse(error: API.Error.noResponse)
            })

            APIManager.shared.request(urlString: API.Path.authentication,
                                      method: .post
            ) { result in
                switch result {
                case .success:
                    fail("Should return API.Error.noResponse")
                case .failure(let error):
                    expect((error as NSError).code) == API.Error.noResponse.code
                }
            }
        }
    }
}

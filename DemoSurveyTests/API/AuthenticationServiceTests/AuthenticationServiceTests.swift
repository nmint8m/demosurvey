//
//  AuthenticationServiceTests.swift
//  DemoSurveyTests
//
//  Created by Tam Nguyen M. on 6/5/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import DemoSurvey

final class AuthenticationServiceTests: QuickSpec {

    override func spec() {

        beforeEach {
            Session.shared.setValue("", for: .accessToken)
        }

        describe("Test AuthenticationService") {

            it("Test getAccessToken success") {
                stub(condition: isHost(host) && isPath(Config.authenPath)) { _ -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile(Config.successFilePath, type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: Test.Error.fileNotFound)
                    }
                    return fixture(filePath: path, status: 200, headers: nil)
                        .setRequestTime()
                }

                waitUntil(timeout: 10) { done in
                    API.Authentication.getAccessToken() { result in
                        switch result {
                        case .success:
                            expect(Session.shared.getValue(for: .accessToken)) == "Bearer f8931eaf2fe071e40c0b594635edae607cc2ac41d84e12cac3a2b93c377f29da"
                        case .failure:
                            fail("Should return success")
                        }
                        done()
                    }
                }
            }

            it("Test getAccessToken failure") {
                stub(condition: isHost(host) && isPath(Config.authenPath)) { _ -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile(Config.errorFilePath, type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: Test.Error.fileNotFound)
                    }
                    return fixture(filePath: path, status: 401, headers: nil)
                        .setRequestTime()
                }

                waitUntil(timeout: 10) { done in
                    API.Authentication.getAccessToken() { result in
                        switch result {
                        case .success:
                            fail("Should return error")
                        case .failure(let error):
                           expect((error as NSError).code) == API.Error.unauthorized.code
                           expect(Session.shared.getValue(for: .accessToken)).to(beNil())
                        }
                        done()
                    }
                }
            }
        }

        afterEach {
            OHHTTPStubs.removeAllStubs()
        }
    }
}

extension AuthenticationServiceTests {

    private struct Config {
        static let authenPath = "/oauth/token"
        static let successFilePath = "AuthenticationTests-Success.json"
        static let errorFilePath = "AuthenticationTests-401Error.json"
    }
}

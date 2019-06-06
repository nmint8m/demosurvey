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

        describe("Test SurveyService") {

            it("Tests getSurveyList success") {
                stub(condition: isHost(host) && isPath(Config.authenPath), response: { _ -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile(Config.successFilePath, type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: Test.Error.fileNotFound)
                    }
                    return fixture(filePath: path, status: 200, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 100000) { done in
                    API.Survey.getSurveyList(page: 0) { result in
                        switch result {
                        case .success(let surveys):
                            expect(surveys.count) == 10
                        case .failure:
                            fail("Should return authorized success")
                        }
                        done()
                    }
                }
            }

            it("Tests getSurveyList success") {
                stub(condition: isHost(host) && isPath(Config.authenPath), response: { _ -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile(Config.noContentFilePath1, type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: Test.Error.fileNotFound)
                    }
                    return fixture(filePath: path, status: 200, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    API.Survey.getSurveyList(page: 0) { result in
                        switch result {
                        case .success(let surveys):
                            expect(surveys.count) == 0
                        case .failure(let error):
                            fail("Should return authorized success \(error)")
                        }
                        done()
                    }
                }
            }

            it("Tests getSurveyList success") {
                stub(condition: isHost(host) && isPath(Config.authenPath), response: { _ -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile(Config.noContentFilePath2, type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: Test.Error.fileNotFound)
                    }
                    return fixture(filePath: path, status: 200, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    API.Survey.getSurveyList(page: 0) { result in
                        switch result {
                        case .success(let surveys):
                            expect(surveys.count) == 0
                        case .failure(let error):
                            fail("Should return authorized success \(error)")
                        }
                        done()
                    }
                }
            }

            it("Tests getSurveyList error") {
                stub(condition: isHost(host) && isPath(Config.authenPath), response: { _ -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile(Config.noContentFilePath1, type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: Test.Error.fileNotFound)
                    }
                    return fixture(filePath: path, status: 401, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    API.Survey.getSurveyList(page: 0) { result in
                        switch result {
                        case .success:
                            fail("Should return authorized error")
                        case .failure(let error):
                            expect((error as NSError).code) == API.Error.unauthorized.code
                            expect((error as NSError).localizedDescription) == API.Error.unauthorized.localizedDescription
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

extension SurveyServiceTests {

    private struct Config {
        static let authenPath = "/surveys.json"

        // File path
        static let noContentFilePath1 = "SurveysServiceTests-NoContent-1.json"
        static let noContentFilePath2 = "SurveysServiceTests-NoContent-2.json"
        static let successFilePath = "SurveysServiceTests-Success.json"
    }
}

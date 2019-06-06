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

        describe("Test function responseJSONSerializer") {

            it("Test no response error") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    return OHHTTPStubsResponse(error: API.Error.noResponse)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            fail("Should return API.Error.noResponse")
                        case .failure(let error):
                            expect((error as NSError).code) == API.Error.noResponse.code
                        }
                        done()
                    }
                }
            }

            it("Test unauthorized error") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile("CoreTests-Error.json", type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: API.Error.json)
                    }
                    return fixture(filePath: path, status: 401, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            fail("Should return API.Error.unauthorized")
                        case .failure(let error):
                            expect((error as NSError).code) == API.Error.unauthorized.code
                        }
                        done()
                    }
                }
            }

            it("Test client error") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile("CoreTests-Error.json", type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: API.Error.json)
                    }
                    return fixture(filePath: path, status: 400, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            fail("Should return API.Error.client")
                        case .failure(let error):
                            expect((error as NSError).code) == API.Error.client.code
                        }
                        done()
                    }
                }
            }

            it("Test server error") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile("CoreTests-Error.json", type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: API.Error.json)
                    }
                    return fixture(filePath: path, status: 500, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            fail("Should return API.Error.server")
                        case .failure(let error):
                            expect((error as NSError).code) == API.Error.server.code
                        }
                        done()
                    }
                }
            }

            it("Test other error") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile("CoreTests-Error.json", type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: API.Error.json)
                    }
                    return fixture(filePath: path, status: 600, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            fail("Should return Unknown HTTP status code received 600.")
                        case .failure(let error):
                            expect((error as NSError).localizedDescription) == "Unknown HTTP status code received (600)."
                        }
                        done()
                    }
                }
            }

            it("Test status code 201 ~ 399") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile("CoreTests-201Response.json", type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: API.Error.json)
                    }
                    return fixture(filePath: path, status: 201, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            self.success()
                        case .failure:
                            fail("Should return success")
                        }
                        done()
                    }
                }
            }

            it("Test status code 200") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile("CoreTests-200Response.json", type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: API.Error.json)
                    }
                    return fixture(filePath: path, status: 200, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            self.success()
                        case .failure:
                            fail("Should return success")
                        }
                        done()
                    }
                }
            }

            it("Test status code 200 with no content") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile("CoreTests-200Response-EmptyJSON.json", type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: API.Error.json)
                    }
                    return fixture(filePath: path, status: 200, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            self.success()
                        case .failure:
                            fail("Should return success")
                        }
                        done()
                    }
                }
            }

            it("Test status code 200 with JSON error") {
                stub(condition: isHost(host) && isPath("/oauth/token"), response: { (_) -> OHHTTPStubsResponse in
                    guard let path = OHPathForFile("CoreTests-200Response-ErrorJSON.json", type(of: self)) else {
                        fail("File not found")
                        return OHHTTPStubsResponse(error: API.Error.json)
                    }
                    return fixture(filePath: path, status: 200, headers: nil)
                        .setRequestTime()
                })

                waitUntil(timeout: 10) { done in
                    APIManager.shared.request(urlString: API.Path.authentication,
                                              method: .post
                    ) { result in
                        switch result {
                        case .success:
                            fail("Should return JSON error")
                        case .failure(let error):
                            expect((error as NSError).code) == API.Error.json.code
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

    private func success() {
        expect(true) == true
    }
}

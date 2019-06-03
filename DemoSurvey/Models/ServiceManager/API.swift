//
//  API.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import Alamofire

struct API {

    // MARK: - Path
    struct Path {

        // MARK: - Endpoint
        static let endpoint: String = "https://nimble-survey-api.herokuapp.com"

        // MARK: - Authentication
        static let authentication: String = API.Path.endpoint / "oauth" / "token"

        // MARK: - Survey
        static let survey: String = API.Path.endpoint / "surveys.json"
    }

    // MARK: - Error
    struct Error {
        static let cannotConnectNetwork = NSError(domain: NSCocoaErrorDomain,
                                                  code: 900,
                                                  message: "Network connection error. Please check network connection and try again.")

        static let json = NSError(domain: NSCocoaErrorDomain,
                                  code: 901,
                                  message: "JSON error. The operation couldn’t be completed.")

        static let noResponse = NSError(domain: NSCocoaErrorDomain,
                                        code: 902,
                                        message: "No response. Please try again.")

        static let unauthorized = NSError(domain: Path.endpoint,
                                          code: 401,
                                          message: "Unauthorized error. Please try to authorize again.")

        static let client = NSError(domain: NSCocoaErrorDomain,
                                    code: 499,
                                    message: "There is internal error. Please try again later.")

        static let server = NSError(domain: Path.endpoint,
                                    code: 599,
                                    message: "There is internal error. Please try again later.")
    }
}

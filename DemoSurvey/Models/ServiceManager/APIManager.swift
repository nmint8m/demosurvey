//
//  APIManager.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Typealias
typealias JSObject = [String: Any]
typealias JSArray = [JSObject]
typealias APICompletion = (APIResult) -> Void
typealias Completion<T> = (Result<T>) -> Void

// MARK: - APIResult
enum APIResult {
    case success
    case failure(Error)
}

// MARK: - APIManager
final class APIManager {

    static let shared = APIManager()

    var defaultHTTPHeaders: HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers["Authorization"] = Session.shared.getValue(for: .accessToken)
        return headers
    }

    private init() {}

    @discardableResult
    func request(urlString: String,
                 method: HTTPMethod,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeaders? = nil,
                 completion: Completion<Any>?) -> Request? {

        // Network
        guard Network.shared.isReachable else {
            completion?(.failure(API.Error.cannotConnectNetwork))
            return nil
        }

        // Headers
        var requestHeaders: HTTPHeaders?
        if urlString != API.Path.authentication {
            requestHeaders = updateHeaders(headers)
        }

        // Request
        return Alamofire.request(urlString,
                          method: method,
                          parameters: parameters,
                          encoding: encoding,
                          headers: requestHeaders
            ).customResponseJSON { response in
            completion?(response.result)
        }
    }

    func updateHeaders(_ headers: HTTPHeaders?) -> HTTPHeaders {
        guard let headers = headers else {
            return defaultHTTPHeaders
        }
        var requestHeaders = defaultHTTPHeaders
        for header in headers {
            requestHeaders[header.key] = header.value
        }
        return requestHeaders
    }
}

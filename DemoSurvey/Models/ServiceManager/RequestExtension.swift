//
//  RequestExtension.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import Async

extension Request {
    @discardableResult
    static func responseJSONSerializer(response: HTTPURLResponse?,
                                       data: Data?,
                                       error: Error?) -> Result<Any> {
        guard let response = response else {
            return .failure(API.Error.noResponse)
        }

        if let error = error {
            return .failure(error)
        }

        let statusCode = response.statusCode

        switch statusCode {
        case 200:
            if let data = data, let json = data.toJSON() {
                // Success
                return .success(json)
            } else if let data = data, let string = data.toString(), string.isEmpty {
                // Success but no response
                return .success([:])
            } else {
                return .failure(API.Error.json)
            }
        case 201...399:
            return .success([:])
        default:
            if statusCode == 401 {
                return .failure(API.Error.unauthorized)
            } else if 400...499 ~= statusCode {
                return .failure(API.Error.client)
            } else if 500...599 ~= statusCode {
                return .failure(API.Error.server)
            } else {
                let error = NSError(domain: API.Path.endpoint,
                                    code: statusCode,
                                    message: "Unknown HTTP status code received (\(statusCode)).")
                return .failure(error)
            }
        }
    }
}

extension DataRequest {

    static func customJSONResponseSerializer() -> DataResponseSerializer<Any> {
        return DataResponseSerializer { _, response, data, error in
            Request.responseJSONSerializer(response: response,
                                           data: data,
                                           error: error)
        }
    }

    @discardableResult
    func customResponseJSON(queue: DispatchQueue? = .global(qos: .background),
                            completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: DataRequest.customJSONResponseSerializer(),
                        completionHandler: completionHandler)
    }
}

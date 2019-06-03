//
//  AuthenticationService.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import ObjectMapper

extension API {

    final class Authentication {

        struct InformationParameter {
            let username: String
            let password: String
            let grantType: GrantType

            func toJSON() -> [String: String] {
                var json: [String: String] = [:]
                json["grant_type"] = grantType.rawValue
                json["username"] = username
                json["password"] = password
                return json
            }

            enum GrantType: String {
                case password
            }
        }

        static func getAccessToken(completion: APICompletion? = nil) {
            let path = API.Path.authentication
            let parameters = InformationParameter(username: Dummy.username,
                                                  password: Dummy.password,
                                                  grantType: Dummy.grantType).toJSON()

            APIManager.shared.request(urlString: path,
                                      method: .post,
                                      parameters: parameters
            ) { result in
                switch result {
                case .success(let value):
                    guard let json = value as? JSObject,
                        let info = Mapper<AccessTokenInfo>().map(JSON: json) else {
                            completion?(.failure(API.Error.json))
                            return
                    }
                    Authentication.saveAccessToken(info.accessToken)
                    completion?(.success)
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        }

        static private func saveAccessToken(_ token: String) {
            Session.shared.setValue("Bearer " + token, for: .accessToken)
        }
    }
}

// MARK: - Dummy
fileprivate extension API.Authentication {

    struct Dummy {
        static let username = "carlos@nimbl3.com"
        static let password = "antikera"
        static let grantType = InformationParameter.GrantType.password
    }
}

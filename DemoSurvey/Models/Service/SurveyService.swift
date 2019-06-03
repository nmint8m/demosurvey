//
//  SurveyService.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import ObjectMapper

extension API {

    final class Survey {

        struct SurveyParameter {
            let page: Int
            let perPage: Int

            func toJSON() -> [String: Int] {
                var json: [String: Int] = [:]
                json["page"] = page
                json["per_page"] = perPage
                return json
            }
        }

        static func getSurveyList(page: Int, completion: Completion<[SurveyInfo]>? = nil) {
            let path = API.Path.survey
            let parameters = SurveyParameter(page: page,
                                             perPage: 10).toJSON()

            APIManager.shared.request(urlString: path,
                                      method: .get,
                                      parameters: parameters
            ) { result in
                switch result {
                case .success(let value):
                    guard let json = value as? JSArray else {
                            completion?(.failure(API.Error.json))
                            return
                    }
                    let surveys = Mapper<SurveyInfo>().mapArray(JSONArray: json)
                    completion?(.success(surveys))
                    return
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        }
    }
}

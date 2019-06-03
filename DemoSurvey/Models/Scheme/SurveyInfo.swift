//
//  SurveyInfo.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/3/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import ObjectMapper

final class SurveyInfo: Mappable {

    var id: String = ""
    var title: String = ""
    var description: String = ""
    var coverImageURL: String = ""
    var type: String = ""
    var questions: [QuestionInfo] = []

    required init?(map: Map) {}

    init() {}

    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        coverImageURL <- map["cover_image_url"]
        type <- map["type"]
        questions <- map["questions"]
    }
}

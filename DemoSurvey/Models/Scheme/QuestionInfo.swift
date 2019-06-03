//
//  QuestionInfo.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/3/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import ObjectMapper

final class QuestionInfo: Mappable {

    var id: String = ""
    var text: String = ""
    var coverImageURL: String = ""
    var answers: [AnswerInfo] = []

    required init?(map: Map) {}

    init() {}

    func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
        coverImageURL <- map["cover_image_url"]
        answers <- map["answers"]
    }
}

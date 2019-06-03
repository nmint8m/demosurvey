//
//  AnswerInfo.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/3/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import ObjectMapper

final class AnswerInfo: Mappable {

    var id: String = ""
    var questionID: String = ""
    var text: String = ""
    var displayOrder: Int = 0

    required init?(map: Map) {}

    init() {}

    func mapping(map: Map) {
        id <- map["id"]
        questionID <- map["question_id"]
        text <- map["text"]
        displayOrder <- map["display_order"]
    }
}

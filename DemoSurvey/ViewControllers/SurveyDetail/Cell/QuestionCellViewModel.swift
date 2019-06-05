//
//  QuestionCellViewModel.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/5/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation

final class QuestionCellViewModel {

    private var questionInfo = QuestionInfo()

    var question: String {
        return questionInfo.text.trimmed
    }

    var imageURLString: String {
        return questionInfo.coverImageURL
    }

    init(questionInfo: QuestionInfo = QuestionInfo()) {
        self.questionInfo = questionInfo
    }
}

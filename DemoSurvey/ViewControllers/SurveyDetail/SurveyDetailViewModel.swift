//
//  SurveyDetailViewModel.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/5/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation

final class SurveyDetailViewModel {
    private var questions: [QuestionInfo] = []

    init(questions: [QuestionInfo] = []) {
        self.questions = questions
    }
}

// MARK: - Functions for collection view data
extension SurveyDetailViewModel {

    func numberOfItemsInSection(in section: Int) -> Int {
        return questions.count
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> QuestionCellViewModel {
        guard indexPath.item < questions.count else {
            throw Errors.indexOutOfBound
        }
        return QuestionCellViewModel(questionInfo: questions[indexPath.item])
    }
}

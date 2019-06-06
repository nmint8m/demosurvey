//
//  SurveyDetailViewModelTests.swift
//  DemoSurveyTests
//
//  Created by Tam Nguyen M. on 6/6/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import DemoSurvey

final class SurveyDetailViewModelTests: QuickSpec {

    override func spec() {

        var viewModel = SurveyDetailViewModel()

        describe("Test SurveyDetailViewModel") {

            beforeEach {
                viewModel = SurveyDetailViewModel(questions: Config.questions)
            }

            it("Test data") {
                expect(viewModel.numberOfItemsInSection(in: 0)) == 10

                var cellViewModel: QuestionCellViewModel?

                expect { cellViewModel = try viewModel.viewModelForItem(at: Config.indexPathRow0) }
                    .toNot(throwError(Errors.indexOutOfBound))

                expect { cellViewModel = try viewModel.viewModelForItem(at: Config.indexPathRow11) }
                    .to(throwError(Errors.indexOutOfBound))

                expect(cellViewModel?.question) == "Some text not trimmed"
                expect(cellViewModel?.imageURLString) == "https://t8m.dev/someimg.jpg"
            }
        }
    }
}

extension SurveyDetailViewModelTests {
    private struct Config {
        static let questions: [QuestionInfo] = {
            let question = QuestionInfo()
            question.id = "ID"
            question.text = " Some text not trimmed "
            question.coverImageURL = "https://t8m.dev/someimg.jpg"
            question.answers = []
            var questions = Array<QuestionInfo>(repeating: question, count: 10)
            return questions
        }()
        static let indexPathRow0 = IndexPath(item: 0, section: 0)
        static let indexPathRow11 = IndexPath(item: 11, section: 0)
    }
}

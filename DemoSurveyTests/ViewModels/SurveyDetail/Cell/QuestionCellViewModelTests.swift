//
//  QuestionCellViewModelTests.swift
//  DemoSurveyTests
//
//  Created by Tam Nguyen M. on 6/6/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import DemoSurvey

final class QuestionCellViewModelTests: QuickSpec {

    override func spec() {

        var viewModel = QuestionCellViewModel()

        describe("Test QuestionCellViewModel") {

            beforeEach {
                viewModel = QuestionCellViewModel(questionInfo: Config.questionInfo)
            }

            it("Test data") {
                expect(viewModel.question) == "Some question not trimmed"
                expect(viewModel.imageURLString) == "https://t8m.dev/someimg.jpgl"
            }
        }
    }
}

extension QuestionCellViewModelTests {
    private struct Config {
        static let questionInfo: QuestionInfo = {
            let info = QuestionInfo()
            info.id = "ID"
            info.text = " Some question not trimmed "
            info.coverImageURL = "https://t8m.dev/someimg.jpg"
            info.answers = []
            return info
        }()
    }
}

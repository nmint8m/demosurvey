//
//  SurveyCellViewModelTests.swift
//  DemoSurveyTests
//
//  Created by Tam Nguyen M. on 6/6/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import DemoSurvey

final class SurveyCellViewModelTests: QuickSpec {

    override func spec() {

        var viewModel = SurveyCellViewModel()

        describe("Test SurveyCellViewModel") {

            beforeEach {
                viewModel = SurveyCellViewModel(surveyInfo: Config.surveyInfo)
            }

            it("Test data") {
                expect(viewModel.title) == "Some title not trimmed"
                expect(viewModel.description) == "Some description not trimmed"
                expect(viewModel.imageURLString) == "https://t8m.dev/someimg.jpg"
            }
        }
    }
}

extension SurveyCellViewModelTests {
    private struct Config {
        static let surveyInfo: SurveyInfo = {
            let info = SurveyInfo()
            info.id = "ID"
            info.title = " Some title not trimmed "
            info.description = " Some description not trimmed "
            info.coverImageURL = "https://t8m.dev/someimg.jpg"
            info.type = "Some type"
            info.questions = []
            return info
        }()
    }
}

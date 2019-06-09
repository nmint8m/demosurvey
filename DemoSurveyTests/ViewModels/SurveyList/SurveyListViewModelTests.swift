//
//  SurveyListViewModelTests.swift
//  DemoSurveyTests
//
//  Created by Tam Nguyen M. on 6/6/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import DemoSurvey

final class SurveyListViewModelTests: QuickSpec {

    override func spec() {

        var viewModel = SurveyListViewModel()

        // MARK: - Functions for collection view data
        describe("Test functions for collection view data") {

            context("Init") {

                beforeEach {
                    viewModel = SurveyListViewModel()
                }

                it("Test init data") {
                    expect(viewModel.numberOfItemsInSection(in: 0)) == 0

                    expect {
                        try viewModel.viewModelForItem(at: Config.indexPathRow0)
                    }.to(throwError(Errors.indexOutOfBound))

                    expect {
                        try viewModel.surveyDetailViewModelForItem(at: Config.indexPathRow0)
                        }.to(throwError(Errors.indexOutOfBound))
                }
            }

            context("After load data success") {

                beforeEach {
                    viewModel = SurveyListViewModel()
                    self.loadSurveySuccess(viewModel: viewModel)
                }

                it("Test data") {
                    expect(viewModel.numberOfItemsInSection(in: 0)) == 10

                    expect {
                        try viewModel.viewModelForItem(at: Config.indexPathRow0)
                        }.notTo(throwError(Errors.indexOutOfBound))

                    expect {
                        try viewModel.surveyDetailViewModelForItem(at: Config.indexPathRow0)
                        }.notTo(throwError(Errors.indexOutOfBound))
                }
            }

            context("After load data failure") {

                beforeEach {
                    viewModel = SurveyListViewModel()
                    self.loadSurveyFailure(viewModel: viewModel)
                }

                it("Test data") {
                    expect(viewModel.numberOfItemsInSection(in: 0)) == 0

                    expect {
                        try viewModel.viewModelForItem(at: Config.indexPathRow0)
                        }.to(throwError(Errors.indexOutOfBound))

                    expect {
                        try viewModel.surveyDetailViewModelForItem(at: Config.indexPathRow0)
                        }.to(throwError(Errors.indexOutOfBound))
                }
            }
        }
    }

    func loadSurveySuccess(viewModel: SurveyListViewModel) {
        stub(condition: isHost(host) && isPath(Config.surveysPath), response: { _ -> OHHTTPStubsResponse in
            guard let path = OHPathForFile(Config.successFilePath, type(of: self)) else {
                fail("File not found")
                return OHHTTPStubsResponse(error: Test.Error.fileNotFound)
            }
            return fixture(filePath: path, status: 200, headers: nil)
                .setRequestTime()
        })

        waitUntil(timeout: 100) { done in
            viewModel.loadData(isLoadMore: false) { _ in
                done()
            }
        }
    }

    func loadSurveyFailure(viewModel: SurveyListViewModel) {
        stub(condition: isHost(host) && isPath(Config.surveysPath), response: { _ -> OHHTTPStubsResponse in
            guard let path = OHPathForFile(Config.noContentFilePath, type(of: self)) else {
                fail("File not found")
                return OHHTTPStubsResponse(error: Test.Error.fileNotFound)
            }
            return fixture(filePath: path, status: 401, headers: nil)
                .setRequestTime()
        })

        waitUntil(timeout: 10) { done in
            viewModel.loadData(isLoadMore: false) { _ in
                done()
            }
        }
    }
}

extension SurveyListViewModelTests {
    private struct Config {
        static let indexPathRow0 = IndexPath(item: 0, section: 0)
        static let indexPathRow1 = IndexPath(item: 1, section: 0)
        static let indexPathRow6 = IndexPath(item: 6, section: 0)
        static let surveysPath = "/surveys.json"
        static let successFilePath = "SurveysServiceTests-Success.json"
        static let noContentFilePath = "SurveysServiceTests-NoContent-1.json"
    }
}

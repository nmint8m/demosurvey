//
//  SurveyListViewModel.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/3/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import Async

final class SurveyListViewModel {

    private var surveys: [SurveyInfo] = []
    private var isLoading = false
    private var page = 0
    private var oldCellIndex = 0

    init() {}
}

// MARK: - Functions for collection view data
extension SurveyListViewModel {

    func numberOfItemsInSection(in section: Int) -> Int {
        return surveys.count
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> SurveyCellViewModel {
        guard indexPath.row < surveys.count else {
            throw Errors.indexOutOfBound
        }
        return SurveyCellViewModel(surveyInfo: surveys[indexPath.row])
    }

    func surveyDetailViewModelForItem(at indexPath: IndexPath) throws -> SurveyDetailViewModel {
        guard indexPath.row < surveys.count else {
            throw Errors.indexOutOfBound
        }
        return SurveyDetailViewModel(questions: surveys[indexPath.row].questions)
    }
}

// MARK: - Functions for calling API Survey
extension SurveyListViewModel {

    func loadData(isLoadMore: Bool, completion: Completion<Bool>?) {
        guard !isLoading else {
            completion?(.success(false))
            return
        }
        isLoading = true
        API.Survey.getSurveyList(page: isLoadMore ? page + 1 : 0) { [weak self] result in
            Async.main {
                guard let this = self else { return }
                this.isLoading = false
                switch result {
                case .success(let newSurveys):
                    if isLoadMore {
                        this.page += newSurveys.isEmpty ? 0 : 1
                        this.surveys.append(contentsOf: newSurveys)
                    } else {
                        this.page = 0
                        this.surveys = newSurveys
                        this.oldCellIndex = 0
                    }
                    completion?(.success(!newSurveys.isEmpty))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        }
    }

    func shouldLoadMoreData(cellWillDisplayAt indexPath: IndexPath) -> Bool {
        let newCellIndex = indexPath.item
        guard newCellIndex >= oldCellIndex,
            newCellIndex > surveys.count - 5 else {
            return false
        }
        oldCellIndex = newCellIndex
        return isLoading ? false : true
    }
}

// MARK: - Functions for calling API Authentication
extension SurveyListViewModel {
    func getNewAuthentication(completion: APICompletion?) {
        API.Authentication.getAccessToken(completion: completion)
    }
}

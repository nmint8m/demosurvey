//
//  SurveyCellViewModel.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/4/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation

final class SurveyCellViewModel {

    private var surveyInfo = SurveyInfo()

    var title: String {
        let title = surveyInfo.title.trimmed
        return title.isEmpty ? "No title" : title
    }

    var description: String {
        let description = surveyInfo.description.trimmed
        return description.isEmpty ? "No description" : description
    }

    var imageURLString: String {
        return surveyInfo.coverImageURL
    }

    init(surveyInfo: SurveyInfo = SurveyInfo()) {
        self.surveyInfo = surveyInfo
    }
}

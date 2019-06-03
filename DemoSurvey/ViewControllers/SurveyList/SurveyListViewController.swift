//
//  SurveyListViewController.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class SurveyListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        API.Authentication.getAccessToken()
        API.Survey.getSurveyList(page: 1)
    }
}

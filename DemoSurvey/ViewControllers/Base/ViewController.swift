//
//  ViewController.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/4/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configSwipeToBack()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    var statusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func configNavigationBar() {
        navigationController?.isNavigationBarHidden = isNavigationBarHidden
    }

    var isNavigationBarHidden: Bool {
        return true
    }

    private func configSwipeToBack() {
        guard isEnabledSwipeToBack,
            let count = self.navigationController?.viewControllers.count,
            count > 1 else { return }
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    var isEnabledSwipeToBack: Bool {
        return true
    }
}

extension ViewController: UIGestureRecognizerDelegate {}

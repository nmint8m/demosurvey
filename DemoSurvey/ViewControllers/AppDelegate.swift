//
//  AppDelegate.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 5/30/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: CGRect(origin: .zero,
                                        size: screenSize))
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        setRoot(.surveyList)

        return true
    }
}

// AppDelegate setting
extension AppDelegate {
    enum RootType {
        case surveyList
    }

    private func setRoot(_ rootType: RootType) {
        switch rootType {
        case .surveyList:
            let viewController = SurveyListViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
        }
    }
}

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

    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: CGRect(origin: .zero,
                                        size: screenSize))
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        configCache()
        setRoot(.surveyList)

        return true
    }
}

// AppDelegate setting
extension AppDelegate {
    enum RootType {
        case surveyList
    }

    private func configCache() {
        URLCache.shared = URLCache(memoryCapacity: 0,
                                   diskCapacity: 0,
                                   diskPath: nil)
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

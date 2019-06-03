//
//  NetworkReachabilityManagerExtension.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import Alamofire

typealias Network = NetworkReachabilityManager

extension Network {

    static let shared: Network = {
        guard let shared = Network() else {
            fatalError("Cannot init network")
        }
        return shared
    }()
}

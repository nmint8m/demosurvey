//
//  NSErrorExtension.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation

extension NSError {

    convenience init(domain: String,
                     code: Int,
                     message: String = "") {
        guard message.isNotEmpty else {
            self.init(domain: domain,
                      code: code,
                      userInfo: nil)
            return
        }
        self.init(domain: domain,
                  code: code,
                  userInfo: [NSLocalizedDescriptionKey: message])
    }
}

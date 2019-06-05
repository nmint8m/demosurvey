//
//  UIFontExtension.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/4/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

enum FontType {
    case montserratBold
    case montserratLight
    case montserratMedium
    case montserratThin

    /// font name
    var name: String {
        switch self {
        case .montserratBold:
            return "Montserrat-Bold"
        case .montserratLight:
            return "Montserrat-Light"
        case .montserratMedium:
            return "Montserrat-Medium"
        case .montserratThin:
            return "Montserrat-Thin"
        }
    }
}

extension UIFont {
    /**
     Initialized font size with type
     - Parameter fontType: The type of font, is defined in FontType enum
     - Parameter size: The font size
     */
    convenience init?(type fontType: FontType, size: CGFloat) {
        self.init(name: fontType.name, size: size)
    }
}

//
//  Measurement.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

let screenSize = UIScreen.main.bounds.size

enum DeviceType {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6p
    case iPhoneX
    case iPhoneXS
    case iPhoneXR
    case iPhoneXSMax
    case iPad
    case iPadPro105
    case iPadPro129

    var size: CGSize {
        switch self {
        case .iPhone4: return CGSize(width: 320, height: 480)
        case .iPhone5: return CGSize(width: 320, height: 568)
        case .iPhone6: return CGSize(width: 375, height: 667)
        case .iPhone6p: return CGSize(width: 414, height: 736)
        case .iPhoneX: return CGSize(width: 375, height: 812)
        case .iPhoneXS: return CGSize(width: 375, height: 812)
        case .iPhoneXR: return CGSize(width: 414, height: 896)
        case .iPhoneXSMax: return CGSize(width: 414, height: 896)
        case .iPad: return CGSize(width: 768, height: 1024)
        case .iPadPro105: return CGSize(width: 834, height: 1112)
        case .iPadPro129: return CGSize(width: 1024, height: 1366)
        }
    }
}

let iPhone = (UIDevice.current.userInterfaceIdiom == .phone)
let iPad = (UIDevice.current.userInterfaceIdiom == .pad)

let iPhone4 = (iPhone && DeviceType.iPhone4.size == screenSize)
let iPhone5 = (iPhone && DeviceType.iPhone5.size == screenSize)
let iPhone6 = (iPhone && DeviceType.iPhone6.size == screenSize)
let iPhone6p = (iPhone && DeviceType.iPhone6p.size == screenSize)
let iPhoneX = (iPhone && DeviceType.iPhoneX.size == screenSize)
let iPhoneXS = (iPhone && DeviceType.iPhoneXS.size == screenSize)
let iPhoneXR = (iPhone && DeviceType.iPhoneXR.size == screenSize)
let iPhoneXSMax = (iPhone && DeviceType.iPhoneXSMax.size == screenSize)

var tabBarHeight: CGFloat {
    if iPhoneX {
        return 89
    } else {
        return 55
    }
}

var homeButtonHeight: CGFloat {
    if iPhoneX {
        return 34
    } else {
        return 0
    }
}

var statusBarHeight: CGFloat {
    if iPhoneX {
        return 44
    } else {
        return 20
    }
}

let navigationBarHeight: CGFloat = 60

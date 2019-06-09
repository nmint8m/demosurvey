//
//  UIScrollViewExtension.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/8/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

/*
 - Add a new property to an existing class.
 - It does it by defining a computed property
 in an extension block. The computed property
 is stored as an associated object.
 */

private var kLastContentOffSet = "lastContentOffSet"

extension UIScrollView {

    enum Direction {
        case none
        case up(constant: CGFloat)
        case down(constant: CGFloat)
    }

    var direction: Direction {
        guard let lastContentOffSet = lastContentOffSet else { return .none }

        var offSet: CGFloat?

        if self is UITableView {
            offSet = contentOffset.y
        }

        if let this = self as? UICollectionView {
            if let flowLayout = this.collectionViewLayout as? UICollectionViewFlowLayout,
                flowLayout.scrollDirection == .vertical {
                offSet = this.contentOffset.y
            } else {
                offSet = this.contentOffset.x
            }
        }

        guard let currentContentOffSet = offSet else { return .none }

        let scrollDiff = currentContentOffSet - lastContentOffSet

        if scrollDiff > 0 {
            return .down(constant: scrollDiff)
        }
        if scrollDiff < 0 {
            return .up(constant: scrollDiff)
        }
        return .none
    }

    var lastContentOffSet: CGFloat? {
        set {
            objc_setAssociatedObject(self, &kLastContentOffSet, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &kLastContentOffSet) as? CGFloat
        }
    }
}

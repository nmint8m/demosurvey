//
//  LoadMoreController.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/8/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

protocol LoadMoreControllerDelegate: class {

    var scrollView: UIScrollView { get }

    var positionStartLoadMore: CGFloat { get }

    func shouldLoadMore(_ controller: LoadMoreController,
                        scrollView: UIScrollView,
                        shouldLoadMore: Bool)
}

final class LoadMoreController: NSObject {

    weak var delegate: LoadMoreControllerDelegate?

    var couldLoadMore: Bool {
        guard let scrollView = delegate?.scrollView,
            let positionStartLoadMore = delegate?.positionStartLoadMore,
            case .down(_) = scrollView.direction else { return false }

        if let tableView = scrollView as? UITableView {
            tableView.layoutIfNeeded()
            let contentHeight = tableView.contentSize.height
            let boundHeight = tableView.bounds.height
            let currentOffset = tableView.contentOffset.y
            guard contentHeight > 0 else { return false }
            let distanceToBottom = contentHeight - currentOffset
            return distanceToBottom <= boundHeight + positionStartLoadMore
        }

        if let collectionView = scrollView as? UICollectionView {
            guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return false }

            collectionView.layoutIfNeeded()

            let contentHeight: CGFloat
            let boundHeight: CGFloat
            let currentOffset: CGFloat

            if flowLayout.scrollDirection == .vertical {
                contentHeight = collectionView.contentSize.height
                boundHeight = collectionView.bounds.height
                currentOffset = collectionView.contentOffset.y
            } else {
                contentHeight = collectionView.contentSize.width
                boundHeight = collectionView.bounds.width
                currentOffset = collectionView.contentOffset.x
            }

            guard contentHeight > 0 else { return false }
            let distanceToBottom = contentHeight - currentOffset
            return distanceToBottom <= boundHeight + positionStartLoadMore
        }

        return false
    }

    func scrollViewDidScroll() {
        guard let scrollView = delegate?.scrollView else { return }

        delegate?.shouldLoadMore(self,
                                 scrollView: scrollView,
                                 shouldLoadMore: couldLoadMore)

        if let tableView = scrollView as? UITableView {
            tableView.lastContentOffSet = tableView.contentOffset.y
        }

        if let collectionView = scrollView as? UICollectionView {
            guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

            if flowLayout.scrollDirection == .vertical {
                collectionView.lastContentOffSet = collectionView.contentOffset.y
            } else {
                collectionView.lastContentOffSet = collectionView.contentOffset.x
            }
        }
    }
}

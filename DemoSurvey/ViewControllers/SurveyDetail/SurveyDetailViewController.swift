//
//  SurveyDetailViewController.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/5/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class SurveyDetailViewController: ViewController {

    // MARK: - Properties
    var viewModel = SurveyDetailViewModel()

    private var loadMoreController = LoadMoreController()

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configLoadMoreController()
    }

    // MARK: - IBActions
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SurveyDetailViewController {

    // MARK: - Config UI
    private func configCollectionView() {
        let nib = UINib(nibName: Config.cellName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Config.cellName)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension SurveyDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = try? viewModel.viewModelForItem(at: indexPath) else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withClass: QuestionCell.self, for: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SurveyDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return screenSize
    }
}

// MARK: - UIScrollViewDelegate
extension SurveyDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadMoreController.scrollViewDidScroll()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension SurveyDetailViewController {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        collectionView.isScrollEnabled = false
        return true
    }
}

// MARK: - Config
extension SurveyDetailViewController {

    private struct Config {
        static let cellName = "QuestionCell"
        static let positionStartLoadMore: CGFloat = screenSize.height * 3
    }
}

// MARK: - ScrollLoadControllerDelegate
extension SurveyDetailViewController: LoadMoreControllerDelegate {

    var scrollView: UIScrollView {
        return collectionView
    }

    var positionStartLoadMore: CGFloat {
        return Config.positionStartLoadMore
    }

    func shouldLoadMore(_ controller: LoadMoreController,
                        scrollView: UIScrollView,
                        shouldLoadMore: Bool) {
        // TODO: - Handle should load more
    }

    private func configLoadMoreController() {
        let loadMoreController = LoadMoreController()
        loadMoreController.delegate = self
        self.loadMoreController = loadMoreController
    }
}

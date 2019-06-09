//
//  SurveyListViewController.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit
import SwifterSwift
import Async
import CHIPageControl

final class SurveyListViewController: ViewController {

    // MARK: - Properties
    var viewModel = SurveyListViewModel()

    private var loadMoreController = LoadMoreController()

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    private weak var pageControl: CHIPageControlAji!

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configPageControl()
        if Session.shared.getValue(for: .accessToken) == nil {
            loadAccessToken { [weak self] result in
                guard let this = self else { return }
                switch result {
                case .success:
                    this.loadData(isLoadMore: false)
                case .failure:
                    break
                }
            }
        } else {
            loadData(isLoadMore: false)
        }
        configLoadMoreController()
    }

    // MARK: - IBActions
    @IBAction func reloadButtonTouchUpInside(_ sender: UIButton) {
        loadData(isLoadMore: false)
    }

    @IBAction func settingButtonTouchUpInside(_ sender: Any) {
        showAlert(title: "Hello new day! 🌤",
                  message: "It will be very nice of you to try this function again later! 🙏\nThis function is now being implemented. ✌️")
    }
}

extension SurveyListViewController {

    // MARK: - Config UI
    private func configCollectionView() {
        let nib = UINib(nibName: Config.cellName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Config.cellName)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func configPageControl() {
        let pageControl = CHIPageControlAji(frame: .zero)
        pageControl.numberOfPages = 1
        pageControl.radius = Config.pageControlRadius
        pageControl.padding = Config.pageControlPadding
        pageControl.tintColor = Config.tintColor
        pageControl.currentPageTintColor = Config.currentTintColor
        pageControl.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        pageControl.frame = Config.pageControlFrame
        view.addSubview(pageControl)
        self.pageControl = pageControl
    }

    // MARK: - API
    private func loadAccessToken(completion: APICompletion? = nil) {
        viewModel.getNewAuthentication { [weak self] result in
            Async.main {
                guard let this = self else { return }
                switch result {
                case .success:
                    completion?(.success)
                case .failure(let error):
                    this.showAlert(error: error)
                    completion?(.failure(error))
                }
            }
        }
    }

    private func reloadAccessTokenAndData() {
        loadAccessToken { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.loadData(isLoadMore: false)
            default:
                break
            }
        }
    }

    private func loadData(isLoadMore: Bool) {
        viewModel.loadData(isLoadMore: isLoadMore) { [weak self] result in
            Async.main {
                guard let this = self else { return }
                switch result {
                case .success(let needsLoadMore):
                    if isLoadMore {
                        this.handleNewLoadedSurvey(needsLoadMore: needsLoadMore)
                    } else {
                        this.collectionView.setContentOffset(.zero, animated: false)
                        this.collectionView.reloadData()
                    }
                    this.updatePageControl(needsReload: !isLoadMore)
                case .failure(let error):
                    if (error as NSError) == API.Error.unauthorized {
                        this.showUnauthorizedError()
                    } else {
                        this.showAlert(error: error)
                    }
                }
            }
        }
    }

    private func showUnauthorizedError() {
        let alertController = UIAlertController(title: "Unauthorized error",
                                                message: API.Error.unauthorized.localizedDescription,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Reload", style: .default) { [weak self] _ in
            guard let this = self else { return }
            this.reloadAccessTokenAndData()
        }
        alertController.addAction(action)
        present(alertController,
                animated: true,
                completion: nil)
    }

    private func showAlert(error: Error) {
        showAlert(title: "Error",
                  message: error.localizedDescription)
    }

    private func showAlert(title: String,
                           message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alertController.addAction(action)
        present(alertController,
                animated: true,
                completion: nil)
    }

    private func handleNewLoadedSurvey(needsLoadMore: Bool) {
        // TODO: Insert instead of reload
        if needsLoadMore {
            collectionView.reloadData()
        }
    }

    private func updatePageControl(needsReload: Bool) {
        pageControl.numberOfPages = viewModel.numberOfItemsInSection(in: 0)
        if needsReload {
            pageControl.set(progress: 0, animated: false)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SurveyListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = try? viewModel.viewModelForItem(at: indexPath) else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withClass: SurveyCell.self, for: indexPath)
        cell.viewModel = cellViewModel
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SurveyListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return screenSize
    }
}

// MARK: - UIScrollViewDelegate
extension SurveyListViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = Int((scrollView.contentOffset.y / screenSize.height).rounded())
        pageControl.set(progress: pageNumber, animated: true)

        loadMoreController.scrollViewDidScroll()
    }
}

// MARK: - SurveyCellDelegate
extension SurveyListViewController: SurveyCellDelegate {
    func cell(_ cell: SurveyCell, needsPerform action: SurveyCell.Action) {
        switch action {
        case .takeSurvey:
            guard let indexPath = collectionView.indexPath(for: cell),
                let vm = try? viewModel.surveyDetailViewModelForItem(at: indexPath) else {
                    return }
            let viewController = SurveyDetailViewController()
            viewController.viewModel = vm
                navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension SurveyListViewController {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        collectionView.isScrollEnabled = false
        return true
    }
}

// MARK: - Config
extension SurveyListViewController {

    private struct Config {
        static let cellName = "SurveyCell"
        static let tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        static let currentTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        static let pageControlRadius: CGFloat = 4
        static let pageControlPadding: CGFloat = 6
        static let pageControlTopPadding = statusBarHeight + navigationBarHeight
        static let pageControlWidth = screenSize.height - Config.pageControlTopPadding
        static let pageControlHeight: CGFloat = 30
        static let pageControlFrame =
            CGRect(x: screenSize.width - Config.pageControlHeight,
                   y: Config.pageControlTopPadding,
                   width: pageControlHeight,
                   height: pageControlWidth)
        static let positionStartLoadMore: CGFloat = screenSize.height * 4
    }
}

// MARK: - ScrollLoadControllerDelegate
extension SurveyListViewController: LoadMoreControllerDelegate {

    var scrollView: UIScrollView {
        return collectionView
    }

    var positionStartLoadMore: CGFloat {
        return Config.positionStartLoadMore
    }

    func shouldLoadMore(_ controller: LoadMoreController,
                        scrollView: UIScrollView,
                        shouldLoadMore: Bool) {
        if shouldLoadMore {
            loadData(isLoadMore: true)
        }
        print("shouldLoadMore \(shouldLoadMore)")
    }

    private func configLoadMoreController() {
        let loadMoreController = LoadMoreController()
        loadMoreController.delegate = self
        self.loadMoreController = loadMoreController
    }
}

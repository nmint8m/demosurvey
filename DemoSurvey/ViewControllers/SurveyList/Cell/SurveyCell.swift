//
//  SurveyCell.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/4/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit
import SDWebImage

protocol SurveyCellDelegate: class {
    func cell(_ cell: SurveyCell, needsPerform action: SurveyCell.Action)
}

final class SurveyCell: UICollectionViewCell {

    // MARK: - Properties
    weak var delegate: SurveyCellDelegate?

    var viewModel = SurveyCellViewModel() {
        didSet {
            updateCellUI()
        }
    }

    private var isAwaken = false

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var takeSurveyButton: UIButton!

    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        isAwaken = true
        updateCellUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard isAwaken else { return }
        imageView.cancelCurrentImageLoad()
        imageView.image = nil
    }

    private func updateCellUI() {
        guard isAwaken else { return }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        imageView.setImage(urlString: viewModel.imageURLString,
                           placeholder: Config.placeholderImage)
    }

    // MARK: - IBActions
    @IBAction func takeSurveyButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(self, needsPerform: .takeSurvey)
    }
}

extension SurveyCell {

    // MARK: - Action
    enum Action {
        case takeSurvey
    }

    // MARK: - Config
    private struct Config {
        static let placeholderImage: UIImage = {
            guard let image = UIImage(named: "img-placeholder") else {
                return UIImage()
            }
            return image
        }()
    }
}

//
//  QuestionCell.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/5/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class QuestionCell: UICollectionViewCell {

    // MARK: - Properties
    var viewModel = QuestionCellViewModel() {
        didSet {
            updateCellUI()
        }
    }

    private var isAwaken = false

    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var answerTableView: UITableView!

    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        isAwaken = true
        updateCellUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard isAwaken else { return }
        imageView.image = nil
        imageView.cancelCurrentImageLoad()
    }

    private func updateCellUI() {
        guard isAwaken else { return }
        imageView.setImage(urlString: viewModel.imageURLString,
                           placeholder: Config.placeholderImage)
        questionLabel.text = viewModel.question
        // TODO: - Update table view
    }
}

extension QuestionCell {

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

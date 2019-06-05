//
//  UIImageViewExtension.swift
//  DemoSurvey
//
//  Created by Tam Nguyen M. on 6/4/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit
import SDWebImage
import Async

extension UIImageView {

    typealias Completion = (UIImage?) -> Void

    func cancelCurrentImageLoad() {
        sd_cancelCurrentImageLoad()
    }

    func setImage(urlString: String?,
                  placeholder: UIImage?,
                  completion: Completion? = nil) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                image = placeholder
                return
        }
        sd_setImage(with: url,
                    placeholderImage: placeholder,
                    progress: nil
        ) { [weak self] (image, _, _, _) in
            guard let this = self else { return }
            Async.main {
                if let image = image {
                    this.image = image
                } else {
                    this.image = placeholder
                }
                completion?(image)
            }
        }
    }
}

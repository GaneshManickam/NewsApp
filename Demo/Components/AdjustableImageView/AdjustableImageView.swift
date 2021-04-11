//
//  AdjustableImageView.swift
//  Demo
//
//  Created by Ganesh Manickam on 11/04/21.
//

import Foundation
import UIKit

/// `AdjustableImageView` is a `UIImageView` which should have a fixed width or height.
/// It will add an `NSLayoutConstraint` such that it's width/height (aspect) ratio matches the
/// `image` width/height ratio.
class AdjustableImageView: UIImageView {

    /// `NSLayoutConstraint` constraining `heightAnchor` relative to the `widthAnchor`
    /// with the same `multiplier` as the inverse of the `image` aspect ratio, where aspect
    /// ratio is defined width/height.
    private var aspectRatioConstraint: NSLayoutConstraint?

    /// Override `image` setting constraint if necessary on set
    override var image: UIImage? {
        didSet {
            updateAspectRatioConstraint()
        }
    }

    // MARK: - Init

    override init(image: UIImage?) {
        super.init(image: image)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    /// Shared initializer code
    private func setup() {
        // Set default `contentMode`
        contentMode = .scaleAspectFill

        // Update constraints
        updateAspectRatioConstraint()
    }

    // MARK: - Resize

    /// De-active `aspectRatioConstraint` and re-active if conditions are met
    private func updateAspectRatioConstraint() {
        // De-active old constraint
        aspectRatioConstraint?.isActive = false

        // Check that we have an image
        guard let image = image else { return }

        // `image` dimensions
        let imageWidth = image.size.width
        let imageHeight = image.size.height

        // `image` aspectRatio
        guard imageWidth > 0 else { return }
        let aspectRatio = imageHeight / imageWidth
        guard aspectRatio > 0 else { return }

        // Create a new constraint
        aspectRatioConstraint = heightAnchor.constraint(
            equalTo: widthAnchor,
            multiplier: aspectRatio
        )

        // Activate new constraint
        aspectRatioConstraint?.isActive = true
    }
}

//
//  VerticallyCenteredTextView.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/5/22.
//

import UIKit

class VerticallyCenteredTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 10, bottom: 0, right: 20)
        }
    }
}

//
//  ListViewCollectionViewCell.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import UIKit

class ListViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.dropShadow()
        imageView.topCurveView()
        
    }

}

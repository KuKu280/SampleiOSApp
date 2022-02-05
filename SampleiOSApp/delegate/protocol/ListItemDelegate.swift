//
//  ListItemDelegate.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/5/22.
//

import UIKit

protocol ListItemDelegate {
    func onTapList(collectionviewcell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell)
}

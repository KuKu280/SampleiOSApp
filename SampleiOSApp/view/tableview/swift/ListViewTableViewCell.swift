//
//  ListViewTableViewCell.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import UIKit

class ListViewTableViewCell: UITableViewCell {

    @IBOutlet weak var listViewCollectionView: UICollectionView!
    
    var delegate : ListItemDelegate?=nil
    var sampleRecords = [SampleRecord]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionView()
        layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func registerCollectionView(){
        listViewCollectionView.delegate = self
        listViewCollectionView.dataSource = self
        listViewCollectionView.registerCell(type: ListViewCollectionViewCell.self)
    }
    
}

extension ListViewTableViewCell:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleRecords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListViewCollectionViewCell.identifier, for: indexPath)as? ListViewCollectionViewCell else { return
            UICollectionViewCell()
        }
        cell.imageView.downloadedFrom(link: sampleRecords[indexPath.row].photoUrl)
        cell.itemTitleLabel.text = sampleRecords[indexPath.row].ItemTitle
        cell.priceLabel.text = sampleRecords[indexPath.row].price
        return cell
    }
    
    
    
}

extension ListViewTableViewCell:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ListViewCollectionViewCell
        delegate?.onTapList(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        
    }
    
}

extension ListViewTableViewCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 7, height: CGFloat(250))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
    }
    
}

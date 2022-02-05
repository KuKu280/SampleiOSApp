//
//  ViewController.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import UIKit
import Firebase

class DashBoardViewController: UIViewController {
    
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    var dbref:DatabaseReference!
    var sampleRecords = [SampleRecord]()
    var timer = Timer()
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dbref = Database.database().reference()
        listenForData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.contentInsetAdjustmentBehavior = .never
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setupUI(){
        searchBarTextField.leftImage(UIImage(named: "search_box"), imageWidth: 10, padding: 15)
        registerCollectionView()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.slideView), userInfo: nil, repeats: true)
        registerTableView()
        dbref = Database.database().reference().child("DailywaterRecord")
    }
    
    fileprivate func registerTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerForCell(identifier: ListViewTableViewCell.identifier)
    }
    
    func registerCollectionView(){
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.registerCell(type: BannerCollectionViewCell.self)
    }
    
    @objc func slideView(){
        if counter < bannerList.count {
            let index = IndexPath.init(item: counter, section: 0)
            DispatchQueue.main.async {
                self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            DispatchQueue.main.async {
                self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
        }
        
    }
    
    @IBAction func pressedLogoutAction(_ sender: Any) {
        navigateToLogout()
    }
    
    
}

//MARK:-- CollectionViewDatasource
extension DashBoardViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath)as? BannerCollectionViewCell else { return
            UICollectionViewCell()
        }
        cell.bannerImageView.image = UIImage(named: bannerList[indexPath.row])
        return cell
    }

}

//MARK:-- CollectionViewDelegate
extension DashBoardViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: (collectionView.frame.width / 5 - 10), height: collectionView.frame.height)
        }
        return CGSize(width: (collectionView.frame.width), height: collectionView.frame.height)
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}

//MARK:-- TableViewDataSource
extension DashBoardViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(identifier: ListViewTableViewCell.identifier, indexPath: indexPath)as? ListViewTableViewCell else {
            return UITableViewCell()
        }
        cell.sampleRecords = sampleRecords
        cell.listViewCollectionView.reloadData()
        cell.listViewCollectionView.layoutIfNeeded()
        cell.delegate = self
        return cell
    }
    
    
}

//MARK:-- TableViewDelegate
extension DashBoardViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
}

//MARK:-- ListItemDelegate
extension DashBoardViewController:ListItemDelegate{
    
    func onTapList(collectionviewcell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell) {
        let storyboard = UIStoryboard.init(name: DETAILVIEW, bundle: nil)
        let vc = storyboard.instantiateViewController(ofType: DetailViewController.self)
        vc.data = sampleRecords[index]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK:-- listenForFetchData
extension DashBoardViewController{
    
    func listenForData(){
        dbref?.child("sampleData").child("data").observe(.value, with: { (snapshots) in
            //Get all of the children object of the snapshot
            let snapshots = snapshots.children.allObjects as! [DataSnapshot]
            
          //Clear the WaterRecords array befor parsing new waterRecords
            self.sampleRecords.removeAll()
        
            //Go through each child snapshot
            for snap in snapshots{

                //Cast the snapshot value as a dictionary
                let sampleDict = snap.value as! [String:Any]
                
                //Get the data for an waterRecords
                let sampleRecord = snap.key
                print(sampleRecord)
                
                let itemTitle = sampleDict["ItemTitle"] as! String
                let price = sampleDict["price"] as! String
                let username = sampleDict["username"] as! String
                let email = sampleDict["email"] as! String
                let location = sampleDict["location"] as! String
                let phoneModel = sampleDict["phoneModel"] as! String
                let phoneVersion = sampleDict["phoneVersion"] as! String
                let warranty = sampleDict["warranty"] as! String
                let description = sampleDict["description"] as! String
                let detail = sampleDict["detail"] as! String
                let photoUrl = sampleDict["photoUrl"] as! String
                
                
                //Create an waterRecords
                let e = SampleRecord(ItemTitle: itemTitle, price: price, username: username, email: email, location: location, phoneModel: phoneModel, phoneVersion: phoneVersion, warranty: warranty, description: description, detail: detail, photoUrl: photoUrl)
                
                //Add  to the array
                self.sampleRecords.append(e)
            }
            
            //Reload the tableView
            self.tableView.reloadData()
        })
    }
}


//
//  DetailViewController.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    var data: SampleRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        setupDataBind(data: data!)
    }
    
    fileprivate func setupUI(){
        // Configure the navigation bar
        tableView.contentInsetAdjustmentBehavior = .never
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backDismiss))
        //backButton.image = UIImage(named: "imageName") //Replaces title
        backButton.setBackgroundImage(UIImage(named: "back"), for: .normal, barMetrics: .default) // Stretches image
        navigationItem.setLeftBarButton(backButton, animated: false)
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        commentTextView.layer.cornerRadius = 20
        registerTableView()
        
    }
    
    fileprivate func registerTableView(){
        tableView.dataSource = self
        tableView.registerForCell(identifier: DetailListTableViewCell.identifier)
    }
    
    fileprivate func setupDataBind(data: SampleRecord){
        imageView.downloadedFrom(link: data.photoUrl)
        itemTitleLabel.text = data.ItemTitle
        priceLabel.text = data.price
        userNameLabel.text = data.username
        emailLabel.text = data.email
        locationLabel.text = data.location
    }
    
    @objc func backDismiss(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func callPhoneNumberAction(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://09420000001")! as NSURL
           UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
   
}


extension DetailViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(identifier: DetailListTableViewCell.identifier, indexPath: indexPath)as? DetailListTableViewCell else {
            return UITableViewCell()
        }
        return cell
        
    }
    
    
}



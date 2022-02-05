//
//  Extension.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import UIKit


extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
}

extension UITextField {
    
    func leftImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: imageWidth, height: frame.height)
        imageView.contentMode = .center
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(imageView)
        leftView = containerView
        leftViewMode = .always
    }
    
    var stringValue: String {
        return self.text ?? ""
    }
    
}


//MARK:-- UICollectionCell
extension UICollectionView {
    
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UICollectionViewCell>(withType type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
    
   
    
}
extension UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

//MARK:-- UITableViewCell

extension UITableViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UITableView {
    
    func registerForCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(identifier: String, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
    
    
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        // shadow
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.cornerRadius = 5
        
    }
    
    func bottomCurveView(scale: Bool = true){
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    }
    
    func curveView(){
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        layer.cornerRadius = 45
        backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.6823529412, blue: 0.631372549, alpha: 0.2)
    }
}

extension UIImageView{
    
    func topCurveView(){
        layer.cornerRadius = 5
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
   
}

extension UITextView {

    func setPlaceholder() {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Please Write Comment"
        placeholderLabel.sizeToFit()
        placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        placeholderLabel.tag = 1
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 15)
        placeholderLabel.textColor = UIColor.lightGray.withAlphaComponent(0.8)
        placeholderLabel.isHidden = !self.text.isEmpty
        self.addSubview(placeholderLabel)
    }

    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(1) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }

    var stringValue: String {
        return self.text ?? ""
    }

}

//MARK:-- imageview download
extension UIImageView {
    
    func downloadFrom(url:URL,contenMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data,response,error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                let data = data,error == nil,
                let image = UIImage(data: data)
                else{return}
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }

    func downloadedFrom(link:String,contentMode mode:UIView.ContentMode = .scaleAspectFill){
        guard let url = URL(string: link) else {return}
        downloadFrom(url: url,contenMode: mode)
    }

}

extension UIViewController{
    
    func setupBackNavigationBar(LeftButtonAction:Selector,navBarColor:UIColor,navTitle:String) {
        /// Left Bar Button
        var image = UIImage(named: "back")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: LeftButtonAction)
        
        navigationItem.title = navTitle
        
        if #available(iOS 15, *) {
            // Navigation Bar background color
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navBarColor
            
            // setup title font color
            let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = titleAttribute
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
    }
    
}





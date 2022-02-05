//
//  NavigationExt.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import Foundation
import UIKit

extension UIViewController{
    func navigateToLogout(){
        let alert = UIAlertController(title:"Logout", message: "Are you sure want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler: { (action) in
            let vc = loginVC
            self.present(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToDashBoardView(){
        let vc = UINavigationController(rootViewController: BaseTabBarViewController())
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

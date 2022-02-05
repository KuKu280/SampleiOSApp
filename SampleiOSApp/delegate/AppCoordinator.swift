//
//  AppCoordinator.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import UIKit

class AppCoordinator{
    
    private let window:UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start(){
        let storyboard = UIStoryboard.init(name: LOGINVIEW, bundle: nil)
        let vc = storyboard.instantiateViewController(ofType: LoginViewController.self)
        let nav = UINavigationController(rootViewController: vc)
        let initialViewController = nav
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
    }


}

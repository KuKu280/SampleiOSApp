//
//  BaseTabBarViewController.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarSetup()
        
    }
    
    func tabBarSetup(){
        tabBar.clipsToBounds = true
        viewControllers = [dashboardVC, messageVC , notificationVC, favouriteVC, profileVC]
        self.selectedIndex = 0
        self.tabBar.items![1].badgeValue = "8"
        self.tabBar.items![4].badgeValue = "1"
        tabBar.tintColor = UIColor(named: "main_color")
        tabBar.backgroundColor = UIColor(named: "tab_bar_color")
    }
    
    

    
}

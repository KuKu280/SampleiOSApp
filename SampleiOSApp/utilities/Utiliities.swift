//
//  Utiliities.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import Foundation
import UIKit
import CoreData

func printDebug(_ T: Any...) {
    #if DEBUG
    print(T)
    #endif
}


func createNavController(viewController: UIViewController, tabBarTitle: String, tabBarImage: UIImage? = UIImage() ) -> UIViewController {
    let navController = UINavigationController(rootViewController: viewController)
    navController.tabBarItem.title = tabBarTitle
    navController.tabBarItem.image = tabBarImage
    return navController
}

var baseViewVC: UIViewController = {
    let vc = BaseTabBarViewController()
    vc.modalTransitionStyle = .crossDissolve
    vc.modalPresentationStyle = .fullScreen
    return vc
}()

var loginVC: UIViewController = {
    let storyboard = UIStoryboard.init(name: LOGINVIEW, bundle: nil)
    let vc = storyboard.instantiateViewController(ofType: LoginViewController.self)
    let nav = UINavigationController(rootViewController: vc)
    nav.modalTransitionStyle = .crossDissolve
    nav.modalPresentationStyle = .fullScreen
    return nav
}()

var detailVC: UIViewController = {
    let storyboard = UIStoryboard.init(name: DETAILVIEW, bundle: nil)
    let vc = storyboard.instantiateViewController(ofType: DetailViewController.self)
    return vc
}()

var dashboardVC: UIViewController = {
    let storyboard = UIStoryboard.init(name: BASEVIEW, bundle: nil)
    let vc = storyboard.instantiateViewController(ofType: DashBoardViewController.self)
    return createNavController(viewController: vc,tabBarTitle: "Home", tabBarImage: UIImage(named: "home"))
}()

var messageVC: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .green
    return createNavController(viewController: vc, tabBarTitle: "Message",tabBarImage: UIImage(named: "message"))
}()

var notificationVC: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .orange
    return createNavController(viewController: vc, tabBarTitle: "Notification",tabBarImage: UIImage(named: "notification"))
}()

var favouriteVC: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .yellow
    return createNavController(viewController: vc, tabBarTitle: "Favourite",tabBarImage: UIImage(named: "favourite 1"))
}()

var profileVC: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .red
    return createNavController(viewController: vc, tabBarTitle: "Profile",tabBarImage: UIImage(named: "profile"))
}()









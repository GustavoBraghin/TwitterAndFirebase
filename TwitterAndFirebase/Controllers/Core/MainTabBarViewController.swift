//
//  ViewController.swift
//  TwitterAndFirebase
//
//  Created by Gustavo da Silva Braghin on 23/12/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let notificationsVC = UINavigationController(rootViewController: NotificationsViewController())
        let directMessageVC = UINavigationController(rootViewController: DirectMessagesViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        notificationsVC.tabBarItem.image = UIImage(systemName: "bell")
        notificationsVC.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        
        directMessageVC.tabBarItem.image = UIImage(systemName: "envelope")
        directMessageVC.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        
        setViewControllers([homeVC, searchVC, notificationsVC, directMessageVC], animated: true)
    }


}


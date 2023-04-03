//
//  ProductTabBarController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 27/3/23.
//

import UIKit

class ProductTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor  = .systemBackground
        
        let homeViewController = HomeViewController()
        let orderViewController = OrderViewController()
        let profileViewController = ProfileViewController()
        
        homeViewController.tabBarItem = UITabBarItem(
            title: "Inicio",
            image: UIImage(systemName: "house"), tag: 0)
        
        orderViewController.tabBarItem = UITabBarItem(
            title: "Ordenes",
            image: UIImage(systemName: "clock.arrow.circlepath"),
            tag: 1)
        
        profileViewController.tabBarItem = UITabBarItem(
            title: "Perfil",
            image: UIImage(systemName: "person"),
            tag: 2)
        
       viewControllers = [homeViewController, orderViewController, profileViewController]
        
    }

}

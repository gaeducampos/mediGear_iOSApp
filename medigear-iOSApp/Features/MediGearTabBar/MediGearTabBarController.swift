//
//  ProductTabBarController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 27/3/23.
//

import UIKit

class MediGearTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor  = .systemBackground
        tabBar.overrideUserInterfaceStyle = .light
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController(isResetPasswordVCPresented: false))
        let orderViewController = UINavigationController(rootViewController: OrdersViewController(isResetPasswordVCPresented: false))
        let profileViewController = UINavigationController(rootViewController: ProfileViewController(isResetPasswordVCPresented: false))
        
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

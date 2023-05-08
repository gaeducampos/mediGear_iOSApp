//
//  AppDelegate.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 8/3/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let cart: [CartProduct] = []
        let userLocation = ""
        let orderDetails: [String] = []
        // Get a reference to UserDefaults
        let defaults = UserDefaults.standard
        
        // Encode the array of objects as data
        let encodedCartProducts = try? JSONEncoder().encode(cart)
        
        // Store the encoded data in UserDefaults
        defaults.set(encodedCartProducts, forKey: "cart")
        defaults.set(userLocation, forKey: "userLocation")
        defaults.set(orderDetails, forKey: "orderDetails")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


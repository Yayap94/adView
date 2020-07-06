//
//  AppDelegate.swift
//  AdView
//
//  Created by Nicolas SABELLA on 02/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationViewController = UINavigationController()
        let adViewListViewController = AdViewListViewController()
        navigationViewController.viewControllers = [adViewListViewController]
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        return true
    }
}


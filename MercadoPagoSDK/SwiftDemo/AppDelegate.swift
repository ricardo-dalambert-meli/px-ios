//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by Matheus Leandro Martins on 04/02/21.
//  Copyright © 2021 MercadoPago. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let featureListController = FeatureListController()
        let featureList = featureListController
        window!.rootViewController = UINavigationController(rootViewController: featureList)
        window!.makeKeyAndVisible()
        return true
    }
}

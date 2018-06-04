//
//  AppDelegate.swift
//  news app for blockchain
//
//  Created by Sheng Li on 12/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        application.statusBarStyle = .lightContent
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = ThemeColor().themeColor()
        return true
    }
}

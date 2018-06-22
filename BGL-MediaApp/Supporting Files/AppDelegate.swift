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
        UINavigationBar.appearance().tintColor = UIColor.white
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        if launchedBefore{
            print("launched before")
        
            //set flag to false for debugging purpose
                        UserDefaults.standard.set(false, forKey: "launchedBefore")
            
        } else{
            
            print("first time launch")
            
            window = UIWindow(frame:UIScreen.main.bounds)
            let mainViewController = OnBoardingUIPageViewController()
            window?.rootViewController = mainViewController
            window?.makeKeyAndVisible()
            
            SetDataResult().writeJsonExchange()
            SetDataResult().writeMarketCapCoinList()
            GetDataResult().getCoinList()
            UserDefaults.standard.set("AUD", forKey: "defaultCurrency")
            UserDefaults.standard.set("EN", forKey: "defaultLanguage")
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        return true
    }
}

//
//  TabBarController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/22/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let historyController = HistoryController()
        let history = UINavigationController(rootViewController: historyController)
        history.tabBarItem.title = "History"
        let historyImage = UIImage.resizedImage(image: UIImage(named: "history")!, scaledToSize: CGSize(width: 25, height: 25))
        let hImage = historyImage.withRenderingMode(.alwaysOriginal)
        history.tabBarItem.image = hImage
        
        
        
        let homeController = HomeController()
        let home = UINavigationController(rootViewController: homeController)
        home.tabBarItem.title = "Home"
        
        //        history.tabBarItem.image = UIImage.resizedImage(image: UIImage(named: "history")!, scaledToSize: CGSize(width: 22, height: 22))
        let homeImage = UIImage.resizedImage(image: UIImage(named: "home1")!, scaledToSize: CGSize(width: 25, height: 25))
        //        historyImage.renderingMode = UIImage.RenderingMode.alwaysOriginal
        let hoImage = homeImage.withRenderingMode(.alwaysOriginal)
        home.tabBarItem.image = hoImage
        

   
        let settingsController = SettingsController()
        let settings = UINavigationController(rootViewController: settingsController)
        settings.tabBarItem.title = "Settings"
        let settingImage = UIImage.resizedImage(image: UIImage(named: "settings-icon")!, scaledToSize: CGSize(width: 25, height: 25))
        //        historyImage.renderingMode = UIImage.RenderingMode.alwaysOriginal
        let sImage = settingImage.withRenderingMode(.alwaysOriginal)
        settings.tabBarItem.image = sImage
        
    
//        let settingsController = SettingsController()
//        let settings = UINavigationController(rootViewController: settingsController)
//        settings.tabBarItem.title = "Settings"
//        settings.tabBarItem.image = UIImage(named: "settings-icon")
        viewControllers = [home, history, settings]
        
        tabBar.isTranslucent = false
        let grayIconColorP3 = UIColor(displayP3Red: 200.0/255.0, green: 204.0/255.0, blue: 211.0/255.0, alpha: 1.0)
        tabBar.unselectedItemTintColor = grayIconColorP3
        tabBar.tintColor = COLOR_TABBAR
    }
}

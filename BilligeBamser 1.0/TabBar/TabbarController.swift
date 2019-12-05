//
//  ViewControllerBajer.swift
//  BilligeBamser1.0
//
//  Created by Nicolai Dam on 23/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabbarController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = #colorLiteral(red: 0.1949159264, green: 0.1949159264, blue: 0.1960784314, alpha: 1)
        
        shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "opretBajer") 
                tabbarController.present(newViewController, animated: true, completion: nil)
                
                return true
            }
            return false
        }
        
        
        if let tabBar = self.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil) 
        let v1Nav = storyBoard.instantiateViewController(withIdentifier: "udforskVC") as! UINavigationController
        
        let v2Nav = storyBoard.instantiateViewController(withIdentifier: "mapVC") as! UINavigationController
        
        let v3 = UIViewController()
        let v3Nav = UINavigationController(rootViewController: v3)
        
        let v4Nav = storyBoard.instantiateViewController(withIdentifier: "favoVC2") as! UINavigationController
        
        let v5Nav = storyBoard.instantiateViewController(withIdentifier: "mereVC") as! UINavigationController
        
        if #available(iOS 13.0, *) {
            
            v1Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(), image: UIImage(named: "udforskGrey"), selectedImage: UIImage(named: "udforskGrey")?.withTintColor(UIColor.white))
            
            v2Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(), image: UIImage(named: "mapGrey"), selectedImage: UIImage(named: "mapGrey")?.withTintColor(UIColor.white))
            
            v3Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(), image: UIImage(systemName: "plus.circle.fill")?.withTintColor(UIColor.white), selectedImage: UIImage(systemName: "plus.circle.fill")?.withTintColor(UIColor.white))
            
            v4Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(),image: UIImage(named: "favoGrey"), selectedImage: UIImage(named: "favoOrange")?.withTintColor(UIColor.white))
            
            v5Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(), image: UIImage(named: "mereGrey"), selectedImage: UIImage(named: "mereOrange")?.withTintColor(UIColor.white))
            
        } else {
            // Fallback on earlier versions
        }
        
        
        self.viewControllers = [v1Nav, v2Nav, v3Nav, v4Nav, v5Nav]
        modalPresentationStyle = .fullScreen
        
    }
}

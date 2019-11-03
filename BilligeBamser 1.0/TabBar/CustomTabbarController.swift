//
//  CustomTabbarController.swift
//  dataSpringMobile
//
//  Created by huaqi.xue on 2018/5/17.
//  Copyright © 2018年 Marketing Applications.inc. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class CustomTabbarController: ESTabBarController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = UIColor.white
        
        shouldHijackHandler = {
                   tabbarController, viewController, index in
                   if index == 2 {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let newViewController = storyBoard.instantiateViewController(withIdentifier: "opretBajer") as! UIViewController
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
        
       let v4Nav = storyBoard.instantiateViewController(withIdentifier: "favoVC") as! UINavigationController
        
        let v5Nav = storyBoard.instantiateViewController(withIdentifier: "mereVC") as! UINavigationController
        
        v1Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(), image: UIImage(named: "udforskGrey"), selectedImage: UIImage(named: "udforskOrange"))
        v2Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(), image: UIImage(named: "mapGrey"), selectedImage: UIImage(named: "mapOrange"))
        
        v3Nav.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "photo_verybig_1"), selectedImage: UIImage(named: "photo_verybig_1"))
        
        
        v4Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(),image: UIImage(named: "favoGrey"), selectedImage: UIImage(named: "favoOrange"))
        v5Nav.tabBarItem = ESTabBarItem.init(TabBarContentView(), image: UIImage(named: "mereGrey"), selectedImage: UIImage(named: "mereOrange"))
        
        self.viewControllers = [v1Nav, v2Nav, v3Nav, v4Nav, v5Nav]
        modalPresentationStyle = .fullScreen
      
    }
}

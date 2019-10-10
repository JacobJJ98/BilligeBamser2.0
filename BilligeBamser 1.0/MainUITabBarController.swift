//
//  UITabBarController.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 09/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class MainUITabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        setupMiddleButton()
    }
    
    // MARK: - Setups
    
    func setupMiddleButton() {
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/6, height: self.view.frame.size.width/6))
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
         menuButton.setImage(UIImage(named: "ikonPlus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        menuButton.backgroundColor=UIColor.white
        menuButton.tintColor=#colorLiteral(red: 0.2529999912, green: 0.7429999709, blue: 0.5220000148, alpha: 1)
        menuButton.frame = menuButtonFrame
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
       
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        
        view.layoutIfNeeded()
    }

    
    
    // MARK: - Actions
    
    @objc private func menuButtonAction(sender: UIButton) {
        print("OpretBajer knap er trykket")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "opretBajer") as! OpretBajerViewController
        self.present(newViewController, animated: true, completion: nil)
        
        
    }

}

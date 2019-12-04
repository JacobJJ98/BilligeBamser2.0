//
//  ViewControllerBajer.swift
//  BilligeBamser1.0
//
//  Created by Nicolai Dam on 23/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import ESTabBarController_swift

//Dette er et normalt item i vores tabbar

class TabBarContentView: ESTabBarItemContentView {
    
    public var duration = 0.5
    override init(frame: CGRect) {
        super.init(frame: frame)
       // highlightTextColor = UIColor.blue
        renderingMode = .alwaysOriginal
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.3, 0.9, 1.1, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
    
}

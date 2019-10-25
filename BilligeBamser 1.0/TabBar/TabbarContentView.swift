//
//  TabbarContentView.swift
//  dataSpringMobile
//
//  Created by huaqi.xue on 2018/5/17.
//  Copyright © 2018年 Marketing Applications.inc. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarContentView: ESTabBarItemContentView {
    
    public var duration = 1.0
    override init(frame: CGRect) {
        super.init(frame: frame)
        highlightTextColor = UIColor.blue
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
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
    
}

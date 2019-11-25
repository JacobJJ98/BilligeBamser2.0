//
//  buttonStyleBorder.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 01/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class buttonStyleRoundedBorder: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        layer.cornerRadius  = frame.size.height/2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
    }
}

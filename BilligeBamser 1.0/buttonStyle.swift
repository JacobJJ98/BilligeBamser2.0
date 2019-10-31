//
//  buttonStyle.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 31/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class buttonStyle: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        backgroundColor     = UIColor.green
        titleLabel?.font    = UIFont(name:  "avenirNextCondensedDemiBold", size: 22)
        layer.cornerRadius  = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
}

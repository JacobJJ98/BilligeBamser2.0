//
//  Verificering.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 04/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation

class Verificering {

    func isEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    func
    
    
    
}



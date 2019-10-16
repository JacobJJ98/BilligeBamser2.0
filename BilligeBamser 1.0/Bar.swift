//
//  Bar.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation

class Bar {
    var flaskepris: Int
    var latitude: Double
    var longitude: Double
    var navn: String
    var rygning: Bool
    
    init(flaskepris: Int, latitude: Double, longitude: Double, navn: String, rygning: Bool) {
        self.flaskepris = flaskepris
        self.latitude = latitude
        self.longitude = longitude
        self.navn = navn
        self.rygning = rygning
    }
    
}

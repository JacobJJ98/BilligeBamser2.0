//
//  Bar.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation
import MapKit

class Bar: NSObject, MKAnnotation {
    var id: String = ""
    var flaskepris: Int
    var navn: String
    var rygning: Bool
    let coordinate: CLLocationCoordinate2D
    
    init(flaskepris: Int, navn: String, rygning: Bool, coordinate: CLLocationCoordinate2D) {
        self.flaskepris = flaskepris
        self.navn = navn
        self.rygning = rygning
        self.coordinate = coordinate
    }
    
}

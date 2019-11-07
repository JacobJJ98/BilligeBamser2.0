//
//  Barv2.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 07/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation

import Foundation
import MapKit

class Bar2: NSObject, MKAnnotation {
    var id: String
    var flaskepris: Int
    var navn: String
    var rygning: Bool
    let coordinate: CLLocationCoordinate2D
    var isFavorite: Bool
    
    init(id: String, flaskepris: Int, navn: String, rygning: Bool, coordinate: CLLocationCoordinate2D, isFavorite: Bool) {
        self.id = id
        self.flaskepris = flaskepris
        self.navn = navn
        self.rygning = rygning
        self.coordinate = coordinate
        self.isFavorite = isFavorite
    }
    
}

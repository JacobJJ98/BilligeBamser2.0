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
    let title: String?
    let subtitle: String?
    var id: String?
    var flaskepris: Int
    var navn: String
    var rygning: Bool
    let coordinate: CLLocationCoordinate2D
    var afstand: String?
    var erFavo: Bool?
    
    init(flaskepris: Int, navn: String, rygning: Bool, coordinate: CLLocationCoordinate2D) {
        self.flaskepris = flaskepris
        self.navn = navn
        self.subtitle = "\(flaskepris) kr"
        self.title = navn
        self.rygning = rygning
        self.coordinate = coordinate
    }
    
    /*
     Følgende func er taget fra: https://stackoverflow.com/questions/35199363/sort-array-by-calculated-distance-in-swift
     */
    func distance(to location: CLLocation) -> CLLocationDistance {
        let selfloca = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        return location.distance(from: selfloca)
    }
}

/*
 Følgende extension af Array er taget fra https://stackoverflow.com/questions/35199363/sort-array-by-calculated-distance-in-swift
    dog er enkelte rettelser lavet, for at tilpasse vores kode.
 */
extension Array where Element == Bar {

    mutating func sort(by location: CLLocation) {
        return sort(by: { $0.distance(to: location) < $1.distance(to: location) })
    }

    func sorted(by location: CLLocation) -> [Bar] {
        return sorted(by: { $0.distance(to: location) < $1.distance(to: location) })
    }

}

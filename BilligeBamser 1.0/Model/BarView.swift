//
//  BarView.swift
//  BilligeBamser1.0
//
//  Created by Jacob Jørgensen on 09/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation
import MapKit

class BarView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let artwork = newValue as? Bar else { return }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      // 2
      // markerTintColor = artwork.markerTintColor
        glyphText = String(artwork.flaskepris)
    }
  }
}
class BarView2: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
        print("INDE I BARVIEW2ø-------------------")
      guard let artwork = newValue as? Bar else {return}
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      // rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
           size: CGSize(width: 30, height: 30)))
        mapsButton.setBackgroundImage(UIImage(named: "mapOrange"), for: UIControl.State())
        rightCalloutAccessoryView = mapsButton
        // det er muligt at have en knap på venstre side også, evt favorti
        // leftCalloutAccessoryView = UIButton(type: .detailDisclosure)
         
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        label.center = CGPoint(x:15, y: 40)
        label.textAlignment = .center
        label.text = "\(artwork.flaskepris) kr"
        addSubview(label)
        
print("INDE I BARVIEW2ø-------------------")
        // sætter billedet som skal markere barerne på kortet!!
        image = UIImage(named: "beerBottle")
      
    }
  }
}

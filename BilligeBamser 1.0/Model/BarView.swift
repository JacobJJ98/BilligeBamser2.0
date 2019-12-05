//
//  BarView.swift
//  BilligeBamser1.0
//
//  Created by Jacob Jørgensen on 09/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation
import MapKit

class BarView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
        guard (newValue as? Bar) != nil else {return}
        let bar = newValue as! Bar
        canShowCallout = true
        calloutOffset = CGPoint(x: 0, y: 10)
        
        let kortKnappen = UIButton(frame: CGRect(origin: CGPoint.zero,
           size: CGSize(width: 30, height: 30)))
        kortKnappen.setBackgroundImage(UIImage(named: "route75"), for: UIControl.State())
        rightCalloutAccessoryView = kortKnappen
        
    
        
        // sætter billedet som skal markere barerne på kortet!!
        image = self.billedeForPris(price: bar.flaskepris)
    }
  }
    
    func billedeForPris(price: Int) -> UIImage {
        if let image = UIImage(named: "øl\(price)kr") {
            return image
        } else {
            return UIImage(named: "øl5kr")!
        }
    }
}

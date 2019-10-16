//
//  MapViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location in Honolulu
        let locationManager = CLLocationManager()
        
        // Denne her skal flyttes hen når man opretter sig tænker jeg. Så man tillader der!!
        locationManager.requestWhenInUseAuthorization()
        
        //Resterende sørger for at sætte current location som der hvor Map starter!!
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            if let lokationen = locationManager.location {
                let initialLocation = CLLocation(latitude: lokationen.coordinate.latitude, longitude: lokationen.coordinate.longitude)
                centerMapOnLocation(location: initialLocation)
            }
        
    }

        }
    override func viewDidDisappear(_ animated: Bool) {
        
        mapView.removeAnnotations(BarListe.shared.barer)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        print("APPEAR MAP!!")
            for bar in BarListe.shared.barer {
                mapView.addAnnotation(bar)
            }
        }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(coordinateRegion, animated: true)
    }
    

   
}

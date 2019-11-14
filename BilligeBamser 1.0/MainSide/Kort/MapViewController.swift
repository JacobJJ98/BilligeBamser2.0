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

    let regionRadius: CLLocationDistance = 350
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(BarView2.self,
        forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let locationManager = CLLocationManager()
        
        //Hvid status bar
      
      
        //Resterende sørger for at sætte current location som der hvor Map starter!!
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            if let lokationen = locationManager.location {
                let initialLocation = CLLocation(latitude: lokationen.coordinate.latitude, longitude: lokationen.coordinate.longitude)
                centerMapOnLocation(location: initialLocation)
            }
            
             mapView.showsUserLocation = true
        
    }

        }
    override func viewDidDisappear(_ animated: Bool) {
        
        print("DISAPEAR!")
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
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(coordinateRegion, animated: true)
    }
    

   
}

extension MapViewController: MKMapViewDelegate {
    // Hvad sker der når man trykker på info knappen!!
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
        print("TRYKKET!!!")
        print(mapView.annotations.count)
        if let baren = view.annotation {
            let coordinate = CLLocationCoordinate2DMake(baren.coordinate.latitude,baren.coordinate.longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = baren.title!
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
        
        
    }
}

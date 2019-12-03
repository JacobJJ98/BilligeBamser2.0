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
import SVProgressHUD
 
class MapViewController: UIViewController, CLLocationManagerDelegate {
 
    let regionRadius: CLLocationDistance = 350
    @IBOutlet var mapView: MKMapView!
    var UIVE : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(BarView2.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let locationManager = CLLocationManager()
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
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.center = mapView.center
         // button.backgroundColor = UIColor.red
          button.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "refresh35.png"))
       //  button.setTitle("iOSDevCenters Click", for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        
       // button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
       // button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
         
           mapView.addSubview(button)
        
        let text = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isHidden = true
        if #available(iOS 13.0, *) {
            text.textColor = .label
        } else {
            // Fallback on earlier versions
            text.textColor = .black
        }
        text.backgroundColor = .clear
        text.text = "Kortet er opdaret"
        mapView.addSubview(text)
   
        // let newView = RefreshButton()
        // newView.backgroundColor = UIColor.red
        // view.addSubview(newView)
 
      //  newView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint2 = button.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 10)
        let verticalConstraint2 = button.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10)
        
        let horizontalConstraint2TEXT = text.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0)
        let verticalConstraint2TEXT = text.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10)
       // let horizontalConstraint = newView.rightAnchor.constraint(equalTo: mapView.rightAnchor)
       // let verticalConstraint = newView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint2, verticalConstraint2,horizontalConstraint2TEXT, verticalConstraint2TEXT])
        
      
    }
    @objc func buttonClicked() {
    print("Button Clicked")
        
       for view in self.mapView.subviews {
            if let textField = view as? UITextField {
                textField.isHidden = false
                self.viewDidDisappear(false)
                self.viewDidAppear(false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    textField.isHidden = true
                }
                print(textField.text!)
            }
        }
        
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        
        print("DISAPEAR!")
        mapView.removeAnnotations(BarListe.shared.barer)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        print("Appear!")
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
        if let baren = view.annotation {
            let coordinate = CLLocationCoordinate2DMake(baren.coordinate.latitude,baren.coordinate.longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = baren.title!
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }
}
 
class RefreshButton: UIView {
 
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
 
}
 
 
 



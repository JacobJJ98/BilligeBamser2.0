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
 
    let storrelsePaaRegion: CLLocationDistance = 350
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(BarView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let lokationsManager = CLLocationManager()
        
        //Resterende sørger for at sætte current location som der hvor Map starter!!
            lokationsManager.delegate = self
            lokationsManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            lokationsManager.startUpdatingLocation()
            if let lokationen = lokationsManager.location {
                let startPos = CLLocation(latitude: lokationen.coordinate.latitude, longitude: lokationen.coordinate.longitude)
                self.kortetsStartPosition(brugerenLoka:startPos)
            }
             mapView.showsUserLocation = true
        
        // laver en refresh knap til venstre hjørne
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "refresh35.png"))
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
           mapView.addSubview(button)
        
        // laver en label der kommer frem ved opdatering
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
        text.text = "Kortet er opdateret"
        text.font = UIFont(name:"TreBuchet MS",size:18)
        mapView.addSubview(text)
        
        // laver constrains for knap og label
        let horizontalConstraint2 = button.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 10)
        let verticalConstraint2 = button.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10)
        
        let horizontalConstraint2TEXT = text.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0)
        let verticalConstraint2TEXT = text.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([horizontalConstraint2, verticalConstraint2,horizontalConstraint2TEXT, verticalConstraint2TEXT])
        
      
    }
    
    @objc func buttonClicked() {
       for view in self.mapView.subviews {
            if let textField = view as? UITextField {
                textField.isHidden = false
                self.viewDidDisappear(false)
                self.viewDidAppear(false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    textField.isHidden = true
                }
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        mapView.removeAnnotations(BarListe.shared.barer)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        for bar in BarListe.shared.barer {
            mapView.addAnnotation(bar)
        }
        
    }
    func kortetsStartPosition(brugerenLoka: CLLocation) {
      mapView.setRegion(MKCoordinateRegion(center: brugerenLoka.coordinate, latitudinalMeters: storrelsePaaRegion, longitudinalMeters: storrelsePaaRegion), animated: true)
    }
    
 
   
}
 
extension MapViewController: MKMapViewDelegate {
    // Hvad sker der når man trykker på info knappen!!
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
        if let baren = view.annotation {
            let kordinatPaaBaren = CLLocationCoordinate2DMake(baren.coordinate.latitude,baren.coordinate.longitude)
            let kortItem = MKMapItem(placemark: MKPlacemark(coordinate: kordinatPaaBaren, addressDictionary:nil))
            kortItem.name = baren.title!
            kortItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }
}
 
 
 



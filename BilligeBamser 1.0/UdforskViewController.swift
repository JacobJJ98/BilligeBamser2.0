//
//  UdforskViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import MapKit
import FirebaseCore
import FirebaseFirestore
import SVProgressHUD

class UdforskViewController: UIViewController {
    var db: Firestore!
       

       override func viewDidLoad() {
           super.viewDidLoad()
           print("INDE I OPRETBAJER")
       }
    
    // lavet for at teste om kortet opdatere rigtigt når der ændres i DB. Så dette skal nok ikke være der endeligt!
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show()
        BarListe.shared.barer.removeAll()
        self.HentBarer()
        
    }
       
       func HentBarer() -> Void {
            db = Firestore.firestore()
            
            var ref: DocumentReference? = nil
            var midlerPris = 1
            var midlerLati = 1.1
            var midlerLong = 1.1
            var midlerNavn = ""
            var midlerRyg = true
            
            db.collection("Bar").getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let flaskepris = document.data()["flaskepris"] as? Int {
                            midlerPris = flaskepris
                                             print("\(flaskepris)")
                            
                                           }
                        if let latitude = document.data()["latitude"] as? String {
                            if let latitudeDouble = Double(latitude) {
                                midlerLati = latitudeDouble
                                print("\(latitudeDouble)")
                            }
                          
                        }
                        if let longitude = document.data()["longitude"] as? String {
                            if let longitudeDouble = Double(longitude) {
                                midlerLong = longitudeDouble
                                print("\(longitudeDouble)")
                            }
                            
                        }
                        if let Name = document.data()["navn"] as? String {
                            midlerNavn = Name
                          print(Name)
                        }
                        if let rygning = document.data()["rygning"] as? Bool {
                            midlerRyg = rygning
                          print("\(rygning)")
                        }
                       var kor = CLLocationCoordinate2D()
                       kor.latitude = midlerLati
                       kor.longitude = midlerLong
                       var baren = Bar(flaskepris: midlerPris, navn: midlerNavn, rygning: midlerRyg, coordinate: kor)
                        BarListe.shared.addBar(bar: baren)
                    }
                }
            }
            
           print("BAREN UDSKRIVES: ")
           BarListe.shared.udskrivTest()
        SVProgressHUD.dismiss(withDelay: 2)
            
       }
    

}

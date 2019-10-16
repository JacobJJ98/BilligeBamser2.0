//
//  OpretBajerViewController.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 09/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class OpretBajerViewController: UIViewController {

    var db: Firestore!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("INDE I OPRETBAJER")
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
                     var baren = Bar(flaskepris: midlerPris, latitude: midlerLati, longitude: midlerLong, navn: midlerNavn, rygning: midlerRyg)
                     BarListe.shared.addBar(bar: baren)
                 }
             }
         }
         
        print("BAREN UDSKRIVES: ")
        BarListe.shared.udskrivTest()
         
    }
    
    @IBAction func tilbage(_ sender: UIButton) {
        performSegueToReturnBack()
    }
    
    func performSegueToReturnBack()  {
        
            self.dismiss(animated: true, completion: nil)
        
    }
   
}

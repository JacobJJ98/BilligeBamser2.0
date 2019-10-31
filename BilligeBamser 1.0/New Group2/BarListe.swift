//
//  BarListe.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import MapKit

class BarListe {
    
    var db: Firestore!
    
    static let shared = BarListe()
    var barer: [Bar] = []
    var brugerLoggetind: Bruger
    var egneFavoritter: [Bar] = []
    

    private init()
    {
        brugerLoggetind = Bruger(fornavn: "", efternavn: "", favoritsteder: [""])
    }
    
    func addBar(bar: Bar) -> Void {
        barer.insert(bar, at: barer.count)
    }
    
    func udskrivTest() -> String {
        let tekst = "Antal Barer: \(barer.count)"
        return tekst
    }
    
    func HentBarer() -> Void {
        barer.removeAll()
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
                self.hentBruger()
             }
         }
     
        
    }
    
    func hentBruger() -> Void {
        self.egneFavoritter.removeAll()
        self.brugerLoggetind.Favoritsteder.removeAll()
        print("INDE I HENT FAVORITTER!!!!!")
        print(Auth.auth().currentUser!.uid)
        // først hentes den bruger der er logget ind
        db = Firestore.firestore()
        let docRef = db.collection("Bruger").document(Auth.auth().currentUser!.uid)
        docRef.getDocument { (document, error) in
            if let document = document {
                print("ER IGANG MED AT HENTE BRUGEREN!!")
                if let fornavn =  document.data()!["Fornavn"] as? String {
                    print("FORNAVNET ER")
                    print(fornavn)
                    self.brugerLoggetind.Fornavn = fornavn
                }
                if let efternavn = document.data()!["Efternavn"] as? String {
                    print("EFTERNAVNET ER")
                    print(efternavn)
                    self.brugerLoggetind.Efternavn = efternavn
                }
                if let favoritsteder = document.data()!["Favoritsteder"] as? [String] {
                                   print("Favoritsteder ER")
                                    print(favoritsteder.count)
                    self.brugerLoggetind.Favoritsteder = favoritsteder
                    for sted in favoritsteder {
                        print(sted)
                    }
                               }
                
                self.indlaesFavoriter()
            } else {
                print("Document does not exist")
            }
        }
        
        
 
        
    }
    func indlaesFavoriter() -> Void {
        
        // hent favoritbarerne fra Firebase
        var midlerPris = 1
        var midlerLati = 1.1
        var midlerLong = 1.1
        var midlerNavn = ""
        var midlerRyg = true
        
        for sted in self.brugerLoggetind.Favoritsteder {
            let docRef = db.collection("Bar").document(sted)
            docRef.getDocument { (document, error) in
            if let document = document, document .exists {
                if let flaskepris = document.data()!["flaskepris"] as? Int {
                     midlerPris = flaskepris
                     
                                    }
                if let latitude = document.data()!["latitude"] as? String {
                     if let latitudeDouble = Double(latitude) {
                         midlerLati = latitudeDouble
                     }
                   
                 }
                if let longitude = document.data()!["longitude"] as? String {
                     if let longitudeDouble = Double(longitude) {
                         midlerLong = longitudeDouble
                     }
                     
                 }
                if let Name = document.data()!["navn"] as? String {
                     midlerNavn = Name
                 }
                if let rygning = document.data()!["rygning"] as? Bool {
                     midlerRyg = rygning
                 }
                var kor = CLLocationCoordinate2D()
                kor.latitude = midlerLati
                kor.longitude = midlerLong
                var baren = Bar(flaskepris: midlerPris, navn: midlerNavn, rygning: midlerRyg, coordinate: kor)
                self.egneFavoritter.insert(baren, at: self.egneFavoritter.count)
            } else {
                print("Document does not exist")
            }
                
                
            
            
        }
               
            
            
        
        }
    }
    
    
}
    


    


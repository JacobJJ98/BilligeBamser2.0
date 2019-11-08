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
        brugerLoggetind = Bruger(navn: "", favoritsteder: [""])
    }
    func logOut() -> Void {
        barer.removeAll()
        brugerLoggetind.navn = ""
        brugerLoggetind.Favoritsteder.removeAll()
        egneFavoritter.removeAll()
    }
    func tilføjBruger(bruger: Bruger) -> Void {
        self.egneFavoritter.removeAll()
        self.brugerLoggetind.Favoritsteder.removeAll()
        self.brugerLoggetind = bruger
    }
    func addBar(bar: Bar) -> Void {
        barer.insert(bar, at: barer.count)
    }
    
    func udskrivTest() -> String {
        let tekst = "Antal Barer: \(barer.count)"
        return tekst
    }
    func udskrivTestFavo() -> Void {
        print("INDE I FAVO PRINT!")
        print(egneFavoritter.count)
        for bar in egneFavoritter {
            print(bar.id)
        }
    }
    func udskrivTestBarer() -> Void {
        print("INDE I BAR PRINT!")
        print(barer.count)
        for bar in barer {
            print(bar.id)
        }
    }
    
    func findFavo() -> Void {
        egneFavoritter.removeAll()
        for favo in brugerLoggetind.Favoritsteder {
            for bar in barer {
                if favo == bar.id {
                    egneFavoritter.insert(bar, at: egneFavoritter.count)
                }
            }
        }
        print("FIND FAVO ER KØRT!!!------")
        print(egneFavoritter.count)
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
    


    


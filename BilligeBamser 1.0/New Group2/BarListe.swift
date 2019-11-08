//
//  BarListe.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation
import MapKit

class BarListe {
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
    
}
    


    


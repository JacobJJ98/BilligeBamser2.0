//
//  BarListe.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import Foundation
class BarListe {
    
    static let shared = BarListe()
    var barer: [Bar] = []
    

    private init()
    {
       
    }
    
    func addBar(bar: Bar) -> Void {
        barer.insert(bar, at: barer.count)
    }
    
    func udskrivTest() -> String {
        let tekst = "Antal Barer: \(barer.count)"
        return tekst
    }
    
}

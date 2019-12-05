//
//  Bruger.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 31/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

class Bruger {
    var navn: String
    var Favoritsteder: [String]
    
    init(navn: String, favoritsteder: [String]) {
        self.navn = navn
        self.Favoritsteder = favoritsteder
    }
    
    func sletFavorit(ID: String) {
        for (index, fav) in Favoritsteder.enumerated() {
            if(fav==ID) {
                self.Favoritsteder.remove(at: index)
            }
        }
    }
    
   public func tilføjFavorit(ID: String) {
        self.Favoritsteder.append(ID)
    }
    
}

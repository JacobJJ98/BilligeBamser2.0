//
//  Bruger.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 31/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

class Bruger {
    var Fornavn: String
    var Efternavn: String
    var Favoritsteder: [String]
    
    init(fornavn: String, efternavn: String, favoritsteder: [String]) {
        self.Fornavn = fornavn
        self.Efternavn = efternavn
        self.Favoritsteder = favoritsteder
    }
    
}

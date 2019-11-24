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
    var nærmeste: [String]
    
    init(navn: String, favoritsteder: [String], nærmeste: [String]) {
        self.navn = navn
        self.Favoritsteder = favoritsteder
        self.nærmeste = nærmeste
    }
    
}

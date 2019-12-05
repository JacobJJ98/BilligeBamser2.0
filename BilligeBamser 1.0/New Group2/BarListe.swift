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
    var mail: String
    var barerNærmeste: [Bar] = []
    var barerBilligste: [Bar] = []
    
    

    private init()
    {
        brugerLoggetind = Bruger(navn: "", favoritsteder: [""])
        mail = ""
    }
    func logOut() -> Void {
        barer.removeAll()
        brugerLoggetind.navn = ""
        brugerLoggetind.Favoritsteder.removeAll()
        egneFavoritter.removeAll()
        barerNærmeste.removeAll()
    }
    func refresh() -> Void {
        barer.removeAll()
        egneFavoritter.removeAll()
        barerNærmeste.removeAll()
    }
    func tilføjBruger(bruger: Bruger) -> Void {
        self.egneFavoritter.removeAll()
        self.barerNærmeste.removeAll()
        self.brugerLoggetind.Favoritsteder.removeAll()
        self.brugerLoggetind = bruger
    }
    func addBar(bar: Bar) -> Void {
        barer.insert(bar, at: barer.count)
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
    }
    
    
    
    
    func sorterFavoEfterAfsted(loka: CLLocation) -> Void {
        egneFavoritter.sort(by: loka)
        
        }
    
    func sorterNærmesteEfterAfsted(loka: CLLocation) -> Void {
        barerNærmeste.sort(by: loka)
    
    }
    func sorterBilligsteEfterPris() -> Void {
        
        var nytArr: [String: Int] = [:]
        for bar in barer {
            var pris: Int = bar.flaskepris
            nytArr.updateValue(bar.flaskepris, forKey: bar.id!)
        }
        let sorteretArr = nytArr.sorted { $0.1 < $1.1 }
        
        for barDic in sorteretArr {
            for bar in barer {
                if bar.id == barDic.key {
                    barerBilligste.append(bar)
                }
            }
        }
    
    }
    
    func sletFavorit(ID: String) {
        for (index, fav) in egneFavoritter.enumerated() {
            if(fav.id==ID) {
                self.egneFavoritter.remove(at: index)
                return
            }
        }
    }
    func tilføjFavorit(ID: String) {
        for (index,bar) in barer.enumerated() {
            if(bar.id==ID){
                  self.egneFavoritter.append(barer[index])
            }
        }
        
      

    }

    
}
    

    


    


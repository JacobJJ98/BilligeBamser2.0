//
//  BarListeTest.swift
//  BilligeBamser1.0Tests
//
//  Created by Jacob Jørgensen on 29/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import XCTest
import MapKit
@testable import BilligeBamser1_0


class BarListeTest: XCTestCase {
    
    func testFindFavo() {
        // opretter 1 bruger med en favorit bar
        let user = Bruger(navn: "Test", favoritsteder: ["1234512345"], nærmeste: [])
        // opretter to testbarer, hvor en af dem er users favoritbar. Barerne tilføjes til BarListens liste af barer
        let coordinate = CLLocationCoordinate2D(latitude: 123, longitude: 123)
        let barFavo = Bar(flaskepris: 23, navn: "TESTBAR", rygning: false, coordinate: coordinate)
        barFavo.id = "1234512345"
        BarListe.shared.addBar(bar: barFavo)
        
        let bar = Bar(flaskepris: 23, navn: "TESTBAR2", rygning: false, coordinate: coordinate)
        bar.id = "vj4jvji4"
        
        BarListe.shared.addBar(bar: bar)
        
        //brugeren puttes ind i BarListe
        BarListe.shared.brugerLoggetind = user
        //Favoritter findes
        BarListe.shared.findFavo()
        
        //Der tjekkes om favoritten er kommet ind i favoritarrayet
        var result = false
        if BarListe.shared.egneFavoritter[0].id == "1234512345" {
            result = true
        }
        
        XCTAssertTrue(result)
    }

    
    func testSorterBilligsteEfterPris() {
            for n in 1...100 {
             // opretter to testbarer, hvor en af dem er users favoritbar. Barerne tilføjes til BarListens liste af barer
                let coordinate = CLLocationCoordinate2D(latitude: 123, longitude: 123)
                let number = Int.random(in: 10 ..< 30)
                       let bar = Bar(flaskepris: number, navn: "TESTBAR", rygning: false, coordinate: coordinate)
                       bar.id = "1234512345\(n)"
                       BarListe.shared.addBar(bar: bar)
        }
        print("ANTAL BARER: \(BarListe.shared.barer.count)")
        
        BarListe.shared.sorterBilligsteEfterPris()
        
        var result = true
        for n in 1...99 {
            // print("PRISEN ER: \(BarListe.shared.barerBilligste[n-1].flaskepris)")
            if BarListe.shared.barerBilligste[n-1].flaskepris > BarListe.shared.barerBilligste[n].flaskepris {
                result = false
                break
            }
        }
        XCTAssertTrue(result)

    }
    
    func testTilfojBruger() {
        let user = Bruger(navn: "Test", favoritsteder: ["1234512345"], nærmeste: [])
        
        BarListe.shared.tilføjBruger(bruger: user)
        
        var result = true
        if BarListe.shared.brugerLoggetind.navn != user.navn || BarListe.shared.brugerLoggetind.Favoritsteder[0] != user.Favoritsteder[0] {
            result = false
        }
        
        XCTAssertTrue(result)
    }
    
    func testLogOut() {
        let user = Bruger(navn: "Test", favoritsteder: ["1234512345"], nærmeste: [])
        BarListe.shared.tilføjBruger(bruger: user)
        
        for n in 1...100 {
             // opretter to testbarer, hvor en af dem er users favoritbar. Barerne tilføjes til BarListens liste af barer
                let coordinate = CLLocationCoordinate2D(latitude: 123, longitude: 123)
                let number = Int.random(in: 10 ..< 30)
                       let bar = Bar(flaskepris: number, navn: "TESTBAR", rygning: false, coordinate: coordinate)
                       bar.id = "1234512345f\(n)"
                       BarListe.shared.addBar(bar: bar)
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: 123, longitude: 123)
        let barFavo = Bar(flaskepris: 23, navn: "TESTBAR", rygning: false, coordinate: coordinate)
        barFavo.id = "1234512345"
        BarListe.shared.addBar(bar: barFavo)
        
        BarListe.shared.findFavo()
        
        BarListe.shared.logOut()
        
        
        
        
        var result = true
        
        if BarListe.shared.egneFavoritter.count != 0 || BarListe.shared.barer.count != 0 || BarListe.shared.brugerLoggetind.Favoritsteder.count != 0 || BarListe.shared.barerNærmeste.count != 0  {
            result = false
        }
        
        XCTAssertTrue(result)
    }
    
    func testRefresh() {
        let user = Bruger(navn: "Test", favoritsteder: ["1234512345"], nærmeste: [])
        BarListe.shared.tilføjBruger(bruger: user)
        
        for n in 1...100 {
             // opretter to testbarer, hvor en af dem er users favoritbar. Barerne tilføjes til BarListens liste af barer
                let coordinate = CLLocationCoordinate2D(latitude: 123, longitude: 123)
                let number = Int.random(in: 10 ..< 30)
                       let bar = Bar(flaskepris: number, navn: "TESTBAR", rygning: false, coordinate: coordinate)
                       bar.id = "1234512345f\(n)"
                       BarListe.shared.addBar(bar: bar)
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: 123, longitude: 123)
        let barFavo = Bar(flaskepris: 23, navn: "TESTBAR", rygning: false, coordinate: coordinate)
        barFavo.id = "1234512345"
        BarListe.shared.addBar(bar: barFavo)
        
        BarListe.shared.findFavo()
        
        BarListe.shared.refresh()
        
        var result = true
               
        if BarListe.shared.egneFavoritter.count != 0 || BarListe.shared.barer.count != 0 || BarListe.shared.brugerLoggetind.Favoritsteder[0] != user.Favoritsteder[0] || BarListe.shared.barerNærmeste.count != 0 || BarListe.shared.brugerLoggetind.navn != user.navn {
                   result = false
               }
               
               XCTAssertTrue(result)
        
    }
    
    
}

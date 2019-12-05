//
//  BarListeTest.swift
//  BilligeBamser1.0Tests
//
//  Created by Jacob Jørgensen on 29/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import XCTest
import MapKit
//@testable import BilligeBamser1_0
@testable import Billige_Bamser


class BarListeTest: XCTestCase {
     // Tester om findFavo gør det den skal
    func testFindFavo() {
        // opretter 1 bruger med en favorit bar
        let user = Bruger(navn: "Test", favoritsteder: ["1234512345"])
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

     // Tester om SorterEfterBilligstePris gør det den skal
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
     // Tester om tilføjBruger gør det den skal
    func testTilfojBruger() {
        let user = Bruger(navn: "Test", favoritsteder: ["1234512345"])
        
        BarListe.shared.tilføjBruger(bruger: user)
        
        var result = true
        if BarListe.shared.brugerLoggetind.navn != user.navn || BarListe.shared.brugerLoggetind.Favoritsteder[0] != user.Favoritsteder[0] {
            result = false
        }
        
        XCTAssertTrue(result)
    }
    
    // Tester om logOut gør det den skal
    func testLogOut() {
        let user = Bruger(navn: "Test", favoritsteder: ["1234512345"])
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
    
    // Tester om Refresh() gør det den skal
    func testRefresh() {
        let user = Bruger(navn: "Test", favoritsteder: ["1234512345"])
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
    // Tester hvor hurtigt SorterEfterPris kører
    func testPerformanceSorterEfterPris() {
        // This is an example of a performance test case.
        for n in 1...1000 {
            // opretter to testbarer, hvor en af dem er users favoritbar. Barerne tilføjes til BarListens liste af // barer
            let coordinate = CLLocationCoordinate2D(latitude: 123, longitude: 123)
            let number = Int.random(in: 10 ..< 30)
            let bar = Bar(flaskepris: number, navn: "TESTBAR", rygning: false, coordinate: coordinate)
            bar.id = "1234512345\(n)"
            BarListe.shared.addBar(bar: bar)
                          }
                          print("ANTAL BARER: \(BarListe.shared.barer.count)")
        measure {
            // Put the code you want to measure the time of here.
            BarListe.shared.sorterBilligsteEfterPris()
            print("SORTERET!")
        }
    }
    
    // Tester hvor hurtigt findFavo kører
    func testPerformanceFindFavoritter() {
           // This is an example of a performance test case.
           for n in 1...1000 {
               // opretter to testbarer, hvor en af dem er users favoritbar. Barerne tilføjes til BarListens liste af // barer
               let coordinate = CLLocationCoordinate2D(latitude: 123, longitude: 123)
               let number = Int.random(in: 10 ..< 30)
               let bar = Bar(flaskepris: number, navn: "TESTBAR", rygning: false, coordinate: coordinate)
               bar.id = "1234512345\(n)"
               BarListe.shared.addBar(bar: bar)
            
        }
        print("ANTAL BARER: \(BarListe.shared.barer.count)")
        
        //tilføjer en bruger med 15 favoritter
        let user = Bruger(navn: "Test", favoritsteder: ["12345123451", "12345123452", "12345123453", "12345123454", "12345123455", "12345123456", "12345123457", "12345123458", "12345123459", "123451234510", "123451234511", "123451234512", "123451234513", "123451234514", "123451234515"])
        BarListe.shared.brugerLoggetind = user
        
           measure {
               // Put the code you want to measure the time of here.
               BarListe.shared.findFavo()
            print("FAVO FUNDET ------------- \(BarListe.shared.egneFavoritter.count)")
           }
        
        BarListe.shared.barer.removeAll()
       }
    
    
    
    
}

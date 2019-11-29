//
//  FirebaseAPITest.swift
//  BilligeBamser1.0Tests
//
//  Created by Jacob Jørgensen on 29/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import XCTest
@testable import BilligeBamser1_0

class FirebaseAPITest: XCTestCase {
    func testLoginSucces() {
        
        let excp = XCTestExpectation(description: "Bruger logges ind")
        
        // navn: "jjj@jjj.dk", kode: "123456"
        FirebaseAPI.shared.logIn(navn: "jjj@jjj.dk", kode: "123456") { (result, error) in
            
            XCTAssertNotNil(result, "Fejl ved login")
            excp.fulfill()
            
            
        }
        
        wait(for: [excp], timeout: 10.0)
        
    }
    
    func testLoginFailed() {
        
        let excp = XCTestExpectation(description: "Bruger ikke logget ind")
        
        // navn: "jjj@jjj.dk", kode: "123456"
        FirebaseAPI.shared.logIn(navn: "fkfk", kode: "123456evd") { (result, error) in
            
            XCTAssertNotNil(error, "Login lykkedes")
            excp.fulfill()
            
            
        }
        
        wait(for: [excp], timeout: 10.0)
        
    }
    
}

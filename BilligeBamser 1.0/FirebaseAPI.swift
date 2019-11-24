//
//  FirebaseAPI.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 07/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//
import Firebase
import Foundation
import FirebaseAuth
import FirebaseFirestore
import MapKit

class FirebaseAPI {
    var db: Firestore!
    static let shared = FirebaseAPI()

    private init() {}
    
    // en metode der logger brugeren ind og har en completionHandler som kan bruges fra klassen hvor den bliver kaldt. 
    func logIn(navn: String, kode: String, completionHandler: @escaping (_ result: String?, _ error: Error?) -> Void){
        Auth.auth().signIn(withEmail: navn, password: kode) { (result, err) in
            if err != nil {
                if let fejl = err {
                    completionHandler(nil,fejl)
                }
            } else {
                if let id = result?.user.uid {
                    completionHandler(id, nil)
                }
            }
        }
        
    }
    
    func opretBrugerFireStore(navn: String, completionHandler: @escaping (_ result: String?, _ error: Error?) -> Void){
        
        self.db = Firestore.firestore()
        
        let favo: [String] = []
        if let user = Auth.auth().currentUser {
            
          
            self.db.collection("Bruger").document(user.uid).setData([
                "Navn": navn,
                            "Favoritsteder": favo
                        ]) { err in
                            if let err = err {
                                print("FEJL NÅR BRUGER SKULLE I DB")
                                completionHandler(nil, err)
                            } else {
                              print("SUCCES MED AT TILFØJE BRUGER I DB")
                                completionHandler(user.uid, nil)
                            }
                            
            }
            
        }
        
    }
    
    func opretBrugerAuth(mail: String, kode: String, completionHandler: @escaping (_ result: AuthDataResult?, _ error: Error?) -> Void){
        Auth.auth().createUser(withEmail: mail, password: kode) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                completionHandler(nil, err)
            } else {
                print("bruger blev oprettet i Auth")
                if let res = result {
                    completionHandler(res, nil)
                }
            }
        }
    }
        
    func logInWithCred(cred: AuthCredential, completionHandler: @escaping (_ result: String?, _ error: Error?) -> Void){
        Auth.auth().signIn(with: cred) { (result, err) in
            if err != nil {
                if let fejl = err {
                    completionHandler(nil,fejl)
                }
            } else {
                if let resultt = result {
                    if resultt.additionalUserInfo!.isNewUser {
                        self.opretBrugerFireStore(navn: (Auth.auth().currentUser?.displayName)!) { (res, err) in
                            if let error = err {
                                print(error.localizedDescription)
                                completionHandler(nil, error)
                            } else {
                                completionHandler(res, nil)
                            }
                        }
                    }
                }
                if let id = result?.user.uid {
                    completionHandler(id, nil)
                }
            }
        }
    }
    
    func tilføjBar(bar: Bar, completionHandler: @escaping (_ result: DocumentReference?, _ error: Error?) -> Void){
        db = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        ref = db.collection("Bar").addDocument(data:[
            "flaskepris": bar.flaskepris,
            "latitude": "\(bar.coordinate.latitude)",
            "longitude": "\(bar.coordinate.longitude)",
            "navn": bar.navn,
            "rygning": bar.rygning
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completionHandler(nil, err)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.db.collection("Bar").document(ref!.documentID).setData(["id" : ref!.documentID] , merge: true){ err in
                           if let err = err {
                               print("Error adding document: \(err)")
                               completionHandler(nil, err)
                           } else {
                            completionHandler(ref, nil)
                               print("Document added with ID: \(ref!.documentID)")
                           }
                       }
            }
        }
        
    }
    
    

    func hentBarer(completionHandler: @escaping (_ result: [Bar]?, _ error: Error?) -> Void){
       
        db = Firestore.firestore()
        var midlerID = ""
        var midlerPris = 1
        var midlerLati = 1.1
        var midlerLong = 1.1
        var midlerNavn = ""
        var midlerRyg = true
        
        
        db.collection("Bar").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(nil, err)
            } else {
                var barerne = [Bar]()
                for document in querySnapshot!.documents {
                    if let flaskepris = document.data()["flaskepris"] as? Int {
                        midlerPris = flaskepris
                        print("\(flaskepris)")
                        
                    }
                    if let latitude = document.data()["latitude"] as? String {
                        if let latitudeDouble = Double(latitude) {
                            midlerLati = latitudeDouble
                            print("\(latitudeDouble)")
                        }
                      
                    }
                    if let longitude = document.data()["longitude"] as? String {
                        if let longitudeDouble = Double(longitude) {
                            midlerLong = longitudeDouble
                            print("\(longitudeDouble)")
                        }
                        
                    }
                    if let Name = document.data()["navn"] as? String {
                        midlerNavn = Name
                      print(Name)
                    }
                    if let rygning = document.data()["rygning"] as? Bool {
                        midlerRyg = rygning
                      print("\(rygning)")
                    }
                    if let id = document.data()["id"] as? String {
                        midlerID = id
                        print(id)
                    }
                   var kor = CLLocationCoordinate2D()
                   kor.latitude = midlerLati
                   kor.longitude = midlerLong
                    let baren = Bar(flaskepris: midlerPris, navn: midlerNavn, rygning: midlerRyg, coordinate: kor)
                    
                    baren.id = midlerID
                    
                    barerne.insert(baren, at: barerne.count)
                    
                }
                completionHandler(barerne, nil)
            }
        }
    }
    
    func nuvaerendeBruger() -> User? {
        return Auth.auth().currentUser
    }
    
    func logOut(completionHandler: @escaping (_ result: String?, _ error: Error?) -> Void)-> Void {
        
        do {
            try Auth.auth().signOut()
            completionHandler("Succes", nil)
            } catch let err {
                print(err)
                completionHandler(nil, err)
        }
    }
    
    func hentBruger(completionHandler: @escaping (_ result: Bruger?, _ error: Error?) -> Void){
        let brugeren = Bruger(navn: "", favoritsteder: [""], nærmeste: [])
        if let mail = Auth.auth().currentUser?.email {
            BarListe.shared.mail = mail
        }
                print(Auth.auth().currentUser!.uid)
                       // først hentes den bruger der er logget ind
                       db = Firestore.firestore()
                       let docRef = db.collection("Bruger").document(Auth.auth().currentUser!.uid)
                       docRef.getDocument { (document, error) in
                           if let document = document {
                               if let navn =  document.data()!["Navn"] as? String {
                                brugeren.navn = navn
                                
                            }
                            if let favoritsteder = document.data()!["Favoritsteder"] as? [String] {
                                brugeren.Favoritsteder = favoritsteder
                                
                            }
                            completionHandler(brugeren, nil)
                            
                           } else {
                                completionHandler(nil, error)
                               print("Document does not exist")
                           }
                       }
            }
   
    func opdaterFavorit(completionHandler: @escaping (_ result: String?, _ error: Error?) -> Void){
         self.db = Firestore.firestore()
        self.db.collection("Bruger").document(Auth.auth().currentUser!.uid).setData([
            "Navn": BarListe.shared.brugerLoggetind.navn,
            "Favoritsteder": BarListe.shared.brugerLoggetind.Favoritsteder
                ], completion: { (err) in
                    if err != nil {
                        print(err?.localizedDescription)
                        completionHandler(nil, err!)
                    } else {
                        print("Favo er opdateret!")
                        completionHandler("Succes", nil)
                    }
        })
        
    }
        
        
    
    
}

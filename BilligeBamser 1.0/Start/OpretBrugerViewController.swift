//
//  OpretBrugerViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 27/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SVProgressHUD

class OpretBrugerViewController: UIViewController {
    var db: Firestore!
    let tabbarController = CustomTabbarController()
    
    var fornavnString = "TEST"
    var efternavnString = "TEST"
    var mailString = ""
    var kodeString = ""
    
    @IBOutlet weak var fornavnAfvist: UILabel!
    @IBOutlet weak var efternavnAfvist: UILabel!
    @IBOutlet weak var mailAfvist: UILabel!
    @IBOutlet weak var kodeAfvist: UILabel!
    
    
    @IBOutlet weak var fornavn: UITextField!
    @IBOutlet weak var efternavn: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var kode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onOpretBruger(_ sender: UIButton) {
        SVProgressHUD.show()
        if(self.validerFelterne()) {
            self.opretBrugerPaaFirebase()
        } else {
            SVProgressHUD.dismiss()
        }
        
    }
    func validerFelterne() -> Bool {
        // TODO: tjek at der er indtastet noget i navn/efternavn. Tjek også om det er en gyldig mail (validator) og tjek at kode er over en vis længde
        print("INDE I VALIDER!")
        var boolfnavn = false
        var boolenavn = false
        var boolmail = false
        var boolkode = false
        
        // Valider navn
        if let nnaavvnn = fornavn.text {
            if nnaavvnn.count > 0 {
                boolfnavn = true
                fornavnString = nnaavvnn
            }
        }
        // Valider efternavn
        if let efternnaavvnn = efternavn.text {
            if efternnaavvnn.count > 0 {
                boolenavn = true
                fornavnString = efternnaavvnn
            }
        }
        
        // Valider mail
        // TODO: brug validator bibliotek så vi sikrer det er en mail!
        if let mmaaiil = mail.text {
            if mmaaiil.count > 0 {
                boolmail = true
                mailString = mmaaiil
            }
            
        }
        
        //valider kode
        if let kkooddee = kode.text {
            if kkooddee.count > 5 {
                boolkode = true
                kodeString = kkooddee
            }
        }
        
        if !boolfnavn {
            fornavnAfvist.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.fornavnAfvist.isHidden = true
            }
        }
        if !boolenavn {
            efternavnAfvist.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.efternavnAfvist.isHidden = true
            }
        }
        if !boolmail {
            mailAfvist.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.mailAfvist.isHidden = true
            }
        }
        if !boolkode {
            kodeAfvist.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.kodeAfvist.isHidden = true
            }
        }
        
        if boolfnavn && boolenavn && boolmail && boolkode {
            return true
        } else {
            return false
        }
        
    
        
        
    }
    func opretBrugerPaaFirebase() -> Void {
        //TODO: opret i authentication og derefter i fireStore. tjek her at document ID ikke findes i forvejen, fordi så findes brugeren. og hvad hvis man bruger den sammen mail to gange?
        
        Auth.auth().createUser(withEmail: mailString, password: kodeString) { (ress, err) in
           if err != nil {
            print("OPRETTELSE FEJLET!")
            if err.unsafelyUnwrapped.localizedDescription == "The email address is already in use by another account." {
                SVProgressHUD.showError(withStatus: "Mailen findes allerede")
                print(err.unsafelyUnwrapped.localizedDescription)
                SVProgressHUD.dismiss(withDelay: 2)
            } else {
                SVProgressHUD.showError(withStatus: "Der opstod en fejl")
                print("EFTER IF'en!!")
                SVProgressHUD.dismiss(withDelay: 2)
            }
            if let user = Auth.auth().currentUser {
                print (user.providerID)
            }
           } else {
            print("BRUGEREN BLEV OPRETTET!")
            print(ress.debugDescription)
            print("BRUGEREN SOM ER LOGGET IND: ")
            
            if let user = Auth.auth().currentUser {
                print(user.uid)
            }
            
            self.db = Firestore.firestore()
            print("INDE I FIREstore tilføj")
            var favo: [String] = []
            var ref: DocumentReference? = nil
            if let user = Auth.auth().currentUser {
                
                self.db.collection("Bruger").document(user.uid).setData([
                    "Fornavn": self.fornavnString,
                    "Efternavn": self.efternavnString,
                                "Favoritsteder": favo
                            ]) { err in
                                if let err = err {
                                    print("FEJL NÅR BRUGER SKULLE I DB")
                                    SVProgressHUD.showError(withStatus: "Der opstod en fejl")
                                    SVProgressHUD.dismiss(withDelay: 2)
                                } else {
                                  print("SUCCES MED AT TILFØJE BRUGER I DB")
                                    SVProgressHUD.showSuccess(withStatus: "Bruger oprettet")
                                    // SEND BRUGEREN VIDERE TIL LOGGET IND og henter alle barer
                                    BarListe.shared.HentBarer()
                                    SVProgressHUD.dismiss(withDelay: 2) {
                                        self.present(self.tabbarController, animated: true, completion: nil)
                                    }
                                
                                    
                                    
                                }
                }
                
            }
            
            
            
            
           
           }
       }
    }
    
    
    
    func performSegueToReturnBack()  {
           
               self.dismiss(animated: true, completion: nil)
           
       }
    
}

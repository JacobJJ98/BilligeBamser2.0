//
//  OpretBajerViewController.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 09/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class OpretBajerViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    let lokationsManager = CLLocationManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var pris : Int? = nil
    var cor : CLLocationCoordinate2D?
    var midlerRyg : Bool? = nil
    var navn : String? = nil
    
    @IBOutlet weak var nuværendeLokationStatus: UISwitch!
    @IBOutlet weak var barNavn: UITextField!
    @IBOutlet weak var flaskePris: UITextField!
    @IBOutlet weak var rygningTilladt: UISwitch!
    @IBOutlet weak var adresse: UITextField!
    @IBOutlet var btn: UIButton!
    
    @IBAction func vedAendretLokation(_ sender: UISwitch) {
        if sender.isOn == false {
            adresse.isEnabled = true
            adresse.alpha = 0.7
            adresse.text = ""
            deaktiverOpretBtn()
            
        } else {
            adresse.alpha = 0.1
            adresse.isEnabled = false
            adresse.text = "Nuværende Lokation"
            if let barnavn = barNavn.text, let pris = flaskePris.text {
                if(!barnavn.isEmpty || !pris.isEmpty) {
                    aktiverOpretBtn()
                }
            }
         
        }
    }
    
    @IBAction func opretBar(_ sender: UIButton) {
        SVProgressHUD.show()
        // kaldes for at oversætte fra Textfield og hen til klassevariable og kalder derefter find lokation som så derefter vil kalde tilføj til Firebase
        self.tilføjNavnogPris()
    }
    
    //Metode til at disable login knap når felterne er tomme
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change køres")
        
        if(textField == self.barNavn) {
            print("should change køres inde i barnavn")
            if let _ = barNavn.text, let prisFeltet = flaskePris.text, let adresseFelt = adresse.text {
                let barNavnet = (barNavn.text! as NSString).replacingCharacters(in: range, with: string)

                if prisFeltet.isEmpty || barNavnet.isEmpty || adresseFelt.isEmpty {
                            deaktiverOpretBtn()
                            
                        }
                            else {
                            aktiverOpretBtn()
                            }
                
            }
            
        }
        
        if(textField == self.flaskePris) {
            print("should change køres inde i flaskepris")
            if let _ = flaskePris.text, let barnavnet = barNavn.text, let adresseFelt = adresse.text {
                let prisfelteter = (flaskePris.text! as NSString).replacingCharacters(in: range, with: string)
                
                if prisfelteter.isEmpty || barnavnet.isEmpty || adresseFelt.isEmpty {
                            deaktiverOpretBtn()
                        }
                            else {
                            aktiverOpretBtn()
                            }
            }
            
        }
        
        if(textField == self.adresse) {
            print("adresse")
            if let _ = adresse.text, let barnavnet = barNavn.text, let prisfelt = flaskePris.text {
                let adrfelteter = (adresse.text! as NSString).replacingCharacters(in: range, with: string)
                print("should change køres inde i flaskepris")
                
                if prisfelt.isEmpty || barnavnet.isEmpty || adrfelteter.isEmpty {
                    deaktiverOpretBtn()
                }
                    else {
                    aktiverOpretBtn()
                    }
                }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deaktiverOpretBtn()
        adresse.delegate = self
        flaskePris.delegate = self
        barNavn.delegate = self
        //Metode til at lukke keyboard ned ved tab uden for
        self.setupHideKeyboardOnTapThis()
    }
    
    func aktiverOpretBtn() {
        btn.isEnabled = true
        btn.alpha = 1.0
    }
    
    func deaktiverOpretBtn() {
        btn.isEnabled = false
        btn.alpha = 0.5
    }
    
    override func viewDidLayoutSubviews() {
        btn.layer.cornerRadius = btn.bounds.size.height/2
        
        btn.layer.cornerRadius = btn.bounds.size.height/2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Åbner keyboard ved email feltet automatisk
        barNavn.becomeFirstResponder()
        
    }
    
    //Metode til styring af return knappen
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     if textField == barNavn {
     flaskePris.becomeFirstResponder()
     }
     if textField == flaskePris {
     adresse.becomeFirstResponder()
     }
     if textField == adresse {
        adresse.resignFirstResponder()
     }
     return true
     }
     
    
    
    
    @IBAction func tilbage(_ sender: UIButton) {
        performSegueTilbage()
    }
    
    func performSegueTilbage()  {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    func tilføjNavnogPris() -> Void {
        if let navnmidler = barNavn.text {
            guard navnmidler.count > 0 else {
                SVProgressHUD.dismiss()
                return
            }
            //sætter navnet til klassevariablen!
            navn = navnmidler
        }
        if let prismidler = flaskePris.text {
            guard prismidler.count > 0 else {
                SVProgressHUD.dismiss()
                return
            }
            
            if let prisSomInt = Int(prismidler) {
                pris = prisSomInt
            }
        }
        
        self.findLokation()
    }
    
    
    func tilføjTilFirebase() -> Void {
        if let kor = self.cor {
            if let navn_ = self.navn {
                if let pris_ = self.pris {
                    print("BAREN KAN NU OPRETTES MED DISSE VÆRDIER: ")
                    print(kor.latitude)
                    print(kor.longitude)
                    print(navn_)
                    print(pris_)
                    print(self.rygningTilladt.isOn)
                    let bar = Bar(flaskepris: pris_, navn: navn_, rygning: self.rygningTilladt.isOn, coordinate: kor)
                    FirebaseAPI.shared.tilføjBar(bar: bar) { (res, err) in
                        if err != nil {
                            SVProgressHUD.showError(withStatus: "Der opstod en fejl")
                            print(err!.localizedDescription)
                        } else {
                            BarListe.shared.barer.removeAll()
                            FirebaseAPI.shared.hentBarer { (result, error) in
                                if error != nil {
                                    SVProgressHUD.dismiss()
                                    SVProgressHUD.showError(withStatus: "Kunne ikke hente barer")
                                    SVProgressHUD.dismiss(withDelay: 0.5)
                                    print(error!.localizedDescription)
                                } else {
                                    if let barene = result {
                                        for bar in barene {
                                            BarListe.shared.addBar(bar: bar)
                                        }
                                        SVProgressHUD.showSuccess(withStatus: "Baren er oprettet")
                                        SVProgressHUD.dismiss(withDelay: 0.5)
                                        self.performSegueTilbage()
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    func findLokation() -> Void {
        // find ud af om det skal være nuværende lokation eller adresse
        if nuværendeLokationStatus.isOn {
            
            
            //Resterende sørger for at sætte current location som der hvor Map starter!!
                lokationsManager.delegate = self
                if let lokationen = lokationsManager.location {
                    print("LOKATIONEN ER: ")
                    print(lokationen.coordinate.latitude)
                    print(lokationen.coordinate.longitude)
                    // sætter cor til være den nuværende lokation!
                    cor = lokationen.coordinate
                    self.tilføjTilFirebase()
                } else {
                    // TODO:  lav en allert eller noget NICE
                    print("DU SKAL ACCEPTERE BRUG AF LOKATION!!!")
                }
            
            
            
            
        } else {
            if let adrmidler = adresse.text {
                guard adrmidler.count > 0 else {
                    SVProgressHUD.dismiss()
                    return
                }
            }
            
            let geoCoder = CLGeocoder()
            if let adress = adresse.text {
                
                geoCoder.geocodeAddressString(adress) { (placemarks, error) in
                    guard let placemarks = placemarks, let location = placemarks.first?.location
                        else {
                            // handle no location found
                            // TODO: tænker der skal komme en alert omkring det skal indtastes anderledes eller brug nuværende loka!!
                            
                            print("Lokationen findes ikke!")
                            return
                    }
                    
                    self.cor = location.coordinate
                    self.tilføjTilFirebase()
                }
            }
        }
        
    }
    
}

//Gør så keyboard lukker ned når der tabbes uden for
extension UIViewController {
    func setupHideKeyboardOnTapThis() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}

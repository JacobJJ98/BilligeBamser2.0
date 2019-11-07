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

class OpretBajerViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    var pris : Int? = nil
    var cor : CLLocationCoordinate2D?
    var midlerRyg : Bool? = nil
    var navn : String? = nil
    @IBOutlet weak var navnAfvist: UILabel!
    @IBOutlet weak var prisAfvist: UILabel!
    @IBOutlet weak var adrAfvist: UILabel!
    
    @IBOutlet weak var nuværendeLokationStatus: UISwitch!
    @IBOutlet weak var barNavn: UITextField!
    @IBOutlet weak var flaskePris: UITextField!
    @IBOutlet weak var rygningTilladt: UISwitch!
    @IBOutlet weak var adresse: UITextField!
    @IBAction func vedAendretLokation(_ sender: UISwitch) {
        print("lokation ændret!!")
        if sender.isOn == false {
            adresse.backgroundColor = UIColor.white.withAlphaComponent(1)
            adresse.isEnabled = true
        } else {
            adresse.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            adresse.isEnabled = false
        }
    }
    
    @IBAction func opretBar(_ sender: UIButton) {
        SVProgressHUD.show()
        fjernAfvistLabels()
        print("opretBar er trykket")
        // kaldes for at oversætte fra Textfield og hen til klassevariable og kalder derefter find lokation som så derefter vil kalde tilføj til Firebase
        self.tilføjNavnogPris()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func  fjernAfvistLabels() -> Void {
        prisAfvist.isHidden = true
        navnAfvist.isHidden = true
        adrAfvist.isHidden = true
    }
    
    
    
    
    @IBAction func tilbage(_ sender: UIButton) {
        performSegueToReturnBack()
    }
    
    func performSegueToReturnBack()  {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    func tilføjNavnogPris() -> Void {
        if let navnmidler = barNavn.text {
            guard navnmidler.count > 0 else {
                navnAfvist.isHidden = false
                return
            }
            //sætter navnet til klassevariablen!
            navn = navnmidler
        }
        if let prismidler = flaskePris.text {
            guard prismidler.count > 0 else {
                prisAfvist.isHidden = false
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
                                               SVProgressHUD.showError(withStatus: "Mislykkedes")
                                           } else {
                                               BarListe.shared.barer.removeAll()
                                               FirebaseAPI.shared.hentBarer { (result, error) in
                                                   if error != nil {
                                                       SVProgressHUD.dismiss()
                                                       SVProgressHUD.showError(withStatus: "Kunne ikke hente barer!")
                                                       SVProgressHUD.dismiss(withDelay: 0.5)
                                                   } else {
                                                       if let barene = result {
                                                           for bar in barene {
                                                               BarListe.shared.addBar(bar: bar)
                                                           }
                                                           
                                                           SVProgressHUD.showSuccess(withStatus: "")
                                                           SVProgressHUD.dismiss()
                                                           self.performSegueToReturnBack()
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
        print("inde i findLokation")
        // find ud af om det skal være nuværende lokation eller adresse
        if nuværendeLokationStatus.isOn {
            
            
            //Resterende sørger for at sætte current location som der hvor Map starter!!
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                if let lokationen = locationManager.location {
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
            }
            
            
        } else {
            
            if let adrmidler = adresse.text {
                guard adrmidler.count > 0 else {
                    adrAfvist.isHidden = false
                    return
                }
            }
            // let address = "Toftebakken 15, 3790 Hasle"
            
            let geoCoder = CLGeocoder()
            if let adress = adresse.text {
                
                geoCoder.geocodeAddressString(adress) { (placemarks, error) in
                    guard let placemarks = placemarks, let location = placemarks.first?.location
                        else {
                            // handle no location found
                            // tænker der skal komme en alert omkring det skal indtastes anderledes eller brug nuværende loka!!
                            
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

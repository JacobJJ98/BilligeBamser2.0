//
//  StartsideViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 18/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import MapKit

class StartsideViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    @IBOutlet weak var btnFb: UIButton!
    @IBOutlet weak var fortsætBtn: UIButton!
    @IBOutlet weak var btnAllerede: UIButton!
    
    override func viewDidLayoutSubviews() {
        //Laver layout for knapper efter subviews er lavet
        // så de radius er relativt ift knappens størrelse. (så den er helt rund)
        btnFb.layer.cornerRadius = btnFb.bounds.size.height/2
        fortsætBtn.layer.cornerRadius = fortsætBtn.bounds.size.height/2
        btnAllerede.layer.cornerRadius  = btnAllerede.frame.size.height/2
        btnAllerede.layer.borderWidth = 2
        btnAllerede.layer.borderColor = UIColor.white.cgColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // denne metode gør at den logger ind via FaceBook
    @IBAction func loginMedFacebook(_ sender: UIButton) {
        let loginM = LoginManager()
        loginM.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            // tjekker for at man annullerer og at der er et resultat!
            if let res = result {
                print("ER DET ANNULERET: \(res.isCancelled)")
                if res.isCancelled {
                    return
                }
                SVProgressHUD.show()
            }
            // tjekker for evt fejl
            if let error = error {
                print("Failed til login: \(error.localizedDescription)")
                return
            }
            
            //tjekker for evt fejl ved AT
            guard let accesToken = AccessToken.current else {
                print("Failed to get acces token")
                return
            }
            let cred = FacebookAuthProvider.credential(withAccessToken: accesToken.tokenString)
            
            // ny login måde via API og her bliver de både logget ind og oprettet i databasen hvis det er første gang de logger ind!
            FirebaseAPI.shared.logInWithCred(cred: cred) { (res, err) in
                if err != nil {
                    print(err!.localizedDescription)
                    SVProgressHUD.showError(withStatus: "Noget gik galt ved login")
                    SVProgressHUD.dismiss(withDelay: 1.5)
                } else {
                    FirebaseAPI.shared.hentBruger { (res, err) in
                        if err != nil {
                            print("FEJL MED HENT AF BRUGER: \(err!.localizedDescription)")
                            SVProgressHUD.showError(withStatus: "Noget gik galt")
                            SVProgressHUD.dismiss(withDelay: 1.5)
                        } else {
                            // res objektet er brugeren der er hentet fra Firebase og den lægges ind i singleton klassen
                            if let brugeren = res {
                                BarListe.shared.tilføjBruger(bruger: brugeren)
                            }
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
                                        BarListe.shared.findFavo()
                                        SVProgressHUD.dismiss()
                                        let tabbarController = TabbarController()
                                        self.present(tabbarController, animated: true, completion: nil)
                                    }
                                    
                                }
                            }
                            
                        }
                    }
                }
            }
            
        }
        
    }
    
}



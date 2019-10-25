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
    @IBOutlet weak var loggetindLabel: UILabel!
    
    let tabbarController = CustomTabbarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
        locationManager.requestWhenInUseAuthorization()
    }
    // denne metode gør at den logger ind via FaceBook!!
    @IBAction func loginMedFacebook(_ sender: UIButton) {
        
        print("FACEBOOK!!!")
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
                   
                   // log nu med de givne credentials
                   Auth.auth().signIn(with: cred) { (user, error) in
                       if let error = error {
                           print("FEJL MED LOGIN PÅ INDE PÅ FIREBASE!!: \(error.localizedDescription)")
                           return
                       }
                    
                    BarListe.shared.HentBarer()
                    print("INDE FRA SSVC")
                    print(BarListe.shared.udskrivTest())
                    SVProgressHUD.dismiss()
                    self.present(self.tabbarController, animated: true, completion: nil)
                      
                          
                       
                       
                   }
               }
        
    }
    
   

}

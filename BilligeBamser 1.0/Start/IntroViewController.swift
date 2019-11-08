//
//  IntroViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 18/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import FirebaseAuth

class IntroViewController: UIViewController, UITabBarControllerDelegate {
    
    let tabbarController = CustomTabbarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser != nil {
            FirebaseAPI.shared.hentBruger { (bruger, error) in
            if error != nil {
            } else {
                
                if let brugeren = bruger {
                    BarListe.shared.tilføjBruger(bruger: brugeren)
                }
                BarListe.shared.barer.removeAll()
                  FirebaseAPI.shared.hentBarer { (result, error) in
                  if error != nil {
                      print("Fejl ved hent af barer!!")
                  } else {
                      if let barene = result {
                              print("Barene er hentet!")
                              print(barene.count)
                          for bar in barene {
                              BarListe.shared.addBar(bar: bar)
                          }
                              print("før favo findes")
                          BarListe.shared.findFavo()
                              print("efter favo")
                          
                              self.present(self.tabbarController, animated: true, completion: nil)
                              
                      }
                  }
            }
            }
            
              
               }
        }else {
                  print("IKKE LOGGET IND!!")
            sleep(2)
                   self.performSegue(withIdentifier: "forNewUser", sender: nil)
               }
    }
}

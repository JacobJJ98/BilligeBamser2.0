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
            FirebaseAPI.shared.hentBarer { (result, error) in
                if error != nil {
                    if let barene = result {
                    for bar in barene {
                        BarListe.shared.addBar(bar: bar)
                    }
                        BarListe.shared.findFavo()
                }
            }
            }
            sleep(2)
               self.present(tabbarController, animated: true, completion: nil)
              
               } else {
                  print("IKKE LOGGET IND!!")
            sleep(2)
                   self.performSegue(withIdentifier: "forNewUser", sender: nil)
               }
    }
}

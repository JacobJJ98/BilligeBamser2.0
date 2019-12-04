//
//  IntroViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 18/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import Hero

class IntroViewController: UIViewController, UITabBarControllerDelegate {
    //KOM NU GIT
    
    
    let tabbarController = CustomTabbarController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FirebaseAPI.shared.nuvaerendeBruger() != nil {
            FirebaseAPI.shared.hentBruger { (bruger, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let brugeren = bruger {
                    BarListe.shared.tilføjBruger(bruger: brugeren)
                }
                  FirebaseAPI.shared.hentBarer { (result, error) in
                  if error != nil {
                    print(error!.localizedDescription)
                  } else {
                      if let barene = result {
                          for bar in barene {
                              BarListe.shared.addBar(bar: bar)
                          }
                        BarListe.shared.findFavo()
                        
                        self.tabbarController.isHeroEnabled = true
                        self.tabbarController.heroModalAnimationType = HeroDefaultAnimationType.fade
                         
                        self.present(self.tabbarController, animated: true, completion: nil)
                      }
                  }
                    
                }
                
                }
                
            }
            
        } else {
                print("IKKE LOGGET IND!!")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                               let v1Nav = storyBoard.instantiateViewController(withIdentifier: "startsideVC") as! UIViewController
                               
                               v1Nav.isHeroEnabled = true
                      
                               
                               // let direction = HeroDefaultAnimationType.Direction.self
                               v1Nav.heroModalAnimationType = HeroDefaultAnimationType.fade
                               
                               self.present(v1Nav, animated: true, completion: nil)
            
                // self.performSegue(withIdentifier: "forNewUser", sender: nil)
            
        }
    }
}

//
//  IntroViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 18/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import FirebaseAuth
//HEJ MED DIG!! NU MASTER!!

class IntroViewController: UIViewController, UITabBarControllerDelegate {
    
    let tabbarController = CustomTabbarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
         if Auth.auth().currentUser != nil {
              // SVProgressHUD.showInfo(withStatus: "LOGGET IND!")
                     print("INDE I LOGGET IND: \(Auth.auth().currentUser?.uid)")
            BarListe.shared.HentBarer()
            sleep(2)
               self.present(tabbarController, animated: true, completion: nil)
              
               } else {
             //  SVProgressHUD.showInfo(withStatus: "IKKE LOGGET IND!")
                  print("IKKE LOGGET IND!!")
            sleep(2)
                   self.performSegue(withIdentifier: "forNewUser", sender: nil)
               }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

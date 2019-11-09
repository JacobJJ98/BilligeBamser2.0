//
//  MereViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class MereViewController: UIViewController {
    /*
            FirebaseAPI.shared.logOut { (res, err) in
                if err != nil {
                    print(err!.localizedDescription)
                } else {
                    BarListe.shared.logOut()
                    print("BRGUEREN ER NUL OG SEGUE SKAL BRUGES NU!!!")
                    self.dismiss(animated: true, completion: nil)
                    // self.performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
                }
            }
    
    
    */
    @IBOutlet weak var logUdKnap: UIButton!
    @IBAction func logUd(_ sender: UIButton) {
        
        FirebaseAPI.shared.logOut { (res, err) in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                BarListe.shared.logOut()
                print("BRGUEREN ER NUL OG SEGUE SKAL BRUGES NU!!!")
                self.dismiss(animated: true, completion: nil)
                // self.performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MERE VIEW!!")

         logUdKnap.layer.cornerRadius  = 20
    }
    override func viewDidAppear(_ animated: Bool) {
        print("APPEAR MERE!!")
        print(BarListe.shared.barer.count)
        print(BarListe.shared.egneFavoritter.count)
        for bar in BarListe.shared.egneFavoritter {
            print(bar.id)
        }
        print(BarListe.shared.brugerLoggetind.navn)
        print("FAVO STEDER FRA STRING ARRAY")
        for sted in BarListe.shared.brugerLoggetind.Favoritsteder {
            print(sted)
        }
    }
    


}

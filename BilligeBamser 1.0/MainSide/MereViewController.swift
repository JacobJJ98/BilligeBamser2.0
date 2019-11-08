//
//  MereViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import FirebaseAuth

class MereViewController: UIViewController {

    @IBAction func logUD(_ sender: UIButton) {
       // if Auth.auth().user != nil {
            try! Auth.auth().signOut()
    
         if Auth.auth().currentUser == nil {
            print("BRGUEREN ER NUL OG SEGUE SKAL BRUGES NU!!!")
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MERE VIEW!!")

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print("APPEAR MERE!!")
        print(BarListe.shared.barer.count)
        print(BarListe.shared.egneFavoritter.count)
        for bar in BarListe.shared.egneFavoritter {
            print(bar.id)
        }
        print(BarListe.shared.brugerLoggetind.navn)
    }
    


}

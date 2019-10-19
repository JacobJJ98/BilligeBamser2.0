//
//  OpretBajerViewController.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 09/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class OpretBajerViewController: UIViewController {
    

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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    
    @IBAction func tilbage(_ sender: UIButton) {
        performSegueToReturnBack()
    }
    
    func performSegueToReturnBack()  {
        
            self.dismiss(animated: true, completion: nil)
        
    }
   
}

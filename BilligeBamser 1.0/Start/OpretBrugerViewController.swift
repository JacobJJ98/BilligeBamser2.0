//
//  OpretBrugerViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 27/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class OpretBrugerViewController: UIViewController {

    
    @IBOutlet weak var fornavn: UITextField!
    @IBOutlet weak var efternavn: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var kode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onOpretBruger(_ sender: UIButton) {
        self.validerFelterne()
        self.opretBrugerPaaFirebase()
        self.gaaTilMenu()
    }
    func validerFelterne() -> Void {
        // TODO: tjek at der er indtastet noget i navn/efternavn. Tjek også om det er en gyldig mail (validator) og tjek at kode er over en vis længde
    }
    func opretBrugerPaaFirebase() -> Void {
        //TODO: opret i authentication og derefter i fireStore. tjek her at document ID ikke findes i forvejen, fordi så findes brugeren. og hvad hvis man bruger den sammen mail to gange?
        
      //  Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>) { (ress, err) in
     //       <#code#>
     //   }
    }
    func gaaTilMenu() -> Void {
        //TODO: send brugeren videre til tabbar og er nu logget ind. 
    }
    
    func performSegueToReturnBack()  {
           
               self.dismiss(animated: true, completion: nil)
           
       }
    
}

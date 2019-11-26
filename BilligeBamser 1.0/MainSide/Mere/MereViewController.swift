//
//  MereViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import Hero

class MereViewController: UIViewController {
    
    //NYE
    @IBOutlet weak var logUdKnapv2: UIButton!
    @IBOutlet weak var brugerNavnv2: UILabel!
    
    @IBOutlet weak var mailv2: UILabel!
    
    
    @IBAction func onLogUdv2(_ sender: UIButton) {
        FirebaseAPI.shared.logOut { (res, err) in
                   if err != nil {
                       print(err!.localizedDescription)
                   } else {
                       BarListe.shared.logOut()
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let v1Nav = storyBoard.instantiateViewController(withIdentifier: "startsideVC") as! UIViewController
                    
                    v1Nav.isHeroEnabled = true
                    
                    let direction = HeroDefaultAnimationType.Direction.down
                    v1Nav.heroModalAnimationType = HeroDefaultAnimationType.cover(direction: direction)
                    
                    self.present(v1Nav, animated: true, completion: nil)
                    
                       // self.dismiss(animated: true, completion: nil)
                   }
               }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MERE VIEW!!")

         logUdKnapv2.layer.cornerRadius  = 20
        brugerNavnv2.text = BarListe.shared.brugerLoggetind.navn
        mailv2.text = BarListe.shared.mail
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    


}

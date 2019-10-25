//
//  LogindViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth

class LogindViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var mailFelt: UITextField!
    
    @IBOutlet weak var kodeFelt: UITextField!
    @IBOutlet weak var afvistKode: UILabel!
    @IBOutlet weak var afvistMail: UILabel!
    
    let tabbarController = CustomTabbarController()
    
    @IBAction func FB(_ sender: UIButton) {
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailFelt.delegate = self
        kodeFelt.delegate = self
        
    }
    
    
    @IBAction func onLogin(_ sender: UIButton) {
        if let mail = mailFelt.text {
            guard mail.count > 0 else {
                afvistMail.isHidden = false
                return
            }
            if let kode = kodeFelt.text {
                guard kode.count > 0 else {
                    afvistKode.isHidden = false
                    return
                }
                SVProgressHUD.show()
                
                // Auth.auth().signIn(withEmail: email, password: kode)
                Auth.auth().signIn(withEmail: mail, password: kode) { (result, err) in
                    // tjek for fejl
                    if err != nil {
                        //hvis den kommer herind er der fejl!
                        SVProgressHUD.dismiss()
                        SVProgressHUD.showError(withStatus: "Mislykket!")
                        SVProgressHUD.dismiss(withDelay: 0.5)
                        // self.showSimpleAlert(besked: "Logind fejlet!")
                        
                    } else {
                        BarListe.shared.HentBarer()
                        SVProgressHUD.dismiss()
                        self.present(self.tabbarController, animated: true, completion: nil)
                        
                    }
                }
            }
            
            
            
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("RETURN TRYKKET!")
        if textField == mailFelt {
            print("DET ER MAILFELTET")
            kodeFelt.becomeFirstResponder()
        } else {
            print("DET ER KODEFELTET")
            kodeFelt.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func TilbageTrykket(_ sender: UIBarButtonItem) {
        performSegueToReturnBack()
    }
    func performSegueToReturnBack()  {
        
            self.dismiss(animated: true, completion: nil)
        
    }
}

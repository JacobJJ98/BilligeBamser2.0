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
   
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnFb: UIButton!
    
    @IBOutlet weak var mailFelt: UITextField!
    
    @IBOutlet weak var kodeFelt: UITextField!
    
    let tabbarController = CustomTabbarController()
    
    @IBAction func FB(_ sender: UIButton) {
        //TODO lav fb login
       
    }
    
  
    //Metode til at disable login knap når felterne er tomme
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change køres")
        
        if(textField == self.mailFelt) {
            print("mailFelt")
            let text = (mailFelt.text! as NSString).replacingCharacters(in: range, with: string)
            if text.isEmpty || kodeFelt.text!.isEmpty {
                print("email felt OG pass er emty")
             btnLogin.isEnabled = false
             btnLogin.alpha = 0.5
            } else {
                print("email felt IKKE emty")
             btnLogin.isEnabled = true
             btnLogin.alpha = 1.0
            }
        }
            
            if(textField == self.kodeFelt) {
            print("kodeFelt")
            let text = (kodeFelt.text! as NSString).replacingCharacters(in: range, with: string)
            if text.isEmpty || mailFelt.text!.isEmpty {
                print("email felt OG pass er emty")
             btnLogin.isEnabled = false
             btnLogin.alpha = 0.5
            } else {
                print("email felt IKKE emty")
             btnLogin.isEnabled = true
             btnLogin.alpha = 1.0
            }
            
        }
        return true
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDid Load")
        
        mailFelt.delegate = self
        kodeFelt.delegate = self
        
        
        btnLogin.isEnabled = false
        btnLogin.alpha = 0.5
        
        //Metode til at lukke keyboard ned ved tab uden for
        self.setupHideKeyboardOnTap()

        
    }
    
    override func viewDidLayoutSubviews() {
         //Laver layout for knapper efter subviews er lavet
         // så de radius er relativt ift knappens størrelse. (så den er helt rund)
         btnLogin.layer.cornerRadius = btnLogin.bounds.size.height/2
         btnFb.layer.cornerRadius = btnFb.bounds.size.height/2
     }
    
    override func viewWillAppear(_ animated: Bool) {
        //Åbner keyboard ved email feltet automatisk
        mailFelt.becomeFirstResponder()
       
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
    
  
    
    
    @IBAction func onLogin(_ sender: UIButton) {
                SVProgressHUD.show()
                
                // Auth.auth().signIn(withEmail: email, password: kode)
        Auth.auth().signIn(withEmail: mailFelt.text!, password: kodeFelt.text!) { (result, err) in
                    // tjek for fejl
                    if err != nil {
                        //hvis den kommer herind er der fejl!
                        SVProgressHUD.dismiss()
                        SVProgressHUD.showError(withStatus: "Mislykket!")
                        SVProgressHUD.dismiss(withDelay: 0.5)
                        self.kodeFelt.text = ""
                        self.btnLogin.isEnabled = false
                        self.btnLogin.alpha = 0.5
                        // self.showSimpleAlert(besked: "Logind fejlet!")
                        
                    } else {
                        BarListe.shared.HentBarer()
                        SVProgressHUD.dismiss()
                        self.present(self.tabbarController, animated: true, completion: nil)
                        
                    }
                }

    
    }
    //Hvis status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func TilbageTrykket(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
}

//Gør så keyboard lukker ned når der tabbes uden for
extension UIViewController {
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}



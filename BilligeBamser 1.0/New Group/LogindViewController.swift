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

class LogindViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnFb: UIButton!
    
    @IBOutlet weak var mailFelt: UITextField!
    
    @IBOutlet weak var kodeFelt: UITextField!
    
    var email: String?
    var kode: String?
    
    let tabbarController = CustomTabbarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mailFelt.delegate = self
        //kodeFelt.delegate = self
        
        deaktiverLoginKnap()
        
        //Metode til at lukke keyboard ned ved tab uden for
        self.setupHideKeyboardOnTap()
        
    }
    //Hvid status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func deaktiverLoginKnap() {
        btnLogin.isEnabled = false
        btnLogin.alpha = 0.5
    }
    func aktiverLoginKnap() {
        btnLogin.isEnabled = true
        btnLogin.alpha = 1.0
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
    
    
    //Metode til at disable login knap når felterne er tomme
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change køres")
        
        if(textField == self.mailFelt) {
            print("mailFelt")
            if let _ = mailFelt.text, let kode = kodeFelt.text {
                let mail = (mailFelt.text! as NSString).replacingCharacters(in: range, with: string)
                if mail.isEmpty || kode.isEmpty {
                    print("email felt OG pass er emty")
                    deaktiverLoginKnap()
                } else {
                    print("email felt IKKE emty")
                    aktiverLoginKnap()
                }
                
            }
            
        }
        
        if(textField == self.kodeFelt) {
            print("kodeFelt")
            if let mail = mailFelt.text, let _ = kodeFelt.text {
                let kode = (kodeFelt.text! as NSString).replacingCharacters(in: range, with: string)
                if kode.isEmpty || mail.isEmpty {
                    print("email felt OG pass er emty")
                    deaktiverLoginKnap()
                } else {
                    print("email felt IKKE emty")
                    aktiverLoginKnap()
                }
            }
            
        }
        return true
    }
    
    //Metode til styring af return knappen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mailFelt {
            kodeFelt.becomeFirstResponder()
        }
        if textField == kodeFelt {
            kodeFelt.resignFirstResponder()
        }
        return true
    }
    
   
    
    func erMailKorrekt(mail: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: mail)
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        if let mail = mailFelt.text, let kode = kodeFelt.text {
            if(!erMailKorrekt(mail: mail)) {
                
                let alert = UIAlertController(title: title, message: "Indtast en gyldig email-adresse.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                kodeFelt.text = ""
            }
            else if (kode.count<6) {
                kodeFelt.text = ""
                deaktiverLoginKnap()
                
                let alert2 = UIAlertController(title: title, message: "Din kode er mindst 6 tegn.", preferredStyle: .alert)
                alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert2, animated: true)
                
            }
            else {
                SVProgressHUD.show()
                // fireBaseLogin(email: mail,pass: kode)
                FirebaseAPI.shared.logIn(navn: mail, kode: kode) { (result, error) in
                    if error != nil {
                        //hvis den kommer herind er der fejl!
                        SVProgressHUD.dismiss()
                        SVProgressHUD.showError(withStatus: "Mislykket!")
                        SVProgressHUD.dismiss(withDelay: 0.5)
                        self.kodeFelt.text = ""
                        self.deaktiverLoginKnap()
                    } else {
                        FirebaseAPI.shared.hentBruger { (bruger, error) in
                            if error != nil {
                                SVProgressHUD.dismiss()
                                SVProgressHUD.showError(withStatus: "Kunne ikke hente brugeren!")
                                SVProgressHUD.dismiss(withDelay: 0.5)
                                self.kodeFelt.text = ""
                                self.deaktiverLoginKnap()
                            } else {
                                
                                if let brugeren = bruger {
                                    BarListe.shared.tilføjBruger(bruger: brugeren)
                                }
                                BarListe.shared.barer.removeAll()
                                  FirebaseAPI.shared.hentBarer { (result, error) in
                                                           if error != nil {
                                                               SVProgressHUD.dismiss()
                                                               SVProgressHUD.showError(withStatus: "Kunne ikke hente barer!")
                                                               SVProgressHUD.dismiss(withDelay: 0.5)
                                                               self.kodeFelt.text = ""
                                                               self.deaktiverLoginKnap()
                                                           } else {
                                                               if let barene = result {
                                                                   for bar in barene {
                                                                       BarListe.shared.addBar(bar: bar)
                                                                   }
                                                                
                                                                BarListe.shared.findFavo()
                                                                   
                                                                   SVProgressHUD.dismiss()
                                                                   SVProgressHUD.showSuccess(withStatus: "")
                                                                 self.present(self.tabbarController, animated: true, completion: nil)
                                                               }
                                                               
                                                               }
                                                               
                                                           }
                                
                                
                                
                            }
                        }
                        
                        
                        
                        
                      
                            
                        }
                        
                        
                        
                    }
                }
                
            }
            
            
            
        
        
    }
    
    @IBAction func FB(_ sender: UIButton) {
        //TODO lav fb login
        
    }
    
    @IBAction func TilbageTrykket(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}





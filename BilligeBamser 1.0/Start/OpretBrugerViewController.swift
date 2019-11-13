//
//  OpretBrugerViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 27/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//
import UIKit
import SVProgressHUD

//Gør så keyboard lukker ned når der tabbes uden for

class OpretBrugerViewController: UIViewController, UITextFieldDelegate {
    let tabbarController = CustomTabbarController()
    
    var navn: String?
    var email: String?
    var kodeS: String?
    
    @IBOutlet weak var navnFelt: UITextField!
    @IBOutlet weak var mailFelt: UITextField!
    @IBOutlet weak var kodeFelt: UITextField!
    @IBOutlet weak var btnOpret: UIButton!
    @IBOutlet weak var btnFb: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deaktiverLoginKnap()
        //Metode til at lukke keyboard ned ved tab uden for
        self.setupHideKeyboardOnTap()
        
    }
    //Hvid status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func deaktiverLoginKnap() {
        btnOpret.isEnabled = false
        btnOpret.alpha = 0.5
    }
    func aktiverLoginKnap() {
        btnOpret.isEnabled = true
        btnOpret.alpha = 1.0
    }
    
    override func viewDidLayoutSubviews() {
        //Laver layout for knapper efter subviews er lavet
        // så de radius er relativt ift knappens størrelse. (så den er helt rund)
        btnOpret.layer.cornerRadius = btnOpret.bounds.size.height/2
        btnOpret.layer.cornerRadius = btnOpret.bounds.size.height/2
        
        btnFb.layer.cornerRadius = btnOpret.bounds.size.height/2
        btnFb.layer.cornerRadius = btnOpret.bounds.size.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Åbner keyboard ved email feltet automatisk
        navnFelt.becomeFirstResponder()
        
    }
    
    //Metode til at disable login knap når felterne er tomme
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change køres")
        
        if(textField == self.navnFelt) {
            print("fornavn")
            if let _ = navnFelt.text, let kodeFelt = mailFelt.text, let email = mailFelt.text {
                let fornavnet = (navnFelt.text! as NSString).replacingCharacters(in: range, with: string)
                
                if email.isEmpty || kodeFelt.isEmpty || fornavnet.isEmpty {
                    print("email felt OG pass er emty")
                    deaktiverLoginKnap()
                } else {
                    print("email felt IKKE emty")
                    aktiverLoginKnap()
                }
                
            }
            
        }
        
        if(textField == self.kodeFelt) {
            print("kode")
            if let _ = kodeFelt.text, let navn = navnFelt.text, let email = mailFelt.text {
                let koden = (kodeFelt.text! as NSString).replacingCharacters(in: range, with: string)
                if email.isEmpty || koden.isEmpty || navn.isEmpty {
                    print("email felt OG pass er emty")
                    deaktiverLoginKnap()
                } else {
                    print("email felt IKKE emty")
                    aktiverLoginKnap()
                }
                
            }
            
        }
        
        if(textField == self.mailFelt) {
            print("email")
            if let _ = mailFelt.text, let kode = kodeFelt.text, let navn = navnFelt.text {
                let emailen = (mailFelt.text! as NSString).replacingCharacters(in: range, with: string)
                if emailen.isEmpty || kode.isEmpty || navn.isEmpty {
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
        if textField == navnFelt {
            mailFelt.becomeFirstResponder()
        }
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
    
    
    @IBAction func onOpretBruger(_ sender: UIButton) {
        if let mail = mailFelt.text, let kode = kodeFelt.text, let navn = navnFelt.text {
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
                //OPRET BRUGER PÅ FIREBASE OSV (Auth)
                FirebaseAPI.shared.opretBrugerAuth(mail: mail, kode: kode) { (dataRes, error) in
                    if let err = error {
                        if err.localizedDescription == "The email address is already in use by another account." {
                        SVProgressHUD.showError(withStatus: "Mailen findes allerede")
                        print(err.localizedDescription)
                        SVProgressHUD.dismiss(withDelay: 2)
                        } else {
                        SVProgressHUD.showError(withStatus: "Der opstod en fejl")
                        SVProgressHUD.dismiss(withDelay: 2)
                        }
                    } else {
                        // oprettelsen lykkedes og vi kommer herind!
                        print(dataRes!.debugDescription)
                        FirebaseAPI.shared.opretBrugerFireStore(navn: navn) { (res, error) in
                            if error != nil {
                                print("FEJL NÅR BRUGER SKULLE I DB: \(error.debugDescription)")
                                SVProgressHUD.showError(withStatus: "Der opstod en fejl")
                                SVProgressHUD.dismiss(withDelay: 2)
                            } else {
                                print("SUCCES MED AT TILFØJE \(res!) I DB")
                                BarListe.shared.mail = mail
                                self.lavBrugerIBarListe(navn: navn)
                                FirebaseAPI.shared.hentBarer { (barer, err) in
                                    if err != nil {
                                        SVProgressHUD.showError(withStatus: "Kunne ikke hente barer!")
                                        SVProgressHUD.dismiss(withDelay: 0.5)
                                    } else {
                                        if let barene = barer {
                                            for bar in barene {
                                                BarListe.shared.addBar(bar: bar)
                                            }
                                            SVProgressHUD.dismiss()
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
    
    func lavBrugerIBarListe(navn: String) -> Void {
        let nyBruger = Bruger(navn: navn, favoritsteder: [""])
        BarListe.shared.brugerLoggetind = nyBruger
    }
    @IBAction func TilbageTrykket(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var omOsView: UIView!
    var tapGesture = UITapGestureRecognizer()
    
    @IBOutlet weak var hjemmesideView: UIView!
    @IBOutlet weak var instaView: UIView!
    @IBOutlet weak var fbView: UIView!
    @IBOutlet weak var privatLivsPView: UIView!
    
    @IBAction func onLogUdv2(_ sender: UIButton) {
        FirebaseAPI.shared.logOut { (res, err) in
                   if err != nil {
                       print(err!.localizedDescription)
                   } else {
                       BarListe.shared.logOut()
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let v1Nav = storyBoard.instantiateViewController(withIdentifier: "startsideVC") as! UIViewController
                    
                    v1Nav.isHeroEnabled = true
           
                    
                    // let direction = HeroDefaultAnimationType.Direction.self
                    v1Nav.heroModalAnimationType = HeroDefaultAnimationType.fade
                    
                    self.present(v1Nav, animated: true, completion: nil)
                    
                       // self.dismiss(animated: true, completion: nil)
                   }
               }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MERE VIEW!!")
        
        // logUdKnapv2.layer.cornerRadius  = 20
        brugerNavnv2.text = BarListe.shared.brugerLoggetind.navn
        mailv2.text = BarListe.shared.mail
        
        // TAP Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(omOsTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        omOsView.addGestureRecognizer(tapGesture)
        omOsView.isUserInteractionEnabled = true
        
        omOsView.layer.borderColor = UIColor.white.cgColor
        omOsView.layer.borderWidth = 1.5
        
        hjemmesideView.layer.borderColor = UIColor.white.cgColor
        hjemmesideView.layer.borderWidth = 1.5
        
        instaView.layer.borderColor = UIColor.white.cgColor
        instaView.layer.borderWidth = 1.5
        
        fbView.layer.borderColor = UIColor.white.cgColor
        fbView.layer.borderWidth = 1.5
        
        privatLivsPView.layer.borderColor = UIColor.white.cgColor
        privatLivsPView.layer.borderWidth = 1.5
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func omOsTapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: "https://docs.google.com/document/d/1HWUYO8Rr-lddAzbX4hrHQrd9H3QeiF0_Bt20AFt626s/edit?usp=sharing") else {  return }
        UIApplication.shared.open(url)
    }
    
    
    override func viewDidLayoutSubviews() {
         let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
         backgroundImage.image = UIImage(named: "bg6")
         backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
         self.view.insertSubview(backgroundImage, at: 0)
        
        logUdKnapv2.layer.cornerRadius = logUdKnapv2.bounds.size.height/2
        logUdKnapv2.layer.cornerRadius = logUdKnapv2.bounds.size.height/2
     }

}

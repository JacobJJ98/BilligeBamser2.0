//
//  ViewControllerBajer.swift
//  BilligeBamser1.0
//
//  Created by Nicolai Dam on 23/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class ViewControllerBajer: UIViewController {
    

    @IBOutlet var prisen: UILabel!
    @IBOutlet var navnTitel: UILabel!
    
    var pris:String = ""
    var afstand:String = ""
    var barnavn:String = ""
    var erFavo:Bool = false
    var id:String = ""
    
    var firstTime: Bool = true
    
    @IBOutlet var erFavoImage: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        print("VIEW DID APPEAR KØRES")
        print(erFavo)
        
        if(!firstTime) {
            print("VIEW DID APPEAR KØRESinden i")
            
            var b = false
            
            for favo in BarListe.shared.brugerLoggetind.Favoritsteder {
                
                if(favo==self.id) {
                    b = true
                    return
                }
              
            }
            if(b==false) {
                erFavo = false
                if #available(iOS 13.0, *) {
                    let im = UIImage(systemName:"heart")?.withTintColor(.white,
                    renderingMode: .alwaysOriginal)
                    erFavoImage.image = im
                } else {
                    // Fallback on earlier versions
                }
            }
            
        }
        
        firstTime = false
    }
    
    override func viewDidLayoutSubviews() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg6")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override func viewDidLoad() {
        navnTitel.text = barnavn
        if erFavo {
            
            print("er favo")
            if #available(iOS 13.0, *) {
                let im = UIImage(systemName:"heart.fill")?.withTintColor(.white,
                renderingMode: .alwaysOriginal)
                erFavoImage.image = im
            } else {
                // Fallback on earlier versions
            }
        }
        else {
            print("er ikke favo")
            if #available(iOS 13.0, *) {
                let im = UIImage(systemName:"heart")?.withTintColor(.white,
                renderingMode: .alwaysOriginal)
                erFavoImage.image = im
            } else {
                // Fallback on earlier versions
            }
        }
        super.viewDidLoad()
        
      
        prisen.text = "\(pris)kr"
        self.title = barnavn

        // Do any additional setup after loading the view.
    }
    func updateServer() {
          FirebaseAPI.shared.opdaterFavorit { (result, error) in
          if error != nil {
            print(error!.localizedDescription)
              }
          }
          
      }
    
    @IBAction func favorit(_ sender: UIButton) {
        if(erFavo) {
        
            if #available(iOS 13.0, *) {
                erFavo = false
                
                BarListe.shared.brugerLoggetind.sletFavorit(ID: self.id)
                BarListe.shared.sletFavorit(ID: self.id)
                updateServer()
                let im = UIImage(systemName:"heart")?.withTintColor(.white,
                renderingMode: .alwaysOriginal)
                erFavoImage.image = im
            } else {
                // Fallback on earlier versions
            }
        }
        else {
            if #available(iOS 13.0, *) {
                erFavo = true
                BarListe.shared.brugerLoggetind.tilføjFavorit(ID: self.id)
                BarListe.shared.tilføjFavorit(ID: self.id)
                updateServer()
                let im = UIImage(systemName:"heart.fill")?.withTintColor(.white,
                renderingMode: .alwaysOriginal)
                erFavoImage.image = im
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
    
  


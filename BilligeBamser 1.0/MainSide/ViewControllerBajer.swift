//
//  ViewControllerBajer.swift
//  BilligeBamser1.0
//
//  Created by Nicolai Dam on 23/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//
import MapKit
import UIKit

class ViewControllerBajer: UIViewController {
    

    @IBOutlet var prisen: UILabel!
    @IBOutlet var navnTitel: UILabel!
    @IBOutlet var findVej: UIButton!
    
    var pris:String = ""
    var afstand:String = ""
    var barnavn:String = ""
    var erFavo:Bool = false
    var id:String = ""
    var måRyge:Bool = false
    var kordinat: CLLocationCoordinate2D?
    
    
    var firstTime: Bool = true
    
    @IBOutlet var erFavoImage: UIImageView!
    @IBOutlet var myRygeIm: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        print("må ryge er \(måRyge)")
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
        findVej.layer.cornerRadius = findVej.bounds.size.height/2
        findVej.layer.cornerRadius = findVej.bounds.size.height/2
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
        
        if måRyge {
            
            if #available(iOS 13.0, *) {
                let im = UIImage(named: "smoke")?.withTintColor(.white, renderingMode: .alwaysOriginal)
                myRygeIm.image = im
            } else {
                // Fallback on earlier versions
            }
        
        }
        else {
          
            if #available(iOS 13.0, *) {
                let im = UIImage(named: "nosmoke")?.withTintColor(.white, renderingMode: .alwaysOriginal)
                myRygeIm.image = im
            } else {
                // Fallback on earlier versions
            }
                
        
        }
        
        
     
        super.viewDidLoad()
        
      
        prisen.text = "\(pris)kr"
        self.title = barnavn
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white

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
    @IBAction func findVej(_ sender: UIButton) {
        let coordinate = CLLocationCoordinate2DMake(kordinat!.latitude,kordinat!.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = barnavn
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
    }
}
    
  


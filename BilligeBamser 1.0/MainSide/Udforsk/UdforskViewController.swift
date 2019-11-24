//
//  UdforskViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 16/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import MapKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SVProgressHUD

class CollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var pris: UILabel!
    @IBOutlet weak var text: UILabel!
    
    @IBOutlet var favoBillede: UIImageView!
    @IBOutlet var afstand: UILabel!
    
    
}

class CollectionViewCell2 : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet var pris: UILabel!
    @IBOutlet weak var favoritKnap: UIButton!
    
}

class CollectionViewCell3 : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var pris: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var favoritKnap: UIButton!
    
}

class UdforskViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lokationen = locationManager.location {
            BarListe.shared.barerNærmeste = BarListe.shared.barer
            BarListe.shared.sorterNærmesteEfterAfsted(loka: lokationen)
        }
        
        collectionView1.layer.shadowColor = UIColor.black.cgColor
        collectionView1.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        collectionView1.layer.shadowRadius = 4.0
        collectionView1.layer.shadowOpacity = 0.5
        collectionView1.layer.masksToBounds = false
        collectionView1.layer.backgroundColor = UIColor.clear.cgColor
        
        collectionView2.layer.shadowColor = UIColor.black.cgColor
        collectionView2.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        collectionView2.layer.shadowRadius = 4.0
        collectionView2.layer.shadowOpacity = 0.5
        collectionView2.layer.masksToBounds = false
        collectionView2.layer.backgroundColor = UIColor.clear.cgColor
        
        collectionView3.layer.shadowColor = UIColor.black.cgColor
        collectionView3.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        collectionView3.layer.shadowRadius = 4.0
        collectionView3.layer.shadowOpacity = 0.5
        collectionView3.layer.masksToBounds = false
        collectionView3.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // SVProgressHUD.show()
        // BarListe.shared.barer.removeAll()
        // self.HentBarer()
        
    }
    
    override func viewDidLayoutSubviews() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg6")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == collectionView1) {
            let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "collectionViewCellID", for: indexPath) as! CollectionViewCell
            
            cell.layer.cornerRadius = 5;
            
            let billed = ["beer1", "beer2","beer3", "beer4","beer5", "beer6","beer7", "beer8","beer9", "beer10",]
            
            cell.text.text = BarListe.shared.barerNærmeste[indexPath.row].navn
            
            print("index path er: \(indexPath.row)")
            
            let barKoord = CLLocation(latitude: BarListe.shared.barerNærmeste[indexPath.row].coordinate.latitude, longitude: BarListe.shared.barerNærmeste[indexPath.row].coordinate.longitude)
            
            let distIMeter: Double = (locationManager.location?.distance(from: barKoord))!/1000.rounded()
            
            let distRounded = String(format: "%.1f", distIMeter)
            
            cell.afstand.text = "\(distRounded)km"
            
            BarListe.shared.barerNærmeste[indexPath.row].afstand = distRounded
            
            let id = ["1", "2","3", "4","5", "6","7", "8","9", "10",]
            
            
            
            
            for favo in BarListe.shared.brugerLoggetind.Favoritsteder {
                print("første favorit er: \(BarListe.shared.brugerLoggetind.Favoritsteder)")
                if favo == BarListe.shared.barerNærmeste[indexPath.row].id {
                    print("ER FAVORIT STED")
                    BarListe.shared.barerNærmeste[indexPath.row].erFavo = true
                    
                    if #available(iOS 13.0, *) {
                        let testimage : UIImage = UIImage(systemName: "heart.fill")!
                        cell.favoBillede.image = testimage
                    } else {
                        
                        // Fallback on earlier versions
                    }
                    
                }
                else {
                    BarListe.shared.barerNærmeste[indexPath.row].erFavo = false
                    print("ER IKKE FAVORIT STED")
                    
                    
                    if #available(iOS 13.0, *) {
                        let testimage : UIImage = UIImage(systemName: "heart")!
                        cell.favoBillede.image = testimage
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
                
            }
            
            
            
            let testimage : UIImage = UIImage(named: billed[indexPath.row])!
            
            cell.imageView.image = testimage
            
            
            cell.pris.text = String(BarListe.shared.barerNærmeste[indexPath.row].flaskepris)
            return cell
        }
        
        
        
        
        if(collectionView == collectionView2) {
            let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: "collectionViewCellID2", for: indexPath) as! CollectionViewCell2
            
            cell2.layer.cornerRadius = 5;
            
            
            cell2.text.text = BarListe.shared.barerNærmeste[indexPath.row].navn
            
            let billed = ["beer1", "beer2","beer3", "beer4","beer5", "beer6","beer7", "beer8","beer9", "beer10",]
            
            let id = ["1", "2","3", "4","5", "6","7", "8","9", "10",]
            
            let testimage : UIImage = UIImage(named: billed[indexPath.row])!
            
            cell2.imageView.image = testimage
            return cell2
            
        }
            
            
        else {
            let cell3 = collectionView3.dequeueReusableCell(withReuseIdentifier: "collectionViewCellID3", for: indexPath) as! CollectionViewCell3
            
            cell3.layer.cornerRadius = 5;
            
            let testdata = ["333", "Old Irish - Lyngby ", "Den glade gris", "Hegnet","Artillericafeen","DTU fredagsbar","Ruder Konge","IRISH tivoli","DIAMANTEN","billige bamse cafe :)"]
            cell3.text.text = testdata[indexPath.row]
            
            let billed = ["beer1", "beer2","beer3", "beer4","beer5", "beer6","beer7", "beer8","beer9", "beer10",]
            
            let id = ["1", "2","3", "4","5", "6","7", "8","9", "10",]
            
            let testimage : UIImage = UIImage(named: billed[indexPath.row])!
            
            cell3.imageView.image = testimage
            return cell3
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if(collectionView == collectionView1) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ViewControllerBajer") as! ViewControllerBajer
            if let afs = BarListe.shared.barerNærmeste[indexPath.row].afstand {
                vc.afstand = afs
            }
            
            if let erFavo = BarListe.shared.barerNærmeste[indexPath.row].erFavo {
                vc.erFavo = erFavo
            }
            
            vc.pris = String(BarListe.shared.barerNærmeste[indexPath.row].flaskepris)
            vc.barnavn = BarListe.shared.barerNærmeste[indexPath.row].navn
            self.show(vc, sender: nil)
            print("Trykket på Nærheden nr: \(indexPath.row)")
        }
        if(collectionView == collectionView2) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ViewControllerBajer") as! ViewControllerBajer
            let testdata = ["333", "Old Irish - Lyngby ", "Den glade gris", "Hegnet","Artillericafeen","DTU fredagsbar","Ruder Konge","IRISH tivoli","DIAMANTEN","billige bamse cafe :)"]
            vc.afstand = "\(indexPath)"
            vc.pris = "prisen er hard :) :) "
            vc.barnavn = "\(testdata[indexPath.row])"
            self.show(vc, sender: nil)
            print("Trykket på Billigste nr: \(indexPath.row)")
        }
        if(collectionView == collectionView3) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ViewControllerBajer") as! ViewControllerBajer
            let testdata = ["333", "Old Irish - Lyngby ", "Den glade gris", "Hegnet","Artillericafeen","DTU fredagsbar","Ruder Konge","IRISH tivoli","DIAMANTEN","billige bamse cafe :)"]
            vc.afstand = "\(indexPath)"
            vc.pris = "prisen er hard :) :) "
            vc.barnavn = "\(testdata[indexPath.row])"
            self.show(vc, sender: nil)
            print("Trykket på Vi anbefaler nr: \(indexPath.row)")
        }
        
    }
    
    
    
    
    
    
    
    
}


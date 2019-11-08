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
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var favoritKnap: UIButton!
    
}

class CollectionViewCell2 : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var favoritKnap: UIButton!
    
}

class CollectionViewCell3 : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var favoritKnap: UIButton!
    
}

class UdforskViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
            let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "collectionViewCellID", for: indexPath) as! CollectionViewCell
            
            cell.layer.cornerRadius = 5;
            
            let testdata = ["Palæen", "Old Irish - Lyngby ", "Den glade gris", "Hegnet","Artillericafeen","DTU fredagsbar","Ruder Konge","IRISH tivoli","DIAMANTEN","billige bamse cafe :)"]
            cell.text.text = testdata[indexPath.row]

            let billed = ["beer1", "beer2","beer3", "beer4","beer5", "beer6","beer7", "beer8","beer9", "beer10",]
            
            let id = ["1", "2","3", "4","5", "6","7", "8","9", "10",]
            
            let testimage : UIImage = UIImage(named: billed[indexPath.row])!
            
            cell.imageView.image = testimage
           
        
        
        if(collectionView == collectionView2) {
            let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: "collectionViewCellID2", for: indexPath) as! CollectionViewCell2
            
            cell2.layer.cornerRadius = 5;
            
            let testdata = ["222", "Old Irish - Lyngby ", "Den glade gris", "Hegnet","Artillericafeen","DTU fredagsbar","Ruder Konge","IRISH tivoli","DIAMANTEN","billige bamse cafe :)"]
            cell2.text.text = testdata[indexPath.row]

            let billed = ["beer1", "beer2","beer3", "beer4","beer5", "beer6","beer7", "beer8","beer9", "beer10",]
            
            let id = ["1", "2","3", "4","5", "6","7", "8","9", "10",]
            
            let testimage : UIImage = UIImage(named: billed[indexPath.row])!
            
            cell2.imageView.image = testimage
            return cell2
             
        }
        
        
        if(collectionView == collectionView3) {
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
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == collectionView1) {
            print("Trykket på Nærheden nr: \(indexPath.row)")
        }
        if(collectionView == collectionView2) {
            print("Trykket på Billigste nr: \(indexPath.row)")
        }
        if(collectionView == collectionView3) {
            print("Trykket på Vi anbefaler nr: \(indexPath.row)")
        }
        
    }
    
    
    
    
    
    
    
    
}


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

class UdforskViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        collectionView.layer.shadowRadius = 4.0
        collectionView.layer.shadowOpacity = 0.5
        collectionView.layer.masksToBounds = false
        collectionView.layer.backgroundColor = UIColor.clear.cgColor
        
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
    
    
    let reuseIdentifier = "collectionViewCellID"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.layer.cornerRadius = 5;
        
        let testdata = ["Palæen", "Old Irish - Lyngby ", "Den glade gris", "Hegnet","Artillericafeen","DTU fredagsbar","Ruder Konge","IRISH tivoli","DIAMANTEN","billige bamse cafe :)"]
        cell.text.text = testdata[indexPath.row]

        let billed = ["beer1", "beer2","beer3", "beer4","beer5", "beer6","beer7", "beer8","beer9", "beer10",]
        
        let id = ["1", "2","3", "4","5", "6","7", "8","9", "10",]
        
        let testimage : UIImage = UIImage(named: billed[indexPath.row])!
        
        cell.imageView.image = testimage
        cell.favoritKnap.tag = indexPath.row
        cell.favoritKnap.addTarget(self, action: #selector(onClickFavoritNarmest), for: .touchUpInside)
        
        
        return cell
    }
    
    
    @IBAction func onClickFavoritNarmest(sender: UIButton) {
        //        print("dd \(sender.identi)")
        print("Jeg er nr. 1 collection view og nr: \(sender.tag)")
        // use button tag to find out which button is clicked.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select \(indexPath.row)")
    }
    
    
    
    
    
    
    
    
}


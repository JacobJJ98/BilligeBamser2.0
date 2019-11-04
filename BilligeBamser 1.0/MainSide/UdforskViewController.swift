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
}

class UdforskViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

       override func viewDidLoad() {
           super.viewDidLoad()
        collectionView.backgroundColor = UIColor.clear
        
       }
    
 
    override func viewDidAppear(_ animated: Bool) {
        // SVProgressHUD.show()
        // BarListe.shared.barer.removeAll()
        // self.HentBarer()
        
    }
    
    
    let reuseIdentifier = "collectionViewCellId"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell

        //TODO HENT DATA FRA BARLISTE MED 10 TÆTTESTE PÅ
        let testdata = ["Palæen", "Old Irish - Lyngby ", "Den glade gris", "Hegnet","Artillericafeen","DTU fredagsbar","Ruder Konge","IRISH tivoli","DIAMANTEN","billige bamse cafe :)"
        ]
        
        // var testimage : UIImage = UIImage(named:"plus1")!
              
        // cell.imageView = UIImageView(image: testimage)
        
        // cell.imageView.backgroundColor = UIColor.randomColor()
        cell.text.text = testdata[indexPath.row]
        // cell.text.textColor = UIColor.blue
        print("test tekst for cell er: \(cell.text.text)")
        return cell
    }
       
       
    

}

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
    
    @IBOutlet var erFavoImage: UIImageView!
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

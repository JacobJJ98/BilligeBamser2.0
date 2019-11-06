//
//  ViewControllerUdforsk.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 05/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class NavigationControllerUdforsk: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 39, height: 39))
         imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "1")
        imageView.image = image
        self.navigationItem.titleView = imageView
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
       
       
        
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

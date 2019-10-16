//
//  OpretBajerViewController.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 09/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class OpretBajerViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    
    @IBAction func tilbage(_ sender: UIButton) {
        performSegueToReturnBack()
    }
    
    func performSegueToReturnBack()  {
        
            self.dismiss(animated: true, completion: nil)
        
    }
   
}

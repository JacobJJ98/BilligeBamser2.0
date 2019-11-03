//
//  FavoriterTableViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 03/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class FavoriterTableViewController: UITableViewController {
    
    var bars = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillBars()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fillBars() {
        let sampleChairs = ["Palæen", "Old Irish - Lyngby ", "Den glade gris", "Hegnet"
        ]
        
        bars = sampleChairs.compactMap {$0}
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bars.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "barCell", for: indexPath) as! HeadlineTableViewCell

        // Configure the cell...
        
       // let cell = tableView.dequeueReusableCell(withIdentifier: "chairCell", for: indexPath)

        // Configure the cell...

        // tableView.labe.text = bars[indexPath.row]
        cell.navnet.text = bars[indexPath.row]
        cell.storBillede.image = UIImage(named: "Beer-Mug")
        cell.prisTekst.text = "24 Kr"
        cell.prisBillede.image = UIImage(named: "Beer-Mug")
        cell.mapTekst.text = "0.2 Km"
        cell.mapBillede.image = UIImage(named: "mapGrey")
        // cell.imageView?.image =
        // cell.imageView?.image = chairs[indexPath.row].image
     //   return cell

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storBillede: UIImageView!
    
    @IBOutlet weak var navnet: UILabel!
    @IBOutlet weak var prisBillede: UIImageView!
    
    @IBOutlet weak var prisTekst: UILabel!
    
    @IBOutlet weak var mapBillede: UIImageView!
    
    @IBOutlet weak var mapTekst: UILabel!
    
}

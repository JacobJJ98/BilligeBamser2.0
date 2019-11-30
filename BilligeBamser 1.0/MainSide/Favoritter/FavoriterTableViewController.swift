//
//  FavoriterTableViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 03/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class FavoriterTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let lokationen = locationManager.location {
                   BarListe.shared.sorterFavoEfterAfsted(loka: lokationen)
               }
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        // her sorteres favoritterne efter distancen
        if let lokationen = locationManager.location {
            BarListe.shared.sorterFavoEfterAfsted(loka: lokationen)
        }
        print("Antal barer: \(BarListe.shared.barer.count)" )
        
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "bg6"))
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            // remove the item from the data model
            
            var id = BarListe.shared.egneFavoritter[indexPath.row].id!
            
            BarListe.shared.brugerLoggetind.sletFavorit(ID: id)
            BarListe.shared.sletFavorit(ID: id)
            
            FirebaseAPI.shared.opdaterFavorit { (res, err) in
                // completion her!
                print("COMPLETION")
            }
            
            // delete the table view row
            print("efter Completion")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [delete]
    }
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Vis vej", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("DER VISES VEJ!!!")
            let coordinate = CLLocationCoordinate2DMake(BarListe.shared.egneFavoritter[indexPath.row].coordinate.latitude,BarListe.shared.egneFavoritter[indexPath.row].coordinate.longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = BarListe.shared.egneFavoritter[indexPath.row].navn
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
            
            success(true)
        })
        closeAction.backgroundColor = .blue
        closeAction.title = "Vis vej"
        
        return UISwipeActionsConfiguration(actions: [closeAction])
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BarListe.shared.egneFavoritter.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "barCell", for: indexPath) as! HeadlineTableViewCell
        
        // Configure the cell...
        
        // Configure the cell...
        cell.navnet.text = BarListe.shared.egneFavoritter[indexPath.row].navn
        // cell.storBillede.image = UIImage(named: "Beer-Mug")
        
        
        cell.prisTekst.text = "\(BarListe.shared.egneFavoritter[indexPath.row].flaskepris) Kr"
        if CLLocationManager.locationServicesEnabled() {
            if let lokationen = locationManager.location {
                let barLoka = CLLocation(latitude: BarListe.shared.egneFavoritter[indexPath.row].coordinate.latitude, longitude: BarListe.shared.egneFavoritter[indexPath.row].coordinate.longitude)
                
                let dist = lokationen.distance(from: barLoka)/1000.rounded()
                let distRounded = String(format: "%.1f", dist)
                print(dist)
                
                cell.mapTekst.text = "\(distRounded) Km"
            } else {
                cell.mapTekst.text = "---"
            }
        }
        
        
        
       // cell.mapBillede.image = UIImage(named: "mapGrey")
        
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

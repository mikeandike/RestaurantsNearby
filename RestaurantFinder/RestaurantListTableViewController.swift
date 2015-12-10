//
//  RestaurantListTableViewController.swift
//  RestaurantFinder
//
//  Created by Michael Sacks on 12/9/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RestaurantListTableViewController: UITableViewController, CLLocationManagerDelegate {

    var restaurantsList = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LocationController.sharedInstance.getCurrentLocation()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "locationUpdatedNotification:", name: "locationUpdated", object: nil)
        
        self.navigationItem.title = "Getting Location"
    }

    func locationUpdatedNotification(notification: NSNotification) {
        if let locationInEnglish = notification.userInfo!["locationInEnglish"] as? String {
            self.navigationItem.title = "\(locationInEnglish)"
        }
        
        if let location = notification.userInfo!["location"] as? CLLocation {
            RestaurantController.getRestaurants(location, completion: { (restaurants) -> Void in
                self.restaurantsList = restaurants
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            })
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantsList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        cell.textLabel?.text = restaurantsList[indexPath.row].name

        return cell
    }
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}

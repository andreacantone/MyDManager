//
//  MenuTableViewController.swift
//  Menu
//
//  Created by De Luca Raffaele on 28/01/17.
//  Copyright © 2017 iOSFoundation. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    //@IBOutlet weak var menuButton: UIBarButtonItem!
    
    var courseTypes = ["First courses", "Second courses", "Side dishes", "Drinks", "Sandwitches and pizzas", "Fruits", "Desserts"]
    var courseImages = ["primi", "secondi", "contorni", "bevande", "pizze", "frutta", "dolci"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courseTypes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "course"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SourceTableViewCell
        
        cell.SourceOutlet?.text = courseTypes[indexPath.row]
        cell.SourceImageOutlet?.image = UIImage(named: courseImages[indexPath.row])
        
        // Configure the cell...
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "choice"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as!
                MenuInternoTableViewController
                destinationController.coursesName = courseTypes[indexPath.row]
                destinationController.titles = courseTypes[indexPath.row]
            }
        }
        
    }
}

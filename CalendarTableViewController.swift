//
//  CalendarTableViewController.swift
//  My Diabetic Manager
//
//  Created by Vincenzo De Rosa on 03/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit
import EventKitUI

class CalendarTableViewController: UITableViewController {
    
    var titles : [String] = []
    var startDates : [NSDate] = []
    var endDates : [NSDate] = []
    var descs : [String] = []
    
    func printEvents(){

        
        let eventStore = EKEventStore()
        let calendars = eventStore.calendars(for: .event)
        
        for calendar in calendars {
            if calendar == eventStore.defaultCalendarForNewEvents {
                
                let oneMonthAgo = NSDate(timeIntervalSinceNow: -30*24*3600)
                let oneMonthAfter = NSDate(timeIntervalSinceNow: +30*24*3600)
                
                let predicate = eventStore.predicateForEvents(withStart: oneMonthAgo as Date, end: oneMonthAfter as Date, calendars: [calendar])
                
                let events = eventStore.events(matching: predicate)
                
                for event in events {
                    if event.title.hasSuffix("-MDM"){
                        titles.append(event.title)
                        startDates.append(event.startDate as NSDate)
                        endDates.append(event.endDate as NSDate)
                        descs.append(event.notes!)
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        printEvents()
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
        return titles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "events"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventTableViewCell
        
        cell.Note?.text = descs[indexPath.row]
        cell.title?.text = titles[indexPath.row]
        
        
        // Configure the cell...
        
        return cell
    }
}

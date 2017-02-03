//
//  CalendarViewController.swift
//  My Diabetic Manager
//
//  Created by Vincenzo De Rosa on 03/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit
import EventKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var eventName: UITextField!

    @IBOutlet weak var startDate: UIDatePicker!
    
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var note: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printEvents()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func addEventToCalendar(title: String, description: String?, startDate: NSDate, endDate: NSDate, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title + "-MDM"
                event.startDate = startDate as Date
                event.endDate = endDate as Date
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
    @IBAction func saveEvent(_ sender: UIBarButtonItem) {
        addEventToCalendar(title: eventName.text!, description: note.text!, startDate: startDate.date as NSDate, endDate: endDate.date as NSDate)
    }
    
    func printEvents(){
        var titles : [String] = []
        var startDates : [NSDate] = []
        var endDates : [NSDate] = []
        var descs : [String] = []
        
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
                print(titles)
                print(startDates)
                print(endDates)
                print(descs)
            }
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

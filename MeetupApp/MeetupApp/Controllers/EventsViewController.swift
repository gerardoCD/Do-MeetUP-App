//
//  EventsTableViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/11/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import EventKit
var myIndex = 0

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var refresher: UIRefreshControl!
    
    var events = [Event]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Update Events")
        refresher.addTarget(self, action: #selector(EventsViewController.loadEventInfo), for: UIControl.Event.valueChanged)
        tableView.addSubview(refresher)
        loadEventInfo()
    }
    override func viewDidAppear(_ animated: Bool) {
        loadEventInfo()
    }
    
    
    //Datos hardcodeados para probar
    @objc func loadEventInfo(){
        Event.loadTickets { (eventsAux) in
            self.events = eventsAux
            self.tableView?.reloadData()
        }
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segueDetailedEvent", sender: myIndex)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EventsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventsTableViewCell else{
            fatalError("The dequeued cell is not an instance of EventsTableViewCell.")
        }

        // Configure the cell...
        let event = events[indexPath.row]
        cell.labelEventTitle.text = event.name
        cell.labelEventDescription.text = event.description
        DispatchQueue.main.async {
            let url = URL(string: event.photoString!)
            let data = try? Data(contentsOf: url!)
            let image  = UIImage(data: data!)
            self.events[indexPath.row].photo = image
            cell.eventImage.image = image
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let calendar = UITableViewRowAction(style: .normal, title: "\u{1F4C5}\n") { action, index in
            let eventStore = EKEventStore()
            eventStore.requestAccess(to: .event, completion: { (succes, error) in
                if error == nil{
                    let event = EKEvent(eventStore: eventStore)
                    print( self.events[indexPath.row].name)
                    event.title = "\(self.events[indexPath.row].name)"
                    event.location = "\(String(describing: self.events[indexPath.row].place))"
                    event.startDate = Date()
                    event.endDate = Date()
                    event.notes = "\(self.events[indexPath.row].description)"
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    print(event.description)
                    do {
                        try eventStore.save(event, span: .thisEvent)
                        let alert = UIAlertController(title: "Congratulations", message: "Your event is saved \n check it on your calendar", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in  self.navigationController?.popToRootViewController(animated: true)}))
                        self.present(alert, animated: true)
                        
                    }catch let error as NSError{
                        print(error)
                        let alert = UIAlertController(title: "Error", message: "Your event could not add the calendar ", preferredStyle: .alert )
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                        self.present(alert, animated: true)
                    }
                }else{
                    let alert = UIAlertController(title: "Error", message: "You have not access the calendar", preferredStyle: .alert )
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                    self.present(alert, animated: true)
                    
                }
                
            })
        }
        calendar.backgroundColor = .lightGray
        
        let share = UITableViewRowAction(style: .normal, title: "↩️") { action, index in
            let activityController = UIActivityViewController(activityItems: [self.events[indexPath.row].name,self.events[indexPath.row].startDate,self.events[indexPath.row].photo!],
                                                              applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        share.backgroundColor = .blue
        
        return [share, calendar]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is EventDescriptionViewController
        {
            let vc = segue.destination as? EventDescriptionViewController
            vc?.eventName = events[sender as! Int].name
            vc?.eventPhoto = events[sender as! Int].photo!
            vc?.eventDescriptionVar = events[sender as! Int].description
            vc?.eventPlace = events[sender as! Int].place!
            vc?.eventStartDate = events[sender as! Int].startDate
            vc?.eventEndDate = events[sender as! Int].endDate!
            vc?.eventStarHour = events[sender as! Int].startHour!
            vc?.eventEndHour = events[sender as! Int].endHour!
            vc?.eventPrice = events[sender as! Int].cost
            vc?.eventCountry = events[sender as! Int].country!
            vc?.eventCity = events[sender as! Int].city!
            vc?.eventStreet = events[sender as! Int].street!
        }
    }
    
    
    
    
}

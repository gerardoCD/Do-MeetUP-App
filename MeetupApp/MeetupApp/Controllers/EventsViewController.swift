//
//  EventsTableViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/11/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit

var myIndex = 0

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events = [Event]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadEventInfo()
    }
    
    //Datos hardcodeados para probar
    func loadEventInfo(){
        let photoPrueba = UIImage(named: "prueba")
        let photoPrueba2 = UIImage(named: "prueba2")
        let photoPrueba3 = UIImage(named: "prueba3")

        
        guard let event = Event(name: "Title", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", photo: photoPrueba!, place: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu", date: "1/1/2018", cost: 37.50) else {
            fatalError("Unable to instantiate event")
        }
        
        guard let event2 = Event(name: "Title2", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", photo: photoPrueba2!, place: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu", date: "6/6/2018", cost: 47.50) else {
            fatalError("Unable to instantiate event2")
        }
        
        guard let event3 = Event(name: "Title3", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", photo: photoPrueba3!, place: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu", date: "9/12/2018", cost: 0.0) else {
            fatalError("Unable to instantiate event3")
        }
        
        events += [event,event2,event3]
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
        cell.eventImage.image = event.photo

        return cell
    }
    

    

}

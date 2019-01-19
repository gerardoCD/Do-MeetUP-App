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
    var events = [Event]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadEventInfo()
    }
    
    
    
    //Datos hardcodeados para probar
    func loadEventInfo(){
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("events").observeSingleEvent(of: .value, with: { (snapshot) in
            //let username = value?["username"] as? String ?? ""
            //let user = User(username: username)
//                for (_, valor) in value!{
//                    let auxEvent = Event()
//                    for(llave2, valor2) in valor as! NSDictionary{
//                       // print(llave2)
//                        if llave2 as! String == "Date"{
//                            auxEvent.date = valor2 as! String
//                        }else if llave2 as! String == "Description"{
//                            auxEvent.description = valor2 as! String
//                        }else if llave2 as! String == "Image"{
//                           /* let url = URL(string: llave2 as! String)
//                            let data = try? Data(contentsOf: url!)
//                            auxEvent.photo = UIImage(data: data!)*/
//                        }else if llave2 as! String == "Map"{
//                            auxEvent.place = valor2 as! String
//                        }else if llave2 as! String == "Name"{
//                            auxEvent.name = valor2 as! String
//                        }else if llave2 as! String == "Price"{
//                            auxEvent.cost = valor2 as! Double
//                        }
//                         self.events.append(auxEvent)
//                    }
                var eventlistaux = [[String]]()
                for event in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    var auxList = [String]()
                    print(event.key)
                    let eventObject = event.value as? [String: AnyObject]
                    let eventName  = eventObject?["Name"]
                    let eventDescription  = eventObject?["Description"]
                    let eventStartDate = eventObject?["StartDate"]
                    let eventImage = eventObject?["Image"]
                    let eventMapa = eventObject?["Map"]
                    let eventPrice = eventObject?["Price"]
                    let eventCountry = eventObject?["Country"]
                    let eventCity = eventObject?["City"]
                    let eventStreet = eventObject?["Street"]
                    let eventStartHour = eventObject?["StartHour"]
                    let eventEndHour = eventObject?["EndHour"]
                    let eventEndDate = eventObject?["EndDate"]
                    print(eventEndDate)
                    auxList.append(eventStartDate as! String)
                    auxList.append(eventDescription as! String)
                    auxList.append(eventImage as! String)
                    auxList.append(eventMapa as! String)
                    auxList.append(eventName as! String)
                    auxList.append(String(eventPrice as! Double))
                    auxList.append(event.key)
                    auxList.append(eventCountry as! String)
                    auxList.append(eventCity as! String)
                    auxList.append(eventStreet as! String)
                    auxList.append(eventStartHour as! String)
                    auxList.append(eventEndHour as! String)
                    auxList.append(eventEndDate as! String)
                    eventlistaux.append(auxList)
                   // debugPrint(auxList)
                }
                UserDefaults.standard.set(eventlistaux, forKey: "Events")
                //self.tableView.reloadData()
               // debugPrint(eventlistaux)
        })
        
        guard let eventArrayString = UserDefaults.standard.array(forKey: "Events")else { return }
        for eventOne in eventArrayString as! [[String]]{
            let url = URL(string: eventOne[2] )
            let data = try? Data(contentsOf: url!)
            let image  = UIImage(data: data!)
            events.append(Event(id: eventOne[6], name: eventOne[4], description: eventOne[1], photo: image!, place: eventOne[3], date: nil, cost: Double(eventOne[5])!, photoString: eventOne[2], tickets: nil, startDate: eventOne[0], endDate: eventOne[12], country: eventOne[7], city: eventOne[8], street: eventOne[9], startHour: eventOne[10], endHour: eventOne[11]))
            //print(eventOne[7] + "  " + eventOne[8] + "  " + eventOne[9])
            
        }
       // tableView.reloadData()
        
        
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
             cell.eventImage.image = event.photo
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
}

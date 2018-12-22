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

         //                      let aux = Event()
         //                    aux.name = eventName as! String
         //                    aux.description = eventDescription as! String
         //                    aux.date = eventDate as! String
         //                    aux.cost = eventPrice as! Double
         //                    aux.place = eventMapa as! String
         //                    self.events.append(aux)

         
         
        
      
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
                    let eventObject = event.value as? [String: AnyObject]
                    let eventName  = eventObject?["Name"]
                    let eventDescription  = eventObject?["Description"]
                    let eventDate = eventObject?["Date"]
                    let eventImage = eventObject?["Image"]
                    let eventMapa = eventObject?["Map"]
                    let eventPrice = eventObject?["Price"]
                    auxList.append(eventDate as! String)
                    auxList.append(eventDescription as! String)
                    auxList.append(eventImage as! String)
                    auxList.append(eventMapa as! String)
                    auxList.append(eventName as! String)
                    auxList.append(String(eventPrice as! Double))
                    eventlistaux.append(auxList)
                    debugPrint(auxList)
                }
                UserDefaults.standard.set(eventlistaux, forKey: "Events")
                //self.tableView.reloadData()
                debugPrint(eventlistaux)
        })
        
        guard let eventArrayString = UserDefaults.standard.array(forKey: "Events")else { return }
        for eventOne in eventArrayString as! [[String]]{
            let url = URL(string: eventOne[2] )
            let data = try? Data(contentsOf: url!)
            let image  = UIImage(data: data!)
            events.append(Event(name: eventOne[4], description: eventOne[1], photo: image!, place: eventOne[3], date: eventOne[0], cost: Double(eventOne[5])!))
            
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
        cell.eventImage.image = event.photo
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    

    

}

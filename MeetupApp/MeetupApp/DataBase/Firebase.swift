//
//  Firebase.swift
//  MeetupApp
//
//  Created by Gerardo Castillo Duran  on 1/3/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import Foundation
import Firebase


class Ticket{
    static func loadTickets(completion: @escaping (_ events: [Event]) -> Void){
        let uid = Auth.auth().currentUser?.uid
      
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users/profile/\(uid ?? "")/events").observeSingleEvent(of: .value, with: { (snapshot) in
        var events = [Event]()
        for event in snapshot.children.allObjects as! [DataSnapshot] {
                let eventObject = event.value as? [String: AnyObject]
                let evenId = event.key
                let eventName  = eventObject?["Name"]
                let eventImage = eventObject?["Image"]
                let eventDescription = eventObject?["Description"]
                let eventTickets = eventObject?["Tickets"]
                let evenStart = eventObject?["Start"]
//                let url = URL(string: eventImage as! String)
//                let data = try? Data(contentsOf: url!)
//                let image  = UIImage(data: data!)
            let evento = Event(id: evenId, name: eventName as! String, description: eventDescription as! String, photo: nil , place: nil, date: nil , cost: 0.0, photoString: eventImage as? String, tickets: eventTickets as? [String], startDate: evenStart as! String, endDate: nil, country: nil, city: nil, street: nil, startHour: nil, endHour: nil)
                events.append(evento)
            }
            print(events)
            completion(events)
        })
        
    }
}



//
//  Event.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/11/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
class Event {
    var id: String = ""
    var name: String = ""
    var description: String = ""
    var photo: UIImage? = nil
    var photoString: String? = nil
    var startDate:String = ""
    var endDate:String? = nil
    var startHour:String? = nil
    var endHour:String? = nil
    var place: String? = nil
    var date: String? = nil
    var cost: Double = 0.0
    var country: String? = nil
    var city: String? = nil
    var street: String? = nil
    var tickets: [String]? = nil
    
    init(id: String, name: String, description: String,photo:UIImage?,place:String?,date:String?,cost:Double,photoString:String?,tickets:[String]?,startDate:String,endDate:String?,country:String?,city:String?,street:String?,startHour:String?,endHour:String?) {
        self.id = id
        self.name = name
        self.description = description
        self.photo = photo
        self.photoString = photoString
        self.place = place
        self.date = date
        self.cost = cost
        self.tickets = tickets
        self.startDate = startDate
        self.endDate = endDate
        self.country = country
        self.city = city
        self.street = street
        self.startHour = startHour
        self.endHour = endHour
        
    }
    
    
    static func loadTickets(completion: @escaping (_ events: [Event]) -> Void){
        var ref: DatabaseReference!
        ref = Database.database().reference()
  
        ref.child("events").observeSingleEvent(of: .value, with: { (snapshot) in
            var events = [Event]()
            for event in snapshot.children.allObjects as! [DataSnapshot] {
                //getting values
                let eventObject = event.value as? [String: AnyObject]
                let eventId = event.key
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
                events.append(Event(id: eventId, name: eventName as! String, description: eventDescription as! String, photo: nil, place: eventMapa as? String, date: nil, cost: eventPrice as! Double, photoString: eventImage as? String, tickets: nil, startDate: eventStartDate as! String, endDate: eventEndDate as? String, country: eventCountry as? String, city: eventCity as? String, street: eventStreet as? String, startHour: eventStartHour as? String, endHour: eventEndHour as? String))
            }
            completion(events)
        })
        
}
    
    
    static func loadEventsTickets(idEvent:String,completion: @escaping (_ events: [[String]]) -> Void){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("eventsTickets/\(idEvent)").observeSingleEvent(of: .value, with: { (snapshot) in
            var events = [[String]]()
            let eventObject = snapshot.value as? [String: AnyObject]
            let eventRemainingTickets = eventObject?["RemainingTickets"]
            let eventAlltickets = eventObject?["AllTickets"]
            events.append(eventRemainingTickets as! [String])
            events.append(eventAlltickets as! [String])
            completion(events)
        })
        
    }
    
    
    
}

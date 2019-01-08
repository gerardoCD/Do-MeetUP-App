//
//  Event.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/11/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var id: String = ""
    var name: String = ""
    var description: String = ""
    var photo: UIImage? = nil
    var photoString: String? = nil
    var startDate:String = ""
    var endDate:String? = nil
    var place: String? = nil
    var date: String? = nil
    var cost: Double = 0.0
    var country: String? = nil
    var city: String? = nil
    var street: String? = nil
    var tickets: [String]? = nil
    
    init(id: String, name: String, description: String,photo:UIImage?,place:String?,date:String?,cost:Double,photoString:String?,tickets:[String]?,startDate:String,endDate:String?,country:String?,city:String?,street:String?) {
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
    }
}

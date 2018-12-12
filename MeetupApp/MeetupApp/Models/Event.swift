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
    var name: String = ""
    var description: String = ""
    var photo: UIImage? = nil
    var place: String = ""
    var date: String = ""
    var cost: Double = 0.0
    
    init(name: String, description: String,photo:UIImage,place:String,date:String,cost:Double) {
        self.name = name
        self.description = description
        self.photo = photo
        self.place = place
        self.date = date
        self.cost = cost
    }
}

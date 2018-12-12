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
    var name: String
    var description: String
    var photo: UIImage?
    var place: String
    var date: String
    var cost: Double
    
    init?(name: String, description: String, photo: UIImage, place: String, date: String, cost: Double) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.description = description
        self.photo = photo
        self.place = place
        self.date = date
        self.cost = cost
    }
}

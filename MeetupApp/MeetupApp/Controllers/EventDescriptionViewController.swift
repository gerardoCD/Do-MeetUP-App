//
//  EventDescriptionViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/12/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit

class EventDescriptionViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var whereDescription: UITextView!
    @IBOutlet weak var dateDescription: UILabel!
    @IBOutlet weak var priceDescription: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var event: Event?
    var eve = EventsViewController()

    override func viewDidLoad() {
        eve.loadEventInfo()
        super.viewDidLoad()
        
        eventTitleLabel.text = eve.events[myIndex].name
        imageEvent.image = eve.events[myIndex].photo
        eventDescription.text = eve.events[myIndex].description
        whereDescription.text = eve.events[myIndex].place
        dateDescription.text = eve.events[myIndex].date
        priceDescription.text = String(eve.events[myIndex].cost)
        
        //Login button aspects
        buyButton.layer.cornerRadius = 8.0
        buyButton.layer.masksToBounds = true
    }

}

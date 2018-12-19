//
//  EventDescriptionViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/12/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit
import MapKit

class EventDescriptionViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var whereDescription: UITextView!
    @IBOutlet weak var dateDescription: UILabel!
    @IBOutlet weak var priceDescription: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var numberTickets: UILabel!
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var mapView: MKMapView!
    
    
    

    var event: Event?
    var eve = EventsViewController()
    let regionRadius: CLLocationDistance = 100
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        eve.loadEventInfo()
        //Datos hardcodeados de localizacion de bellas artes
        let initialLocation = CLLocation(latitude: 19.435639, longitude: -99.141278)
        centerMapOnLocation(location: initialLocation)
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
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        numberTickets.text = String(currentValue)
    }
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       options: [UIView.AnimationOptions.curveEaseInOut, .autoreverse],
                       animations: {
                        self.buyButton.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                        self.buyButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        },
                       completion: nil)
    }
    
    
}



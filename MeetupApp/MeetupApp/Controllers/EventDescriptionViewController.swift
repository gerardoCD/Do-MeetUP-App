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
    //Datos hardcodeados para probar ubicación
    let regionRadius: CLLocationDistance = 100
    var country = "Mexico"
    var city = "Ciudad de Mexico"
    var street = "Fernando Iglesias Calderon"
    lazy var geocoder = CLGeocoder()
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        eve.loadEventInfo()
        eventTitleLabel.text = eve.events[myIndex].name
        imageEvent.image = eve.events[myIndex].photo
        eventDescription.text = eve.events[myIndex].description
        whereDescription.text = eve.events[myIndex].place
        dateDescription.text = eve.events[myIndex].date
        priceDescription.text = String(eve.events[myIndex].cost)
        
        //Login button aspects
        buyButton.layer.cornerRadius = 8.0
        buyButton.layer.masksToBounds = true
        
        // Geocode Address String
        let address = "\(country), \(city), \(street)"
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }

    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                print(coordinate.latitude)
                print(coordinate.longitude)
                let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                          latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                mapView.setRegion(coordinateRegion, animated: true)
                mapView.setRegion(coordinateRegion, animated: true)
            } else {
                print("No Matching Location Found")
            }
        }
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



//
//  EventDescriptionViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/12/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class EventDescriptionViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var whereDescription: UITextView!
    @IBOutlet weak var dateDescription: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startHour: UILabel!
    @IBOutlet weak var endHour: UILabel!
    @IBOutlet weak var priceDescription: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var numberTickets: UILabel!
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var mapView: MKMapView!
    
    //////----------
    var eventName = ""
    var eventPhoto = UIImage()
    var eventDescriptionVar = ""
//    var eventStartDate
//    var eventEndDate
//    var eventStarHour
//    var eventEndHour
//    var 

    var event: Event?
    var eve = EventsViewController()
    //Datos hardcodeados para probar ubicación
    let regionRadius: CLLocationDistance = 100
    var country = ""
    var city = ""
    var street = ""
    lazy var geocoder = CLGeocoder()
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        eve.loadEventInfo()
        //print(eve.events[myIndex].name)
        eventTitleLabel.text = eve.events[myIndex].name
        imageEvent.image = eve.events[myIndex].photo
        eventDescription.text = eve.events[myIndex].description
        whereDescription.text = eve.events[myIndex].place
        dateDescription.text = eve.events[myIndex].startDate
        endDate.text = eve.events[myIndex].endDate
        startHour.text =  eve.events[myIndex].startHour
        endHour.text = eve.events[myIndex].endHour
        priceDescription.text = String(eve.events[myIndex].cost)
        country = eve.events[myIndex].country!
        street = eve.events[myIndex].street!
        city = eve.events[myIndex].city!
        //Login button aspects
        buyButton.layer.cornerRadius = 8.0
        buyButton.layer.masksToBounds = true
        buyButton.isUserInteractionEnabled = false
        buyButton.alpha = 0.5
        
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
        if currentValue == 0{
            buyButton.isUserInteractionEnabled = false
            buyButton.alpha = 0.5
        }
        else{
            buyButton.isUserInteractionEnabled = true
            buyButton.alpha = 1.0
        }
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
        if Auth.auth().currentUser != nil {
            // User is signed in
            guard let uid = Auth.auth().currentUser?.uid else { return }

            let databaseRef = Database.database().reference().child("users/profile/\(uid)/events")
            let key = eve.events[myIndex].id
            // let key = databaseRef.childByAutoId().key NO BORRARRRRRRR
            let numberTickets = Int(sliderBar.value)
            let tickets = generateTickets(number:numberTickets)
            //print(tickets)
            let userObject = [
                key: [
                    "Name": eve.events[myIndex].name,
                    "Description": eve.events[myIndex].description,
                    "Image": eve.events[myIndex].photoString!,
                    "Start": eve.events[myIndex].startDate,
                    "Tickets": tickets
                ]
                ] as [String:Any]

            databaseRef.updateChildValues(userObject)
            
            let cost: Double = eve.events[myIndex].cost
            let total = cost*Double(numberTickets)
            
            let alert = UIAlertController(title: "Purchase made", message: "Total cost: \(total). Enjoy it!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in  self.navigationController?.popToRootViewController(animated: true)}))
            self.present(alert, animated: true)
            
            
        } else {
            performSegue(withIdentifier: "segueFromBuyToLogin" , sender: nil)
            let alert = UIAlertController(title: "You're no loged", message: "Login before to try to buy something", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I Understand", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func generateTickets(number: Int) -> [String]{
        var tickets = [String]()
        var  contador = 0
        while (contador < number){
            let numero = String(Int.random(in: 10000 ... 99999))
            if !tickets.contains(numero){
                tickets.append(numero)
                contador += 1
            }
        }
        return tickets
    }
    
    
}



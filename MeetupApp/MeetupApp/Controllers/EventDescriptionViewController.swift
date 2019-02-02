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
    var eventPlace = ""
    var eventStartDate = ""
    var eventEndDate = ""
    var eventStarHour = ""
    var eventEndHour = ""
    var eventPrice = 0.0
    var eventCountry = ""
    var eventCity = ""
    var eventStreet = ""
    var eventId = ""
    var eventPhotoString = ""
    
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
       // eve.loadEventInfo()
        //print(eve.events[myIndex].name)
        eventTitleLabel.text = eventName
        imageEvent.image = eventPhoto
        eventDescription.text = eventDescriptionVar
        whereDescription.text = eventPlace
        dateDescription.text = eventStartDate
        endDate.text = eventEndDate
        startHour.text =  eventStarHour
        endHour.text = eventEndHour
        priceDescription.text = String(eventPrice)
        country = eventCountry
        street = eventStreet
        city = eventCity
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

           
            let key = eventId
            // let key = databaseRef.childByAutoId().key NO BORRARRRRRRR
            let numberTickets = Int(sliderBar.value)
            var tickestBuy = [String]()
            Event.loadEventsTickets(idEvent: key) { (eventRemainingTickets) in
                var eventventRemainingTicketsOne = eventRemainingTickets[0]
                let eventventRemainingTicketsTwo = eventRemainingTickets[1]
                if self.validateNumberTickets(numberTickets: numberTickets, tickets: eventventRemainingTicketsOne){
                    // Si hay disponibiidad
                    var contador = 0
                    while (contador <= numberTickets - 1) {
                        tickestBuy.append(eventventRemainingTicketsOne.first!)
                        eventventRemainingTicketsOne.removeFirst()
                        contador += 1
                    }
                    contador = 0
                    let databaseRef2 = Database.database().reference().child("eventsTickets/")
                    let allTickets = [
                        key: [
                            "AllTickets": eventventRemainingTicketsTwo,
                            "RemainingTickets": eventventRemainingTicketsOne
                        ]
                        ] as [String:Any]
                    
                    databaseRef2.updateChildValues(allTickets)
                    
                    let databaseRef = Database.database().reference().child("users/profile/\(uid)/events")
                    let userObject = [
                        key: [
                            "Name": self.eventName,
                            "Description": self.eventDescriptionVar,
                            "Image": self.eventPhotoString
                            ,
                            "Start": self.eventStartDate,
                            "Tickets": tickestBuy
                        ]
                        ] as [String:Any]
                    
                    databaseRef.updateChildValues(userObject)
                    let cost: Double = self.eventPrice
                    let total = cost*Double(numberTickets)
                    
                    let alert = UIAlertController(title: "Purchase made", message: "Total cost: \(total). Enjoy it!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in  self.navigationController?.popToRootViewController(animated: true)}))
                    self.present(alert, animated: true)
                    
                    
                }else{
                    let alert = UIAlertController(title: "Sorry", message: "We do not have enough tickets for the event", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            


            
           
            
            
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
    
    func validateNumberTickets(numberTickets:Int,tickets:[String]) -> Bool{
        
        if tickets.count < numberTickets{
            return false
        }else{
            return true
        }
        
    }
    
    
    
    
    
}



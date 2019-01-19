//
//  MainViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/18/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    @IBOutlet var viewStart: UIView!
    var event: Event?
    var eve = EventsViewController()
    
    // A delay function
    func delay(_ seconds: Double, completion: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var findMoreLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var threeImage: UIImageView!
    @IBOutlet weak var meetImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eve.loadEventInfo()
        if Auth.auth().currentUser != nil {
            signInButton.isHidden = true
            logOutButton.isHidden = false
        }else{
            signInButton.isHidden = false
            logOutButton.isHidden = true
        }
       
        //set up the UI
        threeImage.alpha = 1.0
        meetImage.alpha = 0.0
        signInButton.layer.cornerRadius = 8.0
        signInButton.layer.masksToBounds = true
        logOutButton.layer.cornerRadius = 8.0
        logOutButton.layer.masksToBounds = true
        if eve.events.count == 0{
            return
        }else{
            let randomNumber = Int(arc4random_uniform(UInt32(eve.events.count)))
            eventImage.image = eve.events[randomNumber].photo
            eventTitleLabel.text = eve.events[randomNumber].name
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.eventImage.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        if Auth.auth().currentUser != nil {
            signInButton.isHidden = true
            logOutButton.isHidden = false
        }else{
            signInButton.isHidden = false
            logOutButton.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0){
            self.headImage.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.headImage.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        UIView.animate(withDuration: 1.25){
            self.eventImage.alpha = 0.05
            self.eventImage.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
            self.eventImage.alpha = 1.0
            self.eventImage.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        UIView.animate(withDuration: 7, delay: 0.3, options: [.curveEaseInOut, .repeat, .autoreverse], animations:{
            self.threeImage.alpha = 0.0
            self.meetImage.alpha = 1.0
        },
                       completion: nil
        )
        
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
      
    }
    
    
    @IBAction func btnLogOut(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            print("EntroAqui")
            logOutButton.isHidden = true
            signInButton.isHidden = false
        }catch{
            let alert = UIAlertController(title: "Error", message: "You can't Log Out", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
            self.present(alert, animated: true)
        }
    }
    
    
    
    
}

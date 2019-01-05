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
    @IBOutlet weak var cloudImage: UIImageView!
    @IBOutlet weak var cloudImageTwo: UIImageView!
    @IBOutlet weak var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        if Auth.auth().currentUser != nil {
            signInButton.isHidden = true
            logOutButton.isHidden = false
        }else{
            signInButton.isHidden = false
            logOutButton.isHidden = true
        }
        super.viewDidLoad()
        eve.loadEventInfo()
        //set up the UI
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
            self.cloudImage.alpha = 0.1
            self.cloudImageTwo.alpha = 0.1
            self.cloudImage.center.x += self.view.bounds.width/8
            self.cloudImageTwo.center.x -= self.view.bounds.width/12
            self.cloudImage.alpha = 1.0
            self.cloudImageTwo.alpha = 1.0
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

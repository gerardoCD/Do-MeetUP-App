//
//  SignUpViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/10/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var heading: UIImageView!
    @IBOutlet weak var subHeading: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Login button aspects
        signUpButton.layer.cornerRadius = 8.0
        signUpButton.layer.masksToBounds = true
    }
    
    //Settings after the view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0){
            self.heading.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.heading.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        UIView.animate(withDuration: 1, delay: 0.3, options: [], animations:{
            self.subHeading.transform = CGAffineTransform.init(scaleX: 1.7, y: 1.7)
            self.subHeading.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        },
                       completion: nil
        )
    }
    

    @IBAction func signUpButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseInOut, .autoreverse], animations:{
            self.signUpButton.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.signUpButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
        },
                       completion: nil
        )
    }
    

}

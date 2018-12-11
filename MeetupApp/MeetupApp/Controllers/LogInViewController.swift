    //
//  LogInViewController.swift
//  MeetupApp
//
//  Created by Gerardo on 12/5/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit
import FirebaseAuth
    
    // A delay function
    func delay(_ seconds: Double, completion: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }

class LogInViewController: UIViewController {
    
    @IBOutlet weak var heading: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var peopleImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Login button aspects
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
    }
    
    //Settings after the view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0){
            self.heading.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.heading.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
    }
    
    //The button was tapped 
    @IBAction func signInTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseInOut, .autoreverse], animations:{
            self.peopleImage.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.peopleImage.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
        },
                       completion: nil
        )
        

     
        Auth.auth().signIn(withEmail: txtEmail.text, password: txtPassword.text) { (user, error) in
            if user != nil {
                // Pasa ventana
                //alerta "©
              print("Ya esta loggeado")
            
            }else{
                //alerta de errro
                print("error")
            }
        }
        
       
    }
    


}

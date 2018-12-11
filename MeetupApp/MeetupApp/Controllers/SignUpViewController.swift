//
//  SignUpViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 12/10/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var heading: UIImageView!
    @IBOutlet weak var subHeading: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblUserName: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblConfirmPassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Login button aspects
        signUpButton.layer.cornerRadius = 8.0
        signUpButton.layer.masksToBounds = true
     //   signUpButton.isEnabled = false
     //   signUpButton.isOpaque = true
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
    
    
    @IBAction func changeFiields(_ sender: UITextField) {
        if lblEmail.text != "" && lblPassword.text != "" && lblUserName.text != "" && lblConfirmPassword.text != ""{
           // signUpButton.isEnabled = true
          //  signUpButton.isOpaque = false
            print("Hola")
        }else{
          //  signUpButton.isEnabled = false
          //  signUpButton.isOpaque = true
            print("Hola2")
        }
    }
    
    
    

    @IBAction func signUpButtonTapped(_ sender: Any) {
    
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseInOut, .autoreverse], animations:{
            self.signUpButton.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.signUpButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
        },
                       completion: nil
        )
        
        if lblPassword.text ==
            lblConfirmPassword.text{
            Auth.auth().createUser(withEmail: lblEmail.text!, password: lblPassword.text!) { (authResult, error) in
                guard (authResult?.user) != nil else { return }
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.lblUserName.text
                changeRequest?.commitChanges { error in
                    if error == nil {
                        //Alert
                        print("User display name changed!")
                        saveProfile(userName: self.lblUserName.text!,userEmail:self.lblEmail.text!) { success in
                            if success {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                    
                
                //Alert
                self.lblEmail.text = ""
                self.lblUserName.text = ""
                self.lblPassword.text = ""
                self.lblConfirmPassword.text = ""
            }
            
            
        }
        
        
    }
    
    func saveProfile(userName:String,userEmail:String, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
  
        let databaseRef = Database.database().reference().child("/")
        
        let userObject = [
            "email": userEmail,
            "username": userName
          
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }

    

}
}

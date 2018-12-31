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
     //   signUpButton.alpha = 0.5
     //   signUpButton.isEnabled = false
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
         //   signUpButton.alpha = 1
         //   signUpButton.isEnabled = true
            print("Hola")
        }else{
         //   signUpButton.alpha = 0.5
         //   signUpButton.isEnabled = false
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
        
        if lblPassword.text == lblConfirmPassword.text{
            Auth.auth().createUser(withEmail: lblEmail.text!, password: lblPassword.text!) { (authResult, error) in
                if error == nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.lblUserName.text
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            //Alert
                            saveProfile(userName: self.lblUserName.text!,userEmail:self.lblEmail.text!) { success in
                                if success {
                                    let alert = UIAlertController(title: "Congratulations", message: "You are Singed", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in  self.navigationController?.popToRootViewController(animated: true)}))
                                    self.present(alert, animated: true)
                                    
                                }

                            }
                        } else {
                            let alert = UIAlertController(title: "Error", message: "Your datas are incorrects", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        }
                    }
                } //"FIRAuthErrorDomain"
            
            
        }
        
        
    }
    
    func saveProfile(userName:String,userEmail:String, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
  
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "email": userEmail,
            "username": userName,
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
        completion(error == nil)
        }
    }

    

}
}

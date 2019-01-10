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
    @IBOutlet weak var subHeading: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblUserName: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblConfirmPassword: UITextField!
    @IBOutlet weak var meetImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Login button aspects
        signUpButton.layer.cornerRadius = 8.0
        signUpButton.layer.masksToBounds = true
        signUpButton.isUserInteractionEnabled = false
        signUpButton.alpha = 0.5
        meetImage.alpha = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        meetImage.center.x -= view.bounds.width
    }
    
    //Settings after the view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.meetImage.alpha = 1.0
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
        UIView.animate(withDuration: 1.5, delay: 0.3, options: [], animations:{
           self.meetImage.center.x += self.view.bounds.width
        },
                       completion: nil
        )
    }
    
    //Button's Behaviour
    
    @IBAction func emailChanged(_ sender: UITextField) {
        if(lblUserName.text?.isEmpty == false) && (lblPassword.text?.isEmpty == false) && (lblConfirmPassword.text?.isEmpty == false){
            if sender.text?.isEmpty == true{
                buttonDisabled()
            }else{
                buttonEnabled()
            }
        }
    }
    
    @IBAction func usernameChanged(_ sender: UITextField) {
        if(lblEmail.text?.isEmpty == false) && (lblPassword.text?.isEmpty == false) && (lblConfirmPassword.text?.isEmpty == false){
            if sender.text?.isEmpty == true{
                buttonDisabled()
            }else{
                buttonEnabled()
            }
        }
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        if(lblEmail.text?.isEmpty == false) && (lblUserName.text?.isEmpty == false) && (lblConfirmPassword.text?.isEmpty == false){
            if sender.text?.isEmpty == true{
                buttonDisabled()
            }else{
                buttonEnabled()
            }
        }
    }
    
    @IBAction func confirmationChanged(_ sender: UITextField) {
        if(lblEmail.text?.isEmpty == false) && (lblUserName.text?.isEmpty == false) && (lblPassword.text?.isEmpty == false){
            if sender.text?.isEmpty == true{
                buttonDisabled()
            }else{
                buttonEnabled()
            }
        }
    }
    
    func buttonDisabled(){
        signUpButton.isUserInteractionEnabled = false
        signUpButton.alpha = 0.5
    }
    
    func buttonEnabled(){
        signUpButton.isUserInteractionEnabled = true
        signUpButton.alpha = 1.0
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
                } else {
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .emailAlreadyInUse:
                            let alert = UIAlertController(title: "Error", message: "Your email is In Use", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        case .invalidEmail:
                            let alert = UIAlertController(title: "Error", message: "Your format email is incorrect", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        case .userDisabled:
                            let alert = UIAlertController(title: "Error", message: "Your user has been disable \n Try contact us", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        case .wrongPassword:
                            let alert = UIAlertController(title: "Error", message: "Your datas are incorrects", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        case .weakPassword:
                            let alert = UIAlertController(title: "Error", message: "Your datas are incorrects", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        case .userNotFound:
                            let alert = UIAlertController(title: "Error", message: "Your datas are incorrects", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        case .networkError:
                            let alert = UIAlertController(title: "Error", message: "You are not connect on Internet", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        default:
                            let alert = UIAlertController(title: "Error", message: "You have a error \n Try Try contact us", preferredStyle: .alert )
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
                            self.present(alert, animated: true)
                        }
                    }
                    
                }
                
            
            
        }
        
        
        }else{
            let alert = UIAlertController(title: "Error", message: "Your passwords are not equals", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:nil))
            self.present(alert, animated: true)
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

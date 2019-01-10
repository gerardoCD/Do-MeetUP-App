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
    @IBOutlet weak var treeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Login button aspects
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        loginButton.isUserInteractionEnabled = false
        loginButton.alpha = 0.5
        treeImage.alpha = 0.0
    }
    
    //Settings after the view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0){
            self.heading.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.heading.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        UIView.animate(withDuration: 5.0){
            self.treeImage.alpha = 1.0
        }
    }
    
    @IBAction func emailChanged(_ sender: UITextField) {
        if(txtPassword.text?.isEmpty == false){
            if sender.text?.isEmpty == true{
                buttonDisabled()
            }else{
                buttonEnabled()
            }
        }
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        if(txtEmail.text?.isEmpty == false){
            if sender.text?.isEmpty == true{
                buttonDisabled()
            }else{
                buttonEnabled()
            }
        }
    }
    
    func buttonDisabled(){
        loginButton.isUserInteractionEnabled = false
        loginButton.alpha = 0.5
    }
    
    func buttonEnabled(){
        loginButton.isUserInteractionEnabled = true
        loginButton.alpha = 1.0
    }
    
    
    //The button was tapped 
    @IBAction func signInTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseInOut, .autoreverse], animations:{
            self.peopleImage.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.peopleImage.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
        },
                       completion: nil
        )
        
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
            if user != nil {
                // Pasa ventana
                //alerta "©
                let alert = UIAlertController(title: "Congratulations", message: "You are logged", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in  self.navigationController?.popToRootViewController(animated: true)}))
                self.present(alert, animated: true)
                
            
            }else{
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
        
       
    }
    
    
    


}

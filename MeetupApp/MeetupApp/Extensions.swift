//
//  Extensions.swift
//  MeetupApp
//
//  Created by Gerardo Castillo Duran  on 1/21/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import Foundation
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

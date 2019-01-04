//
//  CreateEventViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 1/3/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    
    @IBOutlet weak var createButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.layer.cornerRadius = 8.0
        createButton.layer.masksToBounds = true
    }
    
    
}

//
//  DataViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 1/5/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    var dataObject: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleLabel!.text = dataObject
    }

}

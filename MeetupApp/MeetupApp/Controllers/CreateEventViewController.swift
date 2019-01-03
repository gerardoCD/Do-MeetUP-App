//
//  CreateEventViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 1/3/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    // A delay function
    func delay(_ seconds: Double, completion: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    @IBOutlet weak var headImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headImage.center.x -= self.view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.0){
            self.headImage.center.x =  +self.headImage.bounds.width/1.65
        }
    }

}

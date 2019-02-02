//
//  TicketTableViewCell.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 1/4/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import UIKit

class TicketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

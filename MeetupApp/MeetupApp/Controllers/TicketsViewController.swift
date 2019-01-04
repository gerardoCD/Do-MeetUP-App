//
//  TicketsViewController.swift
//  MeetupApp
//
//  Created by Gerardo Castillo Duran  on 1/3/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import UIKit

class TicketsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var events2 = [Event]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadDatas()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TicketTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TicketTableViewCell else{
            fatalError("The dequeued cell is not an instance of TicketTableViewCell.")
        }
        return cell
    }


    
//    func loadDatas(){
//        Ticket.loadTickets { (events) in
//            self.events2 = events
//        }
//
//    }

}

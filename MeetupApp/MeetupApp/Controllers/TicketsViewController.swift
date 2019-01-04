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
        loadDatas()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadDatas()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TicketTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TicketTableViewCell else{
            fatalError("The dequeued cell is not an instance of TicketTableViewCell.")
        }
        cell.eventTitle.text = events2[indexPath.row].name
        cell.eventImage.image = events2[indexPath.row].photo
        cell.dateTitle.text = events2[indexPath.row].startDate
        
        return cell
    }


    
    func loadDatas(){
        Ticket.loadTickets { (events) in
            print(events)
            self.events2 = events
            self.tableView.reloadData()
        }

    }

}

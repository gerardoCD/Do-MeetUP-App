//
//  TicketsViewController.swift
//  MeetupApp
//
//  Created by Gerardo Castillo Duran  on 1/3/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import UIKit

class TicketsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var events2 = [Event]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "EventTicket", for: indexPath)
        
        cell.textLabel?.text = "Hola"
     
        return cell
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatas()
        // Do any additional setup after loading the view.
    }

    
    func loadDatas(){
        Ticket.loadTickets { (events) in
            self.events2 = events
        }
        
    }

}

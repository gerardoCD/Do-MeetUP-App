//
//  PageTicketViewController.swift
//  MeetupApp
//
//  Created by Abraham Quezada on 1/5/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import UIKit


class PageTicketViewController: UIViewController {
    
    var pageTicketViewController: UIPageViewController?
    var pages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.pageTicketViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        
        let viewControllers = [startingViewController]
        
        self.pageTicketViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in})
        
        self.pageTicketViewController?.dataSource = self.modelController
        
        self.addChild(self.pageTicketViewController!)
        self.view.addSubview(self.pageTicketViewController!.view)
        self.pageTicketViewController!.view.frame = self.view.frame
        self.pageTicketViewController!.didMove(toParent: self)
        
        let modelController = ModelController()
        modelController.pageData = pages
        
    }
    
    lazy var modelController = ModelController()
    


}

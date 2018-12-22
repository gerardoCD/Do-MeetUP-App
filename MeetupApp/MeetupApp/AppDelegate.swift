//
//  AppDelegate.swift
//  MeetupApp
//
//  Created by Gerardo on 11/26/18.
//  Copyright © 2018 Gerardo. All rights reserved.
//

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let blueSplash = UIColor(red: 0x09, green: 0x09, blue: 0x3B, alpha: 1)
    let screen = UIScreen.main.bounds
    var event: Event?
    var eve = EventsViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        self.splashScreen()
        eve.loadEventInfo()
        return true
    }
    
    //LaunchScreen
    private func splashScreen(){
        let launchScreenVC = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        let rootVC = launchScreenVC.instantiateViewController(withIdentifier: "splashController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(dismissSplashController), userInfo: nil, repeats: false)
        
        // logo mask
        rootVC.view.layer.mask = CALayer()
        rootVC.view.layer.mask?.backgroundColor = blueSplash.cgColor
        let screenWidth = screen.size.width
        let screenHeight = screen.size.height
        rootVC.view.layer.mask?.bounds = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        rootVC.view.layer.mask?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rootVC.view.layer.mask?.position = CGPoint(x: rootVC.view.frame.width / 2, y: rootVC.view.frame.height / 2)
        
        // logo mask background view
        let maskBgView = UIView(frame: rootVC.view.frame)
        rootVC.view.addSubview(maskBgView)
        rootVC.view.bringSubviewToFront(maskBgView)
        // logo mask background view animation
        UIView.animate(withDuration: 1.5,
                       delay: 0.35,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                        maskBgView.alpha = 0.5
        },
                       completion: { finished in
                        maskBgView.removeFromSuperview()
        })
        
        // root view animation
        UIView.animate(withDuration: 2.5,
                       delay: 1.0,
                       options: [],
                       animations: {
                        self.window!.rootViewController!.view.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        },
                       completion: { finished in
                        UIView.animate(withDuration: 0.3,
                                       delay: 0.0,
                                       options: UIView.AnimationOptions.curveEaseInOut,
                                       animations: {
                                        self.window!.rootViewController!.view.transform = .identity
                        },
                                       completion: nil)
        })
        
    }
    
    @objc func dismissSplashController(){
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil)
        let rootVC = mainVC.instantiateViewController(withIdentifier: "initController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


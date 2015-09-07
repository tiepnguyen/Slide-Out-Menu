//
//  AppDelegate.swift
//  SlideOutMenu
//
//  Created by Tiep Nguyen on 12/18/14.
//  Copyright (c) 2014 Tiep Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var status: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = ContainerViewController()
        window!.makeKeyAndVisible()

        status = UIWindow(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 20))
        status!.backgroundColor = UIColorFromHex(0xF8F8F8, alpha: 1)
//        status!.rootViewController = StatusViewController()
        status!.windowLevel = UIWindowLevelStatusBar
        
        let label = UILabel(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 20))
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(13)
        label.text = "Offline"
        status!.addSubview(label)

        return true
    }
    
    func flashStatus() {
        status?.alpha = 0.0
        status?.hidden = false
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.status?.alpha = 1.0
            return
        }) { (complete) -> Void in
            self.delay(2.0, closure: { () -> () in
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.status?.alpha = 0.0
                    return
                }, completion: { (complete) -> Void in
                    self.status?.hidden = true
                    return
                })
            })
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


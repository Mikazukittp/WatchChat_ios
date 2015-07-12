//
//  AppDelegate.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/12.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var userName = def?.objectForKey("userName") as? String

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let win = window {
            win.opaque = true
            
            var vc: UIViewController
            if (userName?.isEmpty == nil) {
                vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
            }else {
                vc = ChangeViewController(nibName: "ChangeViewController", bundle: nil)
            }
            
            var nc = UINavigationController(rootViewController: vc)
            win.rootViewController = nc
            win.backgroundColor = UIColor.whiteColor()
            win.makeKeyAndVisible()
            
            UINavigationBar.appearance().barTintColor = UIColor(red: 0.251, green: 0.773, blue: 0.000, alpha: 1.0)
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        }
        return true
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

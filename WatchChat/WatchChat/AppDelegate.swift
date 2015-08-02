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
        var myId = def?.objectForKey("myId") as? Int
        
        let fetcher =  DetailFriendFetcher()
        fetcher.myFriend()
        

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let win = window {
            win.opaque = true
            
            var vc: UIViewController
            if (myId == nil) {
                vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
            }else {
                vc = ChatViewController()
            }
            
            var barButton = UIBarButtonItem()
            barButton.title = ""
            vc.navigationItem.backBarButtonItem = barButton
            
            var nc = UINavigationController(rootViewController: vc)
            win.rootViewController = nc
            win.backgroundColor = UIColor.whiteColor()
            win.makeKeyAndVisible()
            
            UINavigationBar.appearance().barTintColor = UIColor(red: 0.251, green: 0.773, blue: 0.000, alpha: 1.0)
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        }
        
        var types: UIUserNotificationType = UIUserNotificationType.Badge |
            UIUserNotificationType.Alert |
            UIUserNotificationType.Sound
        
        var settings: UIUserNotificationSettings = UIUserNotificationSettings( forTypes: types, categories: nil )
        
        application.registerUserNotificationSettings( settings )
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application( application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData ) {
        
        var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        var deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var myId = def?.objectForKey("deviceToken") as? Int
        def?.setObject("9ff133a577a977a0b6feae1d127329baa1fc48c36dd97831b5c2158c74e5e699", forKey: "deviceToken")
    
        println( deviceTokenString )
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
    }
    
    
    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        
    }
    
//    func application(application: UIApplication!, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]!, reply: (([NSObject : AnyObject]!) -> Void)!) {
//
//
//        var appDel = UIApplication.sharedApplication().delegate as AppDelegate
//        var vc:ViewController? = appDel.window?.rootViewController as? ViewController
//        vc?.ulabel.text = counterValue
//        
//        reply(["fromApp":"AppDelegate"])
//        
//    }

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


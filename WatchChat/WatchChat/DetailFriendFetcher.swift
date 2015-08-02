//
//  DetailFriendFetcher.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/17.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class DetailFriendFetcher: BaseFetcher {
   
    
    func myFriend () {
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var myid = def?.objectForKey("myId") as? Int

        if myid == nil {
            return
        }
        
        var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "/users/" + String(myid!) + "/opponent")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "GET"
        
        
        self.sendAsynchronousByUrl(request) { (items) -> Void in

            let dict = items as? NSDictionary
            
            if let userId = dict!.objectForKey("id") as? Int {
                if let userName = dict!.objectForKey("name") as? String{
                    def?.setObject(userId, forKey: "userId")
                    def?.setObject(userName, forKey: "userName")
                }
            }            
        }
    }

    
    func message (completion:(array :NSArray)->Void) {
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var myid = def?.objectForKey("myId") as? Int
        
        if myid == nil {
            return
        }

        var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "/messages" + "?sender_id=" + String(myid!) )!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "GET"
        
        self.sendAsynchronousByUrl(request) { (items) -> Void in

            let array = items as? NSArray
            println(array!)
            completion(array: array!)
        }
    }
    
}

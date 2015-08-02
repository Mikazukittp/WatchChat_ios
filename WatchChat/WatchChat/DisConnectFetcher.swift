//
//  disConnectFetcher.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/16.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class DisConnectFetcher: BaseFetcher {
    
    func deleteUser (completion:()->Void) {
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var myid = def?.objectForKey("myId") as? Int
        
        var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "/connections/" + String(myid!))!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "DELETE"
        println(Const.urlDomain + "/connections")
        
        self.sendAsynchronousByUrl(request) { (items) -> Void in
            
            let dict = items as? NSDictionary
            println(dict)

//            if let userId = json.objectForKey("id") as? String {
//                if let userName = json.objectForKey("name") as? String{
//                    def?.setObject(userId, forKey: "userId")
//                    def?.setObject(userName, forKey: "userName")
//                    completion(userName: userName, userId: userId)
//                }
//            }
            
            completion()
        }

    }

}

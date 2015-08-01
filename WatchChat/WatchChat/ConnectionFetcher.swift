//
//  ConnectionFetcher.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/15.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class ConnectionFetcher: BaseFetcher {

    func connect (completion:(userName :String,userId :Int)->Void) {
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var myid = def?.objectForKey("myId") as? Int
        
        if myid == nil {
            return
        }
        
        var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "/connections")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        
        var postString:String = "id=\(myid!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        self.sendAsynchronousByUrl(request) { (items) -> Void in
            
            let dict = items as? NSDictionary
            var categories = [Category]()
            
            
            if let userId = dict!.objectForKey("id") as? Int {
                if let userName = dict!.objectForKey("name") as? String{
                    def?.setObject(userId, forKey: "userId")
                    def?.setObject(userName, forKey: "userName")
                    completion(userName: userName, userId: userId)
                }
            }
        }
    }

    
}

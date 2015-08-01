//
//  RegistFetcher.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/15.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class RegistFetcher: BaseFetcher {
    
    func regist (name :String, completion:(userId :Int)->Void) {
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var deviceToken = def?.objectForKey("deviceToken") as? String!
                
        var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "/users")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        
        var postString:String = "gcm_id=\(deviceToken)&name=\(name)&device_type=ios"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        self.sendAsynchronousByUrl(request) { (items) -> Void in

            let dict = items as? NSDictionary
            println(dict)
            let def = NSUserDefaults(suiteName: Const.appGroupId)
            let myId = (dict!.objectForKey("id") as? Int)!
            def?.setObject(myId, forKey: "myId")
            completion(userId: myId)
  
        }
    }

}

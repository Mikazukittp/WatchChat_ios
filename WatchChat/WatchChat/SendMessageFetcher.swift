//
//  SendMessageFetcher.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/13.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class SendMessageFetcher: BaseFetcher {
   
    func sendMessage (name:String, completion:(item :NSDictionary)->Void) {
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var myId = def?.objectForKey("myId") as? Int
        
        var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "/messages")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        
        var postString:String = "sender_id=\(myId!)&content=\(name)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)

        self.sendAsynchronousByUrl(request) { (items) -> Void in
            
            let dict = items as? NSDictionary
            println(dict)
            completion(item: dict!)
        }
    }

}

//
//  BaseFetcher.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/08/01.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class BaseFetcher: NSObject {
 
    func sendAsynchronousByUrl(request :NSURLRequest ,completion:(items :AnyObject)->Void) {
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                println(error)
            } else {
                let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions.AllowFragments, error: nil)!
                println(json)
                completion(items: json)
            }
        })
        
        dataTask.resume()
    }

}

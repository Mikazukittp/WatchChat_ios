//
//  Chat.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/13.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class Chat: NSObject, NSCoding{
  
    var name:String!
    var message:String!
    var userId:Int!
    
    override init() {
        super.init()
    }
    
    init(name: String, message: String, userId: Int)  {
        super.init()
        self.message = message
        self.name = name
        self.userId = userId
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.message, forKey: "message")
        aCoder.encodeObject(self.userId, forKey: "userId")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.message = aDecoder.decodeObjectForKey("message") as? String
        self.userId = aDecoder.decodeObjectForKey("userId") as? Int
    }
}

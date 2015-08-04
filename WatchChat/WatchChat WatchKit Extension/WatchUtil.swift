//
//  WatchUtil.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/14.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class WatchUtil: NSObject {

    func chats (completion:(items :[Chat])->Void){
        
        var items :[Chat] = self.chatItems(completion)
    }
    
    private func chatItems (completion:(items :[Chat])->Void) -> Array<Chat> {
        var items: [Chat] = []
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        
        let fetcher = DetailFriendFetcher()
        fetcher.message({(array :NSArray) -> Void in
            
            for dict in array {
                
                var nsDict = (dict as? NSDictionary)!
                var userId = nsDict.objectForKey("opponent_id") as? Int!
                var content = nsDict.objectForKey("content") as? String!
                var item:Chat = Chat()
                item.userId = userId
                item.name = ""
                item.message = content
                println(item.message)
                items.append(item)
            }
            completion(items: items)
        })

        return items
    }
    
    
    func addItem (item :Chat, completion:()->Void) {
        
        var fetcher = SendMessageFetcher()
        
        fetcher.sendMessage(item.message, completion: {(item) -> Void in
            println("sucucess")
            println(item)
            completion()
        })
    }
    
}


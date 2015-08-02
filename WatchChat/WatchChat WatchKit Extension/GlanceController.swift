//
//  GlanceController.swift
//  WatchChat WatchKit Extension
//
//  Created by 石部達也 on 2015/07/12.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    var myId :Int!
    
    @IBOutlet weak var messageText: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.loadData()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func loadData () {
        
        WatchUtil().chats({ (items) -> Void in
            
           let entity :Chat = items[0];

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.messageText.setText(entity.message)
            })
        })
        
    }

}

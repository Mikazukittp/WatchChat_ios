//
//  RowController.swift
//  watchOS2Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/10.
//  Copyright © 2015年 Shuichi Tsutsumi. All rights reserved.
//

import WatchKit


class RowController: NSObject {

    @IBOutlet weak var friendText: WKInterfaceLabel!
    @IBOutlet weak var myText: WKInterfaceLabel!
    @IBOutlet weak var friendMessage: WKInterfaceGroup!
    @IBOutlet weak var myMessage: WKInterfaceGroup!
    @IBOutlet weak var group: WKInterfaceGroup!
    
    func showItem(myId:Int, item: Chat) {
        
        if item.userId != myId {
            self.friendMessage.setHidden(true)
            self.myMessage.setHidden(false)
            self.myText.setText(item.message!)
        } else {
            self.friendMessage.setHidden(false)
            self.myMessage.setHidden(true)
            self.friendText.setText(item.message!)
        }
        
    }
}

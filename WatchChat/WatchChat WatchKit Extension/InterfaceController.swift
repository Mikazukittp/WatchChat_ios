//
//  InterfaceController.swift
//  WatchChat WatchKit Extension
//
//  Created by 石部達也 on 2015/07/12.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var myText: WKInterfaceLabel!
    @IBOutlet weak var table: WKInterfaceTable!
    
    var items: [Chat] = []
    var myName: String = ""
    var myId :Int!
    var opponentId :Int!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        myName = "tatsuya"
            //def?.objectForKey("myName") as! String
        myId = 43
            //= def?.objectForKey("myId") as? Int!
        opponentId = 46
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
    

    @IBAction func inputTapped() {
        
        self.presentTextInputControllerWithSuggestions(nil, allowedInputMode: WKTextInputMode.Plain, completion:  {(result: [AnyObject]!) -> Void in println(result)

            if result.count > 0 {

                var item:Chat = Chat()
                item.name = self.myName
                item.message = result[0] as? String
                item.userId = self.opponentId

                WatchUtil().addItem(item ,items :self.items)
                self.addItems(item)
            }
        })
    }
    
    private func loadData () {
        
        WatchUtil().chats({ (items) -> Void in
          
            self.items  = items
            self.table.setNumberOfRows(items.count, withRowType: "Cell")
            self.loadTableData()
        })
    }
    
    private func loadTableData() {
        
        var i=0
        for anItem in self.items {
            let row = self.table.rowControllerAtIndex(i) as! RowController
            row.group.setBackgroundColor(UIColor.clearColor())
            row.showItem(self.myId, item: anItem)
            i++
        }
    }
    
    private func addItems (item: Chat) {
        self.items.append(item)
        self.table.insertRowsAtIndexes(NSIndexSet(index: 0), withRowType: "Cell")
        
        self.loadTableData()
    }
}

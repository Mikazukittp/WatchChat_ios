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
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func inputTapped() {
        
        self.presentTextInputControllerWithSuggestions(nil, allowedInputMode: WKTextInputMode.Plain, completion:  {(result: [AnyObject]!) -> Void in println(result)
            if result.count > 0 {
                self.myText.setText("\(result[0])")
            }
        })
        
//        [self presentTextInputControllerWithSuggestions:nil allowedInputMode:WKTextInputModePlain completion:^(NSArray *array){
//            
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            if (array.count > 0) {
//            [dict setObject:[array objectAtIndex:0] forKey:kAppGroupMemoKey];
//            
//            //AppdelegateのhandleWatchKitExtensionRequestを呼ぶ
//            [WKUserNotificationInterfaceController openParentApplication:dict reply:nil];
//            
//            NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
//            
//            WMWatchMemo *entity = [[WMWatchMemo alloc]init];
//            entity.body = [array objectAtIndex:0];
//            entity.startDate = nowDate;
//            
//            [_elementsList insertObject:entity atIndex:0];
//            
//            [self loadTableRows];
//            }
//            }];

        
    }
}

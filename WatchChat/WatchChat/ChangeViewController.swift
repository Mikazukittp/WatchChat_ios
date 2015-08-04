//
//  ChangeViewController.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/12.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {

    @IBOutlet weak var matchUserName: UILabel!
    @IBOutlet weak var fetchButton: UIButton!
    
    var userId :Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Naviagationbar潜り込み防止
        self.edgesForExtendedLayout = UIRectEdge.None
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var myName = def?.objectForKey("myName") as? String

        self.title = myName! + "さんのステータス"
    }
    
    override func viewWillAppear(animated: Bool) {
                
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        self.userId = def?.objectForKey("userId") as? Int
        
        if let matchUser = def?.objectForKey("userName") as? String {
            self.matchUserName.text = matchUser
            self.matchUserName.sizeToFit();
            self.fetchButton.setTitle("友達をやめる", forState: UIControlState.Normal)
            self.fetchButton.titleLabel?.sizeToFit()
        }else {
            self.matchUserName.text = "-"
            self.matchUserName.sizeToFit();
            self.fetchButton.setTitle("友達を探す", forState: UIControlState.Normal)
            self.fetchButton.titleLabel?.sizeToFit()
        }
        
    }

    @IBAction func connnectButtonTapped(sender: AnyObject) {
   
        if (self.userId == nil) {
            
            let fetcher = ConnectionFetcher()
            
            fetcher.connect({ (userName :String, userId :Int) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.userId = userId
                    self.matchUserName.text = userName
                    self.fetchButton.setTitle("友達をやめる", forState: UIControlState.Normal)
                    self.fetchButton.titleLabel?.sizeToFit()
                })
            })
        }else {
            
            let fetcher = DisConnectFetcher()
            
            fetcher.deleteUser({() -> Void in
                let def = NSUserDefaults(suiteName: Const.appGroupId)

                def?.removeObjectForKey("userName")
                def?.removeObjectForKey("userId")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.userId = nil
                    self.matchUserName.text = "-"
                    self.fetchButton.setTitle("友達を探す", forState: UIControlState.Normal)
                    })
            })
        }
    }
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Naviagationbar潜り込み防止
        self.edgesForExtendedLayout = UIRectEdge.None
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        var userName = def?.objectForKey("userName") as? String

        self.title = userName! + "さんのステータス"
        
    }

}

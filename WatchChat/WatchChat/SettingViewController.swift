//
//  SettingViewController.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/12.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setButton()
    }

    @IBAction func settingButtonTapped(sender: AnyObject) {
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        def?.setObject(self.userName.text, forKey: "userName")
        
        
    }
    
    private func setButton () {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, userName.frame.size.height - 1, userName.frame.size.width, 1.0);
        bottomBorder.backgroundColor = UIColor.grayColor().CGColor
        userName.layer.addSublayer(bottomBorder)
    }

}

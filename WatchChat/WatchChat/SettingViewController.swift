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

        self.title = "WatchChat"
        
        self.setButton()
    }

    @IBAction func settingButtonTapped(sender: AnyObject) {
        
        if  userName.text.isEmpty {
            userName.attributedPlaceholder = NSAttributedString(string:"名前を入力してください",
                attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
            return
        }
        
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        def?.setObject(self.userName.text, forKey: "userName")
        
        var pc = ChangeViewController(nibName: "ChangeViewController", bundle: nil)

        self.navigationController?.pushViewController(pc, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)        
    }
    
    private func setButton () {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, userName.frame.size.height - 1, userName.frame.size.width, 1.0);
        bottomBorder.backgroundColor = UIColor.grayColor().CGColor
        userName.layer.addSublayer(bottomBorder)
    }

}

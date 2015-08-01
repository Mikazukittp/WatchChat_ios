//
//  SettingViewController.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/07/12.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!
    
    var userId :Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "WatchChat"
        
        self.setButton()
        userName.delegate = self
}

    @IBAction func settingButtonTapped(sender: AnyObject) {
        
        if  userName.text.isEmpty {
            userName.attributedPlaceholder = NSAttributedString(string:"名前を入力してください",
                attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
            return
        }
        
        if userId != nil {
            var pc = ChangeViewController(nibName: "ChangeViewController", bundle: nil)
            self.navigationController?.pushViewController(pc, animated: true)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            return
        }
        
        var fetcher = RegistFetcher()
        fetcher.regist(self.userName.text, completion:{(userId :Int) in

            let def = NSUserDefaults(suiteName: Const.appGroupId)
            def?.setObject(self.userName.text, forKey: "myName")

            self.userId = userId
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var pc = ChangeViewController(nibName: "ChangeViewController", bundle: nil)
                self.navigationController?.pushViewController(pc, animated: true)
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            })
        })
    }
    
    private func setButton () {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, userName.frame.size.height - 1, userName.frame.size.width, 1.0);
        bottomBorder.backgroundColor = UIColor.grayColor().CGColor
        userName.layer.addSublayer(bottomBorder)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // 文字数最大を決める.
        let maxLength: Int = 11
        
        // 入力済みの文字と入力された文字を合わせて取得.
        var str = textField.text + string
        
        // 文字数がmaxLength以下ならtrueを返す.
        if count("\(str)") < maxLength {
            return true
        }
        userName.text = ""
        userName.attributedPlaceholder = NSAttributedString(string:"10文字を超えています。",
            attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        println("10文字を超えています")
        return false
    }

}

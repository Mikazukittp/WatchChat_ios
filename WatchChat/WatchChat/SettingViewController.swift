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
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var userId :Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "WatchChat"
        
        self.indicatorView.hidden = true
                
        self.setButton()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"textFieldDidChange:", name: UITextFieldTextDidChangeNotification, object: nil)

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
        
        if userName.markedTextRange != nil {
            return;
        }
        
        var fetcher = RegistFetcher()
        
        self.indicatorView.hidden = false
        self.indicatorView.startAnimating()
        fetcher.regist(self.userName.text, completion:{(userId :Int) in

            let def = NSUserDefaults(suiteName: Const.appGroupId)
            def?.setObject(self.userName.text, forKey: "myName")

            self.userId = userId
            self.indicatorView.stopAnimating()
            self.indicatorView.hidden = true

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var pc = ChatViewController()
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
    
    func textFieldDidChange(notification:NSNotification){
        
        //ここで文字数を取得して、いい感じに処理します。
        let length = count(userName.text.utf16)
        
        let maxLength: Int = 8

        if (length > maxLength) {
            userName.text = ""
            userName.attributedPlaceholder = NSAttributedString(string:"10文字を超えています。",
                attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
            println("8文字を超えています")
            
            return;
        }
    }
}

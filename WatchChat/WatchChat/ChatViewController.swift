//
//  ChatViewController.swift
//  WatchChat
//
//  Created by 石部達也 on 2015/08/01.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class ChatViewController: JSQMessagesViewController {

    var myName = ""
    var myId = 0
    var opponentId :Int?
    var opponentUserName :String?
    
    var messages = [JSQMessage]()
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor(red: 0.251, green: 0.773, blue: 0.0, alpha: 1.0))
        
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor(red: 0.0, green: 0.676, blue: 1.0, alpha: 1.0))
    
    let incomingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "myUser"), diameter: 64)
    let outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "opponentUser"), diameter: 64)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

        let def = NSUserDefaults(suiteName: Const.appGroupId)
        self.myName = def?.objectForKey("myName") as! String
        self.myId = (def?.objectForKey("myId") as? Int!)!
        
        self.inputToolbar.contentView.leftBarButtonItem = nil
        self.senderDisplayName = self.myName
        
        self.setCustomButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        let def = NSUserDefaults(suiteName: Const.appGroupId)
        self.opponentId = def?.objectForKey("userId") as? Int
        self.opponentUserName = def?.objectForKey("userName") as? String
        
        if (self.opponentId != nil && self.opponentUserName != nil) {
            self.senderId = String(self.opponentId!)
            
            self.title = self.opponentUserName! + "さんとの会話"
            self.messages.removeAll()
            self.loadData()
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        var data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        var data = self.messages[indexPath.row]
        if (data.senderId == self.senderId) {
            return self.outgoingBubble
        } else {
            return self.incomingBubble
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        var data = self.messages[indexPath.row]

        if (data.senderId == self.senderId) {
            return self.outgoingAvatar
        } else {
            return self.incomingAvatar
        }

    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count;
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        var newMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text);
        
        var item:Chat = Chat()
        item.name = self.myName
        item.message = text
        item.userId = self.opponentId
       
        WatchUtil().addItem(item, completion: { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.messages += [newMessage]
                self.finishSendingMessage()
            })
        })
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
    }
    
    private func loadData () {
                
        WatchUtil().chats({ (items) -> Void in
            
            for item in items {
                var message = JSQMessage(senderId: String(item.userId), displayName: item.name, text: item.message)
                self.messages += [message]
 
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView.reloadData()

            })
        })
    }
    
    private func setCustomButton (){
        
        var customButton :UIButton = UIButton(frame: CGRectMake(0, 0, 20, 20))
        customButton.setBackgroundImage(UIImage(named: "Setting"), forState: UIControlState.Normal)
        customButton.addTarget(self, action:  Selector("settingButtonTapped"), forControlEvents: .TouchUpInside)
        var customButtonItem :UIBarButtonItem = UIBarButtonItem(customView: customButton)
        self.navigationItem.rightBarButtonItem = customButtonItem
        
    }
    
    func settingButtonTapped () {
        var pc = ChangeViewController(nibName: "ChangeViewController", bundle: nil)
        self.navigationController?.pushViewController(pc, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

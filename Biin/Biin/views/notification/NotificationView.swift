//  NotificationView.swift
//  biin
//  Created by Esteban Padilla on 3/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class NotificationView: BNView {
    
    
    var delegate:NotificationView_Delegate?
    //    var gift:BNGift?
    var image:BNUIImageView?
    var imageRequested = false
    
    var removeItButton:BNUIButton_Delete?
    var titleLbl:UILabel?
    var messageLbl:UILabel?
    var receivedLbl:UILabel?

    //weak var notification:BNNotification?
    
    var background:UIView?
    var showSwipe:UISwipeGestureRecognizer?
    var hideSwipe:UISwipeGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, notification:BNNotification?){
        
        self.init(frame: frame, father:father )
        
//        self.notification = notification
        self.model = notification
        
        var xpos:CGFloat = 5
        var ypos:CGFloat = 5
        var width:CGFloat = 1
        let height:CGFloat = 1
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.masksToBounds = true
        
        var decorationColor:UIColor?
        decorationColor = UIColor.bnRed()
        
//        var white:CGFloat = 0.0
//        var alpha:CGFloat = 0.0
//        _ = gift!.primaryColor!.getWhite(&white, alpha: &alpha)
//        
//        if white >= 0.95 {
//            print("Is white - \(gift!.name!)")
//            decorationColor = gift!.primaryColor
//        } else {
//            decorationColor = gift!.secondaryColor
//        }
        
        removeItButton = BNUIButton_Delete(frame: CGRectMake((frame.width - SharedUIManager.instance.notificationView_height), 0, SharedUIManager.instance.notificationView_height, SharedUIManager.instance.notificationView_height), iconColor: UIColor.whiteColor())
        removeItButton!.backgroundColor = UIColor.redColor()
        removeItButton!.icon!.position = CGPoint(x: ((SharedUIManager.instance.notificationView_height / 2) - 6), y: ((SharedUIManager.instance.notificationView_height / 2) - 6))
        removeItButton!.addTarget(self, action: #selector(self.removeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(removeItButton!)
        
        background = UIView(frame: frame)
        background!.backgroundColor = UIColor.whiteColor()
        self.addSubview(background!)
        
//        if (model as! BNGift).media!.count > 0 {
            image = BNUIImageView(frame: CGRectMake(xpos, ypos, SharedUIManager.instance.notificationView_imageSize, SharedUIManager.instance.notificationView_imageSize), color:UIColor.bnGrayLight())
            background!.addSubview(image!)
            image!.layer.cornerRadius = 3
            image!.layer.masksToBounds = true
            requestImage()
//        }
        
        xpos = (SharedUIManager.instance.notificationView_imageSize + 10)
        ypos = 5
        receivedLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: frame.width, height: height))
        receivedLbl!.text = notification!.receivedDate!.bnDisplayDateFormatt_by_Day().uppercaseString
        receivedLbl!.textColor = UIColor.bnGray()
        receivedLbl!.font = UIFont(name: "Lato-Regular", size: 10)
        receivedLbl!.textAlignment = NSTextAlignment.Left
        receivedLbl!.numberOfLines = 0
        receivedLbl!.sizeToFit()
        background!.addSubview(receivedLbl!)
        ypos += (receivedLbl!.frame.height)
        
        width = (frame.width - (xpos + 5))
        titleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height: height))
        titleLbl!.text = notification!.title!
        titleLbl!.textColor = decorationColor
        titleLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.notificationView_TitleSize)
        titleLbl!.textAlignment = NSTextAlignment.Left
        titleLbl!.numberOfLines = 1
        titleLbl!.sizeToFit()
        background!.addSubview(titleLbl!)
        
        ypos += (titleLbl!.frame.height)
        width = (frame.width - (xpos + 5))
        messageLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width:width, height: height))
        messageLbl!.text = notification!.text!
        messageLbl!.textColor = UIColor.bnGrayDark()
        messageLbl!.font = UIFont(name: "Lato-Regular", size: SharedUIManager.instance.notificationView_TextSize)
        messageLbl!.textAlignment = NSTextAlignment.Left
        messageLbl!.numberOfLines = 2
        messageLbl!.sizeToFit()
        background!.addSubview(messageLbl!)
        
        showSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.showRemoveBtn(_:)))
        showSwipe!.direction = UISwipeGestureRecognizerDirection.Left
        background!.addGestureRecognizer(showSwipe!)
        
        hideSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.hideRemoveBtn(_:)))
        hideSwipe!.direction = UISwipeGestureRecognizerDirection.Right
        hideSwipe!.enabled = false
        background!.addGestureRecognizer(hideSwipe!)
    }
    
    func showRemoveBtn(sender:UISwipeGestureRecognizer) {
        
        delegate!.hideOtherViewsOpen!(self)
        sender.enabled = false
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
                self.background?.frame.origin.x -= SharedUIManager.instance.notificationView_height
            }, completion: {(completed:Bool) -> Void in
                self.hideSwipe!.enabled = true
        })
    }
    
    
    func hideRemoveBtn(sender:UISwipeGestureRecognizer) {
        
        delegate!.removeFromOtherViewsOpen!(self)
        sender.enabled = false
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
                self.background?.frame.origin.x += SharedUIManager.instance.notificationView_height
            }, completion: {(completed:Bool) -> Void in
                self.showSwipe!.enabled = true
        })
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        
    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
        father!.setNextState(goto)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            
        }else{
            father!.updateUserControl(position)
        }
    }
    
    func requestImage(){
        
        if imageRequested { return }
        
        imageRequested = true
        
//        if (model as! BNGift).media!.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData("https://biinapp.blob.core.windows.net/dev-biinmedia/e7071cce-36c1-4511-aca7-3f2c59835834/ca17d10603e5-4e5d-bf20-65f1ccf20ede.jpeg", image: image)
//        } else {
//            image!.image =  UIImage(named: "noImage.jpg")
//            image!.showAfterDownload()
//        }
    }
    
    override func refresh() {
        
    }
    
    override func clean(){
        
        delegate = nil
        model = nil
        image?.removeFromSuperview()
        image = nil
        removeItButton?.removeFromSuperview()
        removeItButton = nil
        titleLbl!.removeFromSuperview()
        titleLbl = nil
        messageLbl!.removeFromSuperview()
        messageLbl = nil
        receivedLbl!.removeFromSuperview()
        receivedLbl = nil
    }
    
    func removeBtnAction(sender:UIButton){
        self.delegate!.resizeScrollOnRemoved!(self.model!.identifier!)
        BNAppSharedManager.instance.updateNotificationCounter()
    }
    
    func showAsRead(){
        titleLbl!.textColor = UIColor.bnGray()
        messageLbl!.textColor = UIColor.bnGray()
    }
    
}

@objc protocol NotificationView_Delegate:NSObjectProtocol {
    optional func resizeScrollOnRemoved(identifier:String)
    optional func hideOtherViewsOpen(view:NotificationView)
    optional func removeFromOtherViewsOpen(view:NotificationView)
}
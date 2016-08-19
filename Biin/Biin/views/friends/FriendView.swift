//  FriendView.swift
//  biin
//  Created by Esteban Padilla on 7/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class FriendView: BNView {
    
    var delegate:FriendView_Delegate?
    //    var gift:BNGift?
    var image:BNUIImageView?
    var imageRequested = false
    var imageUrl:String = ""
    
    var titleLbl:UILabel?
    
    var foreground:UIView?
    var background:UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, biinie:Biinie?){
        
        self.init(frame: frame, father:father )
        
        self.model = biinie
        var xpos:CGFloat = 5
        var ypos:CGFloat = 0
        var width:CGFloat = 1
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.masksToBounds = true
        
//        let organization = BNAppSharedManager.instance.dataManager.organizations[(model as! BNLoyalty).organizationIdentifier!]
        var decorationColor:UIColor?

        decorationColor = UIColor.appTextColor()

        ypos = 5
        
        background = UIView(frame: frame)
        background!.backgroundColor = UIColor.whiteColor()
        self.addSubview(background!)
        
        
        image = BNUIImageView(frame: CGRectMake(xpos, ypos, SharedUIManager.instance.friendView_imageSize, SharedUIManager.instance.friendView_imageSize), color:UIColor.bnGrayLight())
        background!.addSubview(image!)
        image!.layer.cornerRadius = 3
        image!.layer.masksToBounds = true
        image!.useCache = false
        self.imageUrl = biinie!.facebookAvatarUrl!
        requestImage()
    
        xpos = (SharedUIManager.instance.friendView_imageSize + 15)
        ypos = ((SharedUIManager.instance.friendView_height - SharedUIManager.instance.loyaltyWalletView_TitleSize) / 2 )
        width = (frame.width - (xpos + 5))
        
        titleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height:SharedUIManager.instance.loyaltyWalletView_TitleSize))
        titleLbl!.text = biinie!.biinName!
        titleLbl!.textColor = decorationColor
        titleLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.loyaltyWalletView_TitleSize)
        titleLbl!.textAlignment = NSTextAlignment.Left
        background!.addSubview(titleLbl!)
        
        foreground = UIView(frame: frame)
        foreground!.backgroundColor = UIColor.blackColor()
        foreground!.alpha = 0
        foreground!.resignFirstResponder()
        self.addSubview(foreground!)

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func handleTap(sender:UITapGestureRecognizer) {
        self.foreground!.alpha = 0.1
        
        UIView.animateWithDuration(0.1, animations: {()-> Void in
                self.foreground!.alpha = 0
            }, completion: {(completed:Bool) ->  Void in
                
                self.delegate!.showAlertView_ToShareGift!()
                
                //if (self.model as! BNLoyalty).loyaltyCard!.isBiinieEnrolled {
                    //self.delegate!.showLoyaltyCard!(self)
                //} else {
                    //self.delegate!.showAlertView_ForLoyaltyCard!(self, loyalty:(self.model as! BNLoyalty))
                //}
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
        
        if imageUrl != "" {
            BNAppSharedManager.instance.networkManager.requestImageData(imageUrl, image: image)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
    }
    
    override func refresh() {
        
    }
    
    override func clean(){
        delegate = nil
        model = nil
        image?.removeFromSuperview()
        image = nil
        titleLbl!.removeFromSuperview()
        titleLbl = nil
        foreground!.removeFromSuperview()
        background!.removeFromSuperview()
    }
    
    func removeBtnAction(sender:UIButton){
//        self.delegate!.resizeScrollOnRemoved!(self)
    }
    
}

@objc protocol FriendView_Delegate:NSObjectProtocol {
//    optional func showLoyaltyCard(view:LoyaltyView)
    optional func showAlertView_ToShareGift()
//    optional func resizeScrollOnRemoved(view:LoyaltyView)
//    optional func hideOtherViewsOpen(view:LoyaltyView)
//    optional func removeFromOtherViewsOpen(view:LoyaltyView)
}

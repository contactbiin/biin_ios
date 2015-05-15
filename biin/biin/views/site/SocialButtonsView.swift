//  SocialButtonsView.swift
//  biin
//  Created by Esteban Padilla on 1/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SocialButtonsView:BNView {
    
    var biinBtn:BNUIButton_Social?
    var commentBtn:BNUIButton_Social?
    //var shareBtn:BNUIButton_Social?
    var showShareButton = false
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?, showShareButton:Bool){
        self.init(frame: frame, father:father )
        
        //Social buttons
        var xSpace:CGFloat = 2
        var xpos:CGFloat = 4
        var ypos:CGFloat = 0.0
        var buttonWidth:CGFloat = 43.0
        var buttonHeight:CGFloat = 18.0
        self.showShareButton = showShareButton
        
        biinBtn = BNUIButton_Social(frame: CGRectMake(xpos, ypos, 0, 0), text:"00", activate:false, iconType:BNIconType.biinSmall)
        self.addSubview(biinBtn!)
        
        xpos += biinBtn!.frame.width + xSpace
        commentBtn = BNUIButton_Social(frame: CGRectMake(xpos, ypos, 0, 0), text:"00", activate:false, iconType:BNIconType.commentSmall)
        //self.addSubview(commentBtn!)
        
//        if self.showShareButton {
//            xpos += commentBtn!.frame.width + xSpace
//            shareBtn = BNUIButton_Social(frame: CGRectMake(xpos, ypos, 0, 0), text:"", activate:false, iconType:BNIconType.shareSmall)
//            self.addSubview(shareBtn!)
//        }
        
    }
    
    convenience init(frame: CGRect, father: BNView?, element:BNElement?) {
        self.init(frame: frame, father:father )
        
        //Social buttons
        var xSpace:CGFloat = 2
        var xpos:CGFloat = 4
        var ypos:CGFloat = 0.0
        var buttonWidth:CGFloat = 43.0
        var buttonHeight:CGFloat = 18.0
        
        biinBtn = BNUIButton_Social(frame: CGRectMake(xpos, ypos, 0, 0), text:"00", activate:false, iconType:BNIconType.biinSmall)
        self.addSubview(biinBtn!)
        
        xpos += biinBtn!.frame.width + xSpace
        commentBtn = BNUIButton_Social(frame: CGRectMake(xpos, ypos, 0, 0), text:"00", activate:false, iconType:BNIconType.commentSmall)
        //self.addSubview(commentBtn!)
    }
    
    override func transitionIn() {

    }
    
    override func transitionOut( state:BNState? ) {

    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
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
    
    func updateSocialButtonsForSite(site:BNSite?){
        //Social buttons
        var xSpace:CGFloat = 2
        var xpos:CGFloat = 4
        

        biinBtn!.updateText("\(site!.biinedCount)")
        
        if site!.userBiined {
            (biinBtn! as BNUIButton_Social).setActive()
        } else {
            (biinBtn! as BNUIButton_Social).setInactive()
        }
        
        xpos += biinBtn!.frame.width + xSpace
        commentBtn!.frame.origin.x = xpos
        commentBtn!.updateText("\(site!.commentedCount)")
        if site!.userCommented {
            (commentBtn! as BNUIButton_Social).setActive()
        } else {
            (commentBtn! as BNUIButton_Social).setInactive()
        }

//        if showShareButton {
//            xpos += commentBtn!.frame.width + xSpace
//            shareBtn!.frame.origin.x = xpos
//            if site!.userShared {
//                (shareBtn! as BNUIButton_Social).setActive()
//            } else {
//                (shareBtn! as BNUIButton_Social).setInactive()
//            }
//        }
    }
    
    func updateSocialButtonsForElement(element:BNElement?){
        //Social buttons
        var xSpace:CGFloat = 2
        var xpos:CGFloat = 4
        
        
        biinBtn!.updateText("\(element!.biinedCount)")
        
        if element!.userBiined {
            (biinBtn! as BNUIButton_Social).setActive()
        } else {
            (biinBtn! as BNUIButton_Social).setInactive()
        }
        
        xpos += biinBtn!.frame.width + xSpace
        commentBtn!.frame.origin.x = xpos
        commentBtn!.updateText("\(element!.commentedCount)")
        
        if element!.userCommented {
            (commentBtn! as BNUIButton_Social).setActive()
        } else {
            (commentBtn! as BNUIButton_Social).setInactive()
        }
    }
}
//  SocialButtonsView.swift
//  biin
//  Created by Esteban Padilla on 1/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SocialButtonsView:BNView {
    
    var biinBtn:BNUISocialButton?
    var commentBtn:BNUISocialButton?
    var shareBtn:BNUISocialButton?

    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
        addSocialButtonsForSite(site)
    }
    
    convenience init(frame: CGRect, father: BNView?, element:BNElement?) {
        self.init(frame: frame, father:father )
    }
    
    override func transitionIn() {
        println("trasition in on SocialButtonsView")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on SocialButtonsView")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: SocialButtonsView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: SocialButtonsView")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    func addSocialButtonsForSite(site:BNSite?){
        
        //Social buttons
        var xSpace:CGFloat = 2
        var xpos:CGFloat = 3
        var ypos:CGFloat = 0.0
        var buttonWidth:CGFloat = 43.0
        var buttonHeight:CGFloat = 18.0

        biinBtn = BNUISocialButton(frame: CGRectMake(xpos, ypos, 0, 0), text:"\(site!.biinedCount)", activate:site!.userBiined, iconType:BNIconType.biinSmall)
        self.addSubview(biinBtn!)
        
        xpos += biinBtn!.frame.width + xSpace
        commentBtn = BNUISocialButton(frame: CGRectMake(xpos, ypos, 0, 0), text:"\(site!.comments)", activate:site!.userCommented, iconType:BNIconType.commentSmall)
        self.addSubview(commentBtn!)
        
        xpos += commentBtn!.frame.width + xSpace
        shareBtn = BNUISocialButton(frame: CGRectMake(xpos, ypos, 0, 0), text:"", activate:site!.userShared, iconType:BNIconType.shareSmall)
        self.addSubview(shareBtn!)
        
    }
}
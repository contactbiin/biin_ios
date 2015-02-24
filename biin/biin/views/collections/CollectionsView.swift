//  CollectionsView.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class CollectionsView: BNView {
    
    var delegate:CollectionsView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var fade:UIView?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        title = UILabel(frame: CGRectMake(0, 2, screenWidth, 12))
        title!.text = "Collections"
        title!.textColor = UIColor.appTextColor()
        title!.font = UIFont(name: "Lato-Light", size: 10)
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(2, 5, 30, 15))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        println("trasition in on CollectionsView")
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on CollectionsView")
        state!.action()
        
        if state!.stateType == BNStateType.BiinieCategoriesState
            || state!.stateType == BNStateType.SiteState {
                
                UIView.animateWithDuration(0.25, animations: {()-> Void in
                    self.frame.origin.x = SharedUIManager.instance.screenWidth
                })
                
        } else {
            
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.fade!.alpha = 0.25
            })
            
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "hideView:", userInfo: nil, repeats: false)
        }
    }
    
    func hideView(sender:NSTimer){
        self.frame.origin.x = SharedUIManager.instance.screenWidth
        self.fade!.alpha = 0
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: CollectionsView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: CollectionsView")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegate!.hideCollectionsView!(self)
        //delegate!.hideElementView!(elementMiniView)
    }
}

@objc protocol CollectionsView_Delegate:NSObjectProtocol {
    optional func hideCollectionsView(view:CollectionsView)
}

//  GiftsView.swift
//  Biin
//  Created by Esteban Padilla on 7/2/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreLocation


class GiftsView: BNView {

    var title:UILabel?
    var backBtn:BNUIButton_Back?
    
    var delegate:GiftsView_Delegate?
    var elementContainers:Array <MainView_Container_Elements>?
    var scroll:BNScroll?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        //NSLog("MainViewContainer init()")
        
        self.backgroundColor = UIColor.appBackground()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 27
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.mainView_TitleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.mainView_TitleSize)
        let titleText = NSLocalizedString("TresureChest", comment: "TresureChest").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.whiteColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(5,15, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        ypos = SharedUIManager.instance.mainView_HeaderSize
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.lightGrayColor()

        self.scroll = BNScroll(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - ypos)), father: self, direction: BNScroll_Direction.VERTICAL, space: 5, extraSpace: 0, color: UIColor.appBackground(), delegate: nil)
        self.addSubview(scroll!)
//        self.addSubview(line)
        
        
        elementContainers = Array<MainView_Container_Elements>()
        updateGifts()
        
    }
    
    func updateGifts(){
        
        self.scroll!.leftSpace = 5
        
        if let biinie = BNAppSharedManager.instance.dataManager.biinie {
            for gift in biinie.gifts {
                let giftView = GiftView(frame: CGRectMake(0, 0, (SharedUIManager.instance.screenWidth - 10), SharedUIManager.instance.giftView_height) , father: self, gift: gift)
                scroll!.addChild(giftView)
            }
        }
        
        self.scroll!.setChildrenPosition()
    }
    
    override func transitionIn() {
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        //        if state!.stateType == BNStateType.MainViewContainerState
        //            || state!.stateType == BNStateType.SiteState {
        
        UIView.animateWithDuration(0.25, animations: {()-> Void in
            self.frame.origin.x = SharedUIManager.instance.screenWidth
        })
        //        } else {
        
        //            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.hideView(_:)), userInfo: nil, repeats: false)
        //        }
    }
    
    override func setNextState(goto:BNGoto){
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
    
    override func refresh() { }

    override func clean(){
        if elementContainers?.count > 0 {
            
            for elementContainer in elementContainers! {
                elementContainer.clean()
                elementContainer.removeFromSuperview()
            }
            
            elementContainers!.removeAll(keepCapacity: false)
        }
        
        elementContainers = nil
        scroll!.removeFromSuperview()
        fade!.removeFromSuperview()
    }
    
    func backBtnAction(sender:UIButton) {
        delegate!.hideGiftsView!()
        //delegate!.hideElementView!(elementMiniView)
    }
}


@objc protocol GiftsView_Delegate:NSObjectProtocol {
    optional func hideGiftsView()
}
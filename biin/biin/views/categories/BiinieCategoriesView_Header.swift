//  BiinieCategoriesView_Header.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_Header: BNView {

    var showMenuBtn:BNUIButton?
//    var testBtn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.layer.masksToBounds = true
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)

        addButtons()
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
    //Instance Methods
    func addButtons(){
        showMenuBtn = BNUIButton_Menu(frame: CGRectMake(10, 12, 60, 40), text: "", iconType: BNIconType.menuMedium)
        showMenuBtn!.addTarget(father, action:#selector((father as! MainViewContainer).showMenuBtnActon(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(showMenuBtn!)
        
//        testBtn = UIButton(frame: CGRectMake(200, 0, 60, 40))
//        testBtn!.backgroundColor = UIColor.darkGrayColor()
//        testBtn!.setTitle("test", forState: UIControlState.Normal)
//        testBtn!.addTarget(father, action: Selector("testBtnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(testBtn!)
//        
//        testBtn!.enabled = false
//        testBtn!.alpha = 0
    }
    
    func clean(){
        showMenuBtn?.removeFromSuperview()
//        testBtn?.removeFromSuperview()
    }
    
}

@objc protocol BiinieCategoriesView_Header_Delegate:NSObjectProtocol {
    optional func updateCategoryStatus(view:BiinieCategoriesView_Header,  position:CGFloat)
}

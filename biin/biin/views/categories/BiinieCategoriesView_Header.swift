//  BiinieCategoriesView_Header.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_Header: BNView, BiinieCategoriesView_Delegate {

    var showMenuBtn:BNUIButton?
    
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
    
    //Instance Methods
    func addButtons(){
        showMenuBtn = BNUIButton_Menu(frame: CGRectMake(10, 12, 60, 40), text: "", iconType: BNIconType.menuMedium)
        showMenuBtn!.addTarget(father, action: "showMenuBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(showMenuBtn!)
    }
    
}

@objc protocol BiinieCategoriesView_Header_Delegate:NSObjectProtocol {
    optional func updateCategoryStatus(view:BiinieCategoriesView_Header,  position:CGFloat)
}

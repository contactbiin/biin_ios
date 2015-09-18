//  ElementView_Header.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementView_Header:BNView {
    
    var title:UILabel?
    var subTitle:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        var ypos:CGFloat = 2
        let xpos:CGFloat =  10
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
        
        title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_titleSize)
        title!.textColor = UIColor.bnGrayDark()
        title!.textAlignment = NSTextAlignment.Left
        title!.text = "site title here"
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_titleSize + 2
        subTitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.siteView_subTittleSize + 3)))
        subTitle!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        subTitle!.textColor = UIColor.bnGrayDark()
        subTitle!.textAlignment = NSTextAlignment.Left
        subTitle!.text = "Site subtitle here"
        self.addSubview(subTitle!)
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
    
    //Instance methods
    func updateForElement(element:BNElement?) {
        title!.text = element!.title
        subTitle!.text = element!.subTitle
    }
    
    //Instance methods
    func updateSocialButtonsForElement(element: BNElement?){
        //buttonsView!.updateSocialButtonsForElement(element)
    }
}


//  SiteMiniView_Header.swift
//  biin
//  Created by Esteban Padilla on 1/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteMiniView_Header:BNView {

    //var buttonsView:SocialButtonsView?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?, showShareButton:Bool){
        self.init(frame: frame, father:father )
        self.backgroundColor = site!.organization!.primaryColor
        let textColor = site!.organization!.secondaryColor
        
        //var textColor:UIColor?
//        if site!.useWhiteText {
//            textColor = UIColor.whiteColor()
//        } else {
//            textColor = UIColor.bnGrayDark()
//        }
        
        var ypos:CGFloat = 7
        
        let title = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.siteMiniView_title + 2)))
        title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteMiniView_title)
        title.textColor = textColor
        title.textAlignment = NSTextAlignment.Center
        title.text = site!.title
        self.addSubview(title)
        
        ypos += SharedUIManager.instance.siteMiniView_title + 2
        
        let subTitle = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.siteMiniView_subTitle + 2)))
        subTitle.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteMiniView_subTitle)
        subTitle.textColor = textColor
        subTitle.text = site!.subTitle!
        subTitle.textAlignment = NSTextAlignment.Center
        self.addSubview(subTitle)
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
    
    //Instance methods
    func updateSocialButtonsForSite(site: BNSite?){
        //buttonsView!.updateSocialButtonsForSite(site)
    }
}
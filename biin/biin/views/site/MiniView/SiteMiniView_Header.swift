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
        self.backgroundColor = UIColor.appMainColor()
        
        var ypos:CGFloat = 4
        //buttonsView = SocialButtonsView(frame: CGRectMake(0, ypos, frame.width, 15), father: self, site: site, showShareButton:showShareButton)
        //self.addSubview(buttonsView!)
        //ypos += 16
        
        let title = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_titleSize + 3)))
        title.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.miniView_titleSize)
        title.textColor = site!.titleColor
        title.text = site!.title
        self.addSubview(title)
        
        ypos += SharedUIManager.instance.miniView_titleSize + 3
        
        let subTitle = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 2)))
        subTitle.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.miniView_subTittleSize)
        subTitle.textColor = UIColor.appTextColor()
        subTitle.text = site!.subTitle!//"\(site!.biinieProximity!)"c
        self.addSubview(subTitle)
    }
    
    override func transitionIn() {
        print("trasition in on SiteMiniView_Header")
    }
    
    override func transitionOut( state:BNState? ) {
        print("trasition out on SiteMiniView_Header")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            print("showUserControl: SiteMiniView_Header")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            print("updateUserControl: SiteMiniView_Header")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance methods
    func updateSocialButtonsForSite(site: BNSite?){
        //buttonsView!.updateSocialButtonsForSite(site)
    }
}
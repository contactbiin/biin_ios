//  SiteView_Header.swift
//  biin
//  Created by Esteban Padilla on 2/2/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Header:BNView {
    
    //var buttonsView:SocialButtonsView?
    var title:UILabel?
    var subTitle:UILabel?
    
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
        
        self.backgroundColor = UIColor.appMainColor()
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSizeMake(0, 3)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.25
        
        var ypos:CGFloat = 5
//        buttonsView = SocialButtonsView(frame: CGRectMake(0, ( SharedUIManager.instance.siteView_headerHeight + 5 ), frame.width, 15), father: self, site: nil, showShareButton:true)
//        self.addSubview(buttonsView!)
        
        ypos += 15
        
        title = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_titleSize)
        title!.textColor = UIColor.biinColor()
        title!.textAlignment = NSTextAlignment.Center
        title!.text = "site title here"
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_titleSize + 4
        
        subTitle = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 3)))
        subTitle!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteView_subTittleSize)
        subTitle!.textColor = UIColor.appTextColor()
        subTitle!.textAlignment = NSTextAlignment.Center
        subTitle!.text = "Site subtitle here"
        self.addSubview(subTitle!)
    }
    /*
    convenience init(frame:CGRect, father:BNView?){
        self.init(frame: frame, father:father )
        self.backgroundColor = UIColor.appMainColor()
        
        var ypos:CGFloat = 3
        buttonsView = SocialButtonsView(frame: CGRectMake(0, ypos, frame.width, 15), father: self, site: site)
        self.addSubview(buttonsView!)
        
        ypos += 16
        
        var title = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_titleSize + 2)))
        title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
        title.textColor = UIColor.biinColor()
        title.text = site!.title
        self.addSubview(title)
        
        ypos += SharedUIManager.instance.miniView_titleSize + 2
        
        var subTitle = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 2)))
        subTitle.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_subTittleSize)
        subTitle.textColor = UIColor.appTextColor()
        subTitle.text = "Site title here"
        self.addSubview(subTitle)
    }
    */
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
    //Instance methods
    func updateForSite(site: BNSite?){
        //buttonsView!.updateSocialButtonsForSite(site)
        title!.textColor = site!.titleColor
        title!.text = site!.title
        subTitle!.text = site!.subTitle
    }
}

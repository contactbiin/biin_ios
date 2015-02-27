//  SiteView_Location.swift
//  biin
//  Created by Esteban Padilla on 2/26/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Location:BNView {

    var siteAvatarView:UIView?
    var siteAvatar:BNUIImageView?
    var title:UILabel?
    var subTitle:UILabel?
    
    var streetAddress1:UILabel?
    var streetAddress2:UILabel?
    var stateLbl:UILabel?//state, city, zipcode
    var country:UILabel?
    
    
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
        
        self.backgroundColor = UIColor.appMainColor()

        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        var headerWidth = screenWidth - 30
        var xpos:CGFloat = (screenWidth - headerWidth) / 2
        var ypos:CGFloat = 15
    
        //var line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        //line.backgroundColor = UIColor.appButtonColor()
        //self.addSubview(line)
    
        siteAvatarView = UIView(frame: CGRectMake(xpos, ypos, 92, 92))
        siteAvatarView!.layer.cornerRadius = 35
        siteAvatarView!.layer.borderColor = UIColor.appBackground().CGColor
        siteAvatarView!.layer.borderWidth = 6
        siteAvatarView!.layer.masksToBounds = true
        self.addSubview(siteAvatarView!)
        
        siteAvatar = BNUIImageView(frame: CGRectMake(1, 1, 90, 90))
        siteAvatar!.alpha = 0
        siteAvatar!.layer.cornerRadius = 30
        siteAvatar!.layer.masksToBounds = true
        siteAvatarView!.addSubview(siteAvatar!)
        BNAppSharedManager.instance.networkManager.requestImageData(BNAppSharedManager.instance.dataManager.bnUser!.imgUrl!, image: siteAvatar)

        
        title = UILabel(frame: CGRectMake((xpos + 100), (ypos + 30), (headerWidth - 95), 20))
        title!.font = UIFont(name: "Lato-Regular", size: 22)
        title!.text = ""
        title!.textColor = UIColor.biinColor()
        self.addSubview(title!)
        
        subTitle = UILabel(frame: CGRectMake((xpos + 100), (ypos + 50), (headerWidth - 95), 14))
        subTitle!.font = UIFont(name: "Lato-Light", size: 12)
        subTitle!.text = ""
        subTitle!.textColor = UIColor.appTextColor()
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
        println("trasition in on SiteView_Location")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on SiteView_Location")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: SiteView_Location")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: SiteView_Location")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance methods
    //Instance methods
    func updateForSite(site: BNSite?){
        title!.textColor = site!.titleColor
        title!.text = site!.title
        subTitle!.text = site!.subTitle
    }
}


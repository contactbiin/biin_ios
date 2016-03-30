//  SiteView_MiniLocation.swift
//  biin
//  Created by Esteban Padilla on 6/25/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_MiniLocation:BNView {
    
    weak var site:BNSite?
    var siteAvatarView:UIView?
    var siteAvatar:BNUIImageView?
    var title:UILabel?
    var streetAddress1:UILabel?

    var delegate:SiteView_MiniLocation_Delegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView? ) {
        super.init(frame: frame, father:father )
    }

    
    convenience init(frame: CGRect, father:BNView?, site:BNSite?) {
        self.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()

        var xpos:CGFloat = 3
        var ypos:CGFloat = 2
        
        siteAvatarView = UIView(frame: CGRectMake(xpos, ypos, 44, 44))
        siteAvatarView!.layer.cornerRadius = 13
        siteAvatarView!.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        siteAvatarView!.layer.borderWidth = 2
        siteAvatarView!.layer.masksToBounds = true
        self.addSubview(siteAvatarView!)
        
        siteAvatar = BNUIImageView(frame: CGRectMake(1, 1, 42, 42), color:site!.media[0].vibrantColor!)
        siteAvatar!.layer.cornerRadius = 13
        siteAvatar!.layer.masksToBounds = true
        siteAvatarView!.addSubview(siteAvatar!)
        
        if site!.media.count > 0 {
            self.site = site
            BNAppSharedManager.instance.networkManager.requestImageData(site!.media[0].url!, image: siteAvatar)
        } else {
            siteAvatar!.image =  UIImage(named: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
        
        xpos += 46
        ypos = 10
        
        title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width  - 50), 15))
        title!.font = UIFont(name: "Lato-Black", size: 13)
        title!.text = site!.title!
        title!.textColor = site!.titleColor!
        title!.numberOfLines = 1
        self.addSubview(title!)
        
        ypos += 15
        streetAddress1 = UILabel(frame: CGRectMake(xpos, ypos, (frame.width  - 53), 12))
        streetAddress1!.font = UIFont(name: "Lato-Light", size: 10)
        streetAddress1!.text = site!.streetAddress1!
        streetAddress1!.textColor = UIColor.appTextColor()
        streetAddress1!.numberOfLines = 1
        self.addSubview(streetAddress1!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isFirstResponder()
        
    }
    
    /* Gesture hadlers */
    func handleTap(sender:UITapGestureRecognizer) {
//        if delegate == nil {
//            self.delegate = BNAppSharedManager.instance.mainViewController!.mainView!
//        }
//        delegate!.showSiteView!(self, site: self.site!)
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
}

@objc protocol SiteView_MiniLocation_Delegate:NSObjectProtocol {
    optional func showSiteView(view:SiteView_MiniLocation, site:BNSite)

}


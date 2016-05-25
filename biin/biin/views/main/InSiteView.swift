//  InSiteView.swift
//  biin
//  Created by Esteban Padilla on 10/12/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class InSiteView: BNView {
    
    var site:BNSite?
    var siteAvatar:BNUIImageView?
    var title:UILabel?
    var subTitle:UILabel?
    var nutshell:UILabel?
    var viewContainer:UIView?
    var delegate:InSiteView_Delegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
 
        self.layer.masksToBounds = true
        
        //self.site = site!
        var ypos:CGFloat = 6
        
        viewContainer = UIView(frame: self.bounds)
        viewContainer!.backgroundColor = UIColor.redColor()
        self.addSubview(viewContainer!)
        
        let siteAvatarSize = (SharedUIManager.instance.inSiteView_Height - 10)
        siteAvatar = BNUIImageView(frame: CGRectMake(5, 5, siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        self.addSubview(siteAvatar!)
        
        let xpos:CGFloat = siteAvatarSize + 10
        title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.inSiteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.inSiteView_titleSize)
        title!.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        title!.textAlignment = NSTextAlignment.Left
        title!.text = "site title here"
        //        self.addSubview(title!)
        viewContainer!.addSubview(title!)
        
        ypos += SharedUIManager.instance.inSiteView_titleSize + 2
        subTitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.inSiteView_subTittleSize + 3)))
        subTitle!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.inSiteView_subTittleSize)
        subTitle!.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        subTitle!.textAlignment = NSTextAlignment.Left
        subTitle!.text = "Site subtitle here"
        //        self.addSubview(subTitle!)
        viewContainer!.addSubview(subTitle!)
        
        ypos += SharedUIManager.instance.inSiteView_subTittleSize + 2
        nutshell = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.inSiteView_nutshellSize + 3)))
        nutshell!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.inSiteView_nutshellSize)
        nutshell!.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        nutshell!.textAlignment = NSTextAlignment.Left
        nutshell!.text = "Site subtitle here"
        //        self.addSubview(nutshell!)
        viewContainer!.addSubview(nutshell!)

        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.upSwipeAction(_:)))
        upSwipe.direction = .Up
        self.addGestureRecognizer(upSwipe)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isFirstResponder()
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
    func updateForSite(site: BNSite?){
        
        self.site = site
        
        let textColor:UIColor = self.site!.organization!.secondaryColor!
        viewContainer!.backgroundColor = site!.organization!.primaryColor!
        
        title!.text = site!.title!
        subTitle!.text = site!.subTitle!
        nutshell!.text = site!.nutshell!
        
        title!.textColor = textColor
        subTitle!.textColor = textColor
        nutshell!.textColor = textColor
        
        
        
        if site!.organization!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(site!.organization!.media[0].url!, image: siteAvatar)
            siteAvatar!.cover!.backgroundColor = site!.organization!.media[0].vibrantColor!
        } else {
            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
    }
    
    /* Gesture hadlers */
    func handleTap(sender:UITapGestureRecognizer) {
        delegate!.showSiteViewOnContext!(self.site!)
    }
    
    func upSwipeAction(sender:UISwipeGestureRecognizer){
        delegate!.hideSiteViewOnContext!(self.site!)
    }
    
    override func clean() {
        
        site = nil
        siteAvatar?.removeFromSuperview()
        title?.removeFromSuperview()
        subTitle?.removeFromSuperview()
        nutshell?.removeFromSuperview()
        viewContainer?.removeFromSuperview()
        delegate = nil
    }
}

@objc protocol InSiteView_Delegate:NSObjectProtocol {
    optional func showSiteViewOnContext(site:BNSite)
    optional func hideSiteViewOnContext(site:BNSite)
}


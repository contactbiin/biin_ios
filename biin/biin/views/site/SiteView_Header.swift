//  SiteView_Header.swift
//  biin
//  Created by Esteban Padilla on 2/2/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Header:BNView {
    
    var siteAvatar:BNUIImageView?
    var title:UILabel?
    var subTitle:UILabel?
    var nutshell:UILabel?
    var visualEffectView:UIVisualEffectView?
    var viewContainer:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )

        var ypos:CGFloat = 4
        
        viewContainer = UIView(frame: self.bounds)
        viewContainer!.backgroundColor = UIColor.redColor()
        self.addSubview(viewContainer!)
        
//        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
//        visualEffectView!.frame = self.bounds
//        self.addSubview(visualEffectView!)
        
        let siteAvatarSize = (SharedUIManager.instance.siteView_headerHeight - 10)
        siteAvatar = BNUIImageView(frame: CGRectMake(5, 5, siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        self.addSubview(siteAvatar!)
        
        let xpos:CGFloat = siteAvatarSize + 10
        title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_titleSize)
        title!.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        title!.textAlignment = NSTextAlignment.Left
        title!.text = "site title here"
//        self.addSubview(title!)
        viewContainer!.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_titleSize + 2
        subTitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.siteView_subTittleSize + 3)))
        subTitle!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        subTitle!.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        subTitle!.textAlignment = NSTextAlignment.Left
        subTitle!.text = "Site subtitle here"
//        self.addSubview(subTitle!)
        viewContainer!.addSubview(subTitle!)
        
        ypos += SharedUIManager.instance.siteView_subTittleSize + 3
        nutshell = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.siteView_nutshellSize + 3)))
        nutshell!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_nutshellSize)
        nutshell!.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        nutshell!.textAlignment = NSTextAlignment.Left
        nutshell!.text = "Site subtitle here"
//        self.addSubview(nutshell!)
        viewContainer!.addSubview(nutshell!)
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
    func updateForSite(site: BNSite?){

        var textColor:UIColor?
        
        if site!.useWhiteText {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.bnGrayDark()
        }
        
        viewContainer!.backgroundColor = site!.media[0].vibrantColor!
        
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
}

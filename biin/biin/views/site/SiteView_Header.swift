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

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )

        var ypos:CGFloat = 4
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
        
        var siteAvatarSize = (SharedUIManager.instance.siteView_headerHeight - 10)
        siteAvatar = BNUIImageView(frame: CGRectMake(5, 5, siteAvatarSize, siteAvatarSize))
        self.addSubview(siteAvatar!)
        
        var xpos:CGFloat = siteAvatarSize + 10
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
        
        ypos += SharedUIManager.instance.siteView_subTittleSize + 3
        nutshell = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), (SharedUIManager.instance.siteView_nutshellSize + 3)))
        nutshell!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_nutshellSize)
        nutshell!.textColor = UIColor.bnGrayDark()
        nutshell!.textAlignment = NSTextAlignment.Left
        nutshell!.text = "Site subtitle here"
        self.addSubview(nutshell!)
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
        title!.text = site!.title!
        subTitle!.text = site!.subTitle!
        nutshell!.text = site!.nutshell!
        
        if site!.organization!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(site!.organization!.media[0].url!, image: siteAvatar)
            
        } else {
            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
    }
}

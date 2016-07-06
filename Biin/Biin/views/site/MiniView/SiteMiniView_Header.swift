//  SiteMiniView_Header.swift
//  biin
//  Created by Esteban Padilla on 1/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteMiniView_Header:BNView {
    
    var likeItButton:BNUIButton_LikeIt?
    weak var site:BNSite?
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
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?, showShareButton:Bool){
        self.init(frame: frame, father:father )
        
        self.site = site
        self.backgroundColor = site!.organization!.primaryColor
        let textColor = site!.organization!.secondaryColor
        var ypos:CGFloat = 5
        
        self.title = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.siteMiniView_title + 2)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteMiniView_title)
        title!.textColor = textColor
        title!.textAlignment = NSTextAlignment.Center
        title!.text = site!.title
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteMiniView_title + 2
        
        subTitle = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.siteMiniView_subTitle + 2)))
        subTitle!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteMiniView_subTitle)
        subTitle!.textColor = textColor
        subTitle!.text = site!.subTitle!
        subTitle!.textAlignment = NSTextAlignment.Center
        self.addSubview(subTitle!)
        ypos += SharedUIManager.instance.siteMiniView_title
        
        let xpos:CGFloat = ((frame.width / 2) - 12)
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake(xpos, ypos, 25, 25))
        likeItButton!.addTarget(self, action: #selector(self.likeit(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(likeItButton!)
        updateLikeItBtn()
        
    }
    
    override func transitionIn() { }
    
    override func transitionOut( state:BNState? ) { }
    
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
    
    func likeit(sender:BNUIButton_BiinIt){
        self.site!.userLiked = !self.site!.userLiked
        
        if self.site!.userLiked {
            BNAppSharedManager.instance.dataManager.addFavoriteSite(self.site!.identifier!)
//            animationView!.animateWithText(NSLocalizedString("LikeTxt", comment: "LikeTxt"))
            BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.LIKE_SITE, to:self.site!.identifier!, by:self.site!.identifier!)
            SharedAnswersManager.instance.logLike_Site(self.site)
            
        } else {
            BNAppSharedManager.instance.dataManager.removeFavoriteSite(self.site!.identifier!)
//            animationView!.animateWithText(NSLocalizedString("NotLikeTxt", comment: "NotLikeTxt"))
            BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.UNLIKE_SITE, to:self.site!.identifier!, by:self.site!.identifier!)
            SharedAnswersManager.instance.logUnLike_Site(self.site!)
            
        }
        
        BNAppSharedManager.instance.likeSite(self.site!)
        
        updateLikeItBtn()
    }
    
    func updateLikeItBtn() {
        likeItButton!.changedIcon(self.site!.userLiked)
        likeItButton!.icon!.color = self.site!.organization!.secondaryColor
        likeItButton!.setNeedsDisplay()
        
    }
    
    override func updateWidth(frame: CGRect) {
        
        self.frame = CGRectMake(frame.origin.x, self.frame.origin.y, frame.width, self.frame.height)
        
        var ypos:CGFloat = 5
        self.title!.frame = CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.siteMiniView_title + 2))
        
        ypos += SharedUIManager.instance.siteMiniView_title + 2

        self.subTitle!.frame = CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.siteMiniView_subTitle + 2))
        
        let xpos:CGFloat = ((frame.width / 2) - 12)
        self.likeItButton!.frame.origin.x = xpos
        
    }
    
    //Instance methods
    func updateSocialButtonsForSite(site: BNSite?){
        //buttonsView!.updateSocialButtonsForSite(site)
    }
}
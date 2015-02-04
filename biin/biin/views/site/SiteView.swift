//  SiteView.swift
//  biin
//  Created by Esteban Padilla on 1/30/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView:BNView, UIScrollViewDelegate {
 
    var delegate:SiteView_Delegate?
    var site:BNSite?
    var backBtn:BNUIBackButton?
    var header:SiteView_Header?
    var bottom:SiteView_Bottom?
    
    var scroll:UIScrollView?
    var showcases:Array<SiteView_Showcase>?
    
    var imagesScrollView:BNUIScrollView?
    
    var fade:UIView?
    var informationView:SiteView_Information?
    
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
        
        var scrollHeight:CGFloat = screenHeight - (SharedUIManager.instance.siteView_headerHeight + SharedUIManager.instance.siteView_bottomHeight) + 6
        //Add here any other heights for site view.
        
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.siteView_headerHeight, screenWidth, scrollHeight))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.appBackground()
        self.addSubview(scroll!)
        
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        header = SiteView_Header(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.siteView_headerHeight), father: self)
        self.addSubview(header!)
        
        backBtn = BNUIBackButton(frame: CGRectMake(2, 5, 30, 15))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        bottom = SiteView_Bottom(frame: CGRectMake(0, screenHeight - SharedUIManager.instance.siteView_bottomHeight, screenWidth, SharedUIManager.instance.siteView_bottomHeight), father:self)
        self.addSubview(bottom!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        informationView = SiteView_Information(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight), father: self)
        self.addSubview(informationView!)
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
        
        
        //self.layer.borderColor = UIColor.appMainColor().CGColor
        //self.layer.borderWidth = 1
        //self.layer.cornerRadius = 5
        //self.layer.masksToBounds = true
        
        //self.layer.shadowOffset = CGSizeMake(0, 0.5)
        //self.layer.shadowRadius = 1
        //self.layer.shadowOpacity = 0.25
        
        self.site = site
    }
    
    override func transitionIn() {
        println("trasition in on SiteView")
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on SiteView")
        state!.action()
        UIView.animateWithDuration(0.25, animations: {()-> Void in
            self.frame.origin.x = SharedUIManager.instance.screenWidth
        })
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
        
  
        
        
        
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: SiteView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: SiteView")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegate!.showCategoriesView!(self)
    }
    
    func updateSiteData(site:BNSite?) {
        header!.updateForSite(site)
        bottom!.updateForSite(site)
        imagesScrollView!.updateImages(site!.media)
        updateShowcases(site)
    }
    
    func showInformationView(sender:BNUIInformationButton){
        println("show site information window")
        UIView.animateWithDuration(0.2, animations: {()-> Void in
            self.informationView!.frame.origin.x = 0
            self.fade!.alpha = 0.25
        })
    }
    
    func hideInformationView(sender:UIButton){
        UIView.animateWithDuration(0.4, animations: {()-> Void in
            self.informationView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
        })
    }
    
    func updateShowcases(site:BNSite?){
        
        //clean()
        if showcases?.count > 0 {
            showcases!.removeAll(keepCapacity: false)
        }
        
        showcases = Array<SiteView_Showcase>()
        
        var height:CGFloat = SharedUIManager.instance.siteView_headerHeight + SharedUIManager.instance.miniView_height + 15

        scroll!.addSubview(imagesScrollView!)
        
        var ypos:CGFloat = SharedUIManager.instance.screenWidth
        
        for biin in site!.biins {
            
            var showcaseView = SiteView_Showcase(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, height), father: self, showcase:biin.showcase)
            scroll!.addSubview(showcaseView)
            showcases!.append(showcaseView)
            ypos += height
            ypos += 1
        }
        
        scroll!.contentSize = CGSizeMake(0, ypos)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.bounces = false
        scroll!.pagingEnabled = false
    }
    
    func clean(){
        
        for view in self.scroll!.subviews {
            if view.isKindOfClass(SiteView_Showcase) {
                view.removeFromSuperview()
            }
        }
    
    }
}

@objc protocol SiteView_Delegate:NSObjectProtocol {
    optional func showCategoriesView(view:SiteView)
}
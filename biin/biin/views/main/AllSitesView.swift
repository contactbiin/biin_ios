//  AllSitesView.swift
//  biin
//  Created by Esteban Padilla on 10/7/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class AllSitesView: BNView {

    var delegate:AllSitesView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var scroll:UIScrollView?
    
    var spacer:CGFloat = 1    
    var sites:Array<SiteMiniView>?
    var addedSitesIdentifiers:Dictionary<String, SiteMiniView>?

    var fade:UIView?

    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father: BNView?, showBiinItBtn:Bool) {
        
        self.init(frame: frame, father:father )
        self.backgroundColor = UIColor.clearColor()
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        
        var ypos:CGFloat = 20
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, 16))
        let titleText = NSLocalizedString("NearYou", comment: "NearYou").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.blackColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        
        backBtn = BNUIButton_Back(frame: CGRectMake(10, 10, 35, 35))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
        backBtn!.layer.borderColor = UIColor.darkGrayColor().CGColor
        backBtn!.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        self.addSubview(backBtn!)
        
        ypos = 55
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.whiteColor()
        
        scroll = UIScrollView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - (ypos + 20))))
        scroll!.backgroundColor = UIColor.clearColor()
        scroll!.pagingEnabled = false
        self.addSubview(scroll!)
        self.addSubview(line)
        
        sites = Array<SiteMiniView>()
        addedSitesIdentifiers = Dictionary<String, SiteMiniView>()

        addAllSites()
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()

        if state!.stateType != BNStateType.SiteState {
            UIView.animateWithDuration(0.3, animations: {()->Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
                }, completion: {(completed:Bool)->Void in
                    self.scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            })
        }
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
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        //delegate!.hideElementView!(self.element!)
        delegate!.hideAllSitesView!()
    }
    
    func addAllSites(){
        
        
        if sites != nil {
            addedSitesIdentifiers!.removeAll(keepCapacity: false)
            for view in sites! {
                view.isPositionedInFather = false
                view.isReadyToRemoveFromFather = true
            }
        } else {
            sites = Array<SiteMiniView>()
            addedSitesIdentifiers = Dictionary<String, SiteMiniView>()
        }
        
        var sitesArray:Array<BNSite> = Array<BNSite>()
        
        for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
            if category.hasSites {
                for var i = 0; i < category.sitesDetails.count; i++ {
                    
                    let siteIdentifier = category.sitesDetails[i].identifier!
                    
                    if let site = BNAppSharedManager.instance.dataManager.sites[ siteIdentifier ] {
                        if site.showInView {
                            sitesArray.append(site)
                        }
                    }
                }
            }
        }
        
        sitesArray = sitesArray.sort{ $0.biinieProximity < $1.biinieProximity  }
        
        var xpos:CGFloat = 0
        var ypos:CGFloat = 0
        var colunmCounter = 0
        var siteView_width:CGFloat = 0
        let miniSiteHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
        
        if sitesArray.count == 1 {
            siteView_width = SharedUIManager.instance.screenWidth
        } else {
            siteView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        }
        
        for site in sitesArray {
            if site.showInView {
                if !isSiteAdded(site.identifier!) {
                    

                    
                    let miniSiteView = SiteMiniView(frame: CGRectMake(xpos, ypos, siteView_width, miniSiteHeight), father: self, site:site)
                    miniSiteView.isPositionedInFather = true
                    miniSiteView.isReadyToRemoveFromFather = false
                    miniSiteView.delegate = father! as! MainView
                    
                    sites!.append(miniSiteView)
                    scroll!.addSubview(miniSiteView)
                    
                    xpos += siteView_width + 1
                    colunmCounter++
                    
                    if colunmCounter == 2 {
                        colunmCounter = 0
                        xpos = 0
                        ypos += (miniSiteHeight + 1)
                    }
                }
            }
        }
        
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
        
        for var i = 0; i < sites!.count; i++ {
            if sites![i].isReadyToRemoveFromFather {
                sites![i].removeFromSuperview()
                sites!.removeAtIndex(i)
                i = 0
                
            }
        }
    }
    
    func isSiteAdded(identifier:String) -> Bool {
        for siteView in sites! {
            if siteView.site!.identifier == identifier {
                return true
            }
        }
        return false
    }
    
    func showFade(){
        UIView.animateWithDuration(0.2, animations: {()-> Void in
            self.fade!.alpha = 0.5
        })
    }
    
    func hideFade(){
        UIView.animateWithDuration(0.5, animations: {()-> Void in
            self.fade!.alpha = 0
        })
    }
    
    func clean() {
        
        delegate = nil
        title?.removeFromSuperview()
        backBtn?.removeFromSuperview()

        fade?.removeFromSuperview()

        if sites != nil {
            for view in sites! {
                view.clean()
                view.removeFromSuperview()
            }
        }
        
        sites!.removeAll()
        addedSitesIdentifiers!.removeAll()
        scroll?.removeFromSuperview()
    }
    
    func show() {
        
    }
}

@objc protocol AllSitesView_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func hideAllSitesView()
}
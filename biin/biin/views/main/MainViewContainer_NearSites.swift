//  MainViewContainer_NearSites.swift
//  biin
//  Created by Esteban Padilla on 11/27/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit


class MainViewContainer_NearSites: BNView {


    var delegate:MainViewContainer_NearSites_Delegate?
    var title:UILabel?
    var moreSitesBtn:BNUIButton_More?
    var subTitle:UILabel?
    var scroll:BNScroll?
    
    var spacer:CGFloat = 1
    
    var addedSitesIdentifiers:Dictionary<String, SiteMiniView>?


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        
        self.backgroundColor = UIColor.darkGrayColor()
        
        moreSitesBtn = BNUIButton_More(frame: CGRectMake((screenWidth - SharedUIManager.instance.sitesContainer_headerHeight), 0, SharedUIManager.instance.sitesContainer_headerHeight, SharedUIManager.instance.sitesContainer_headerHeight))
        moreSitesBtn!.icon!.color = UIColor.whiteColor()

        
//        moreSitesBtn = UIButton(frame: CGRectMake((screenWidth - SharedUIManager.instance.sitesContainer_headerHeight), 0, SharedUIManager.instance.sitesContainer_headerHeight, SharedUIManager.instance.sitesContainer_headerHeight))
//        moreSitesBtn!.setTitle(NSLocalizedString("More", comment: "More"), forState: UIControlState.Normal)
//        moreSitesBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        moreSitesBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 11)
        moreSitesBtn!.addTarget(self, action: "moreSitesBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(moreSitesBtn!)
        
        title = UILabel(frame: CGRectMake(15, 16, (frame.width - 75), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText = NSLocalizedString("NearYou", comment: "NearYou").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.whiteColor()
        self.addSubview(title!)
        
        let scrollHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
        
        scroll = BNScroll(frame: CGRectMake(0, (SharedUIManager.instance.sitesContainer_headerHeight - 1), screenWidth, scrollHeight), father: self, direction: BNScroll_Direction.HORIZONTAL, space: 1, extraSpace: 0, color: UIColor.clearColor(), delegate: nil)
        self.addSubview(self.scroll!)
        //sites = Array<SiteMiniView>()
        addedSitesIdentifiers = Dictionary<String, SiteMiniView>()
        
        //addAllSites()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame:frame, father:father )
        
    }
    
    func moreSitesBtnAction(sender:UIButton){
        delegate!.showAllNearSitesView!()
    }
    
    func isSiteInArray(sites:Array<BNSite>, identifier:String) ->Bool {
        for site in sites {
            if site.identifier! == identifier {
                return true
            }
        }
        
        return false
    }
    
    func addAllSites(){
        
        
        var sites = Array<SiteMiniView>()
        let sitesArray = BNAppSharedManager.instance.dataManager.sites_ordered
        
        var xpos:CGFloat = 0
        let ypos:CGFloat = 1
        var siteView_width:CGFloat = 0
        
        if sitesArray.count == 1 {
            siteView_width = SharedUIManager.instance.screenWidth
        } else {
            siteView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        }
        
        
        for site in sitesArray {
            //if site.showInView {
                if !isSiteAdded(site.identifier!) {
                    
                    let miniSiteHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
                    let miniSiteView = SiteMiniView(frame: CGRectMake(xpos, ypos, siteView_width, miniSiteHeight), father: self, site:site)
                    miniSiteView.isPositionedInFather = true
                    miniSiteView.isReadyToRemoveFromFather = false
                    miniSiteView.delegate = father?.father! as! MainView
                    sites.append(miniSiteView)
                    
                    
                    xpos += siteView_width + 1
                    
                }
            //}
        }
        
        self.scroll!.addMoreChildren(sites)
        
    }
    
    override func refresh() {
        addAllSites()
    }
    
    func isSiteAdded(identifier:String) -> Bool {
        for view in scroll!.children {
            if (view as! SiteMiniView).site!.identifier! == identifier {
                return true
            }
        }
        return false
    }

    
    func clean(){
        
        scroll!.clean()

        addedSitesIdentifiers!.removeAll(keepCapacity: false)

        title?.removeFromSuperview()
        moreSitesBtn?.removeFromSuperview()
        subTitle?.removeFromSuperview()
        scroll?.removeFromSuperview()
    }
    
    override func request() {
        BNAppSharedManager.instance.dataManager.requestSites(self)
    }
    
    override func requestCompleted() {
        self.addAllSites()
        self.scroll!.requestCompleted()
    }
}

@objc protocol MainViewContainer_NearSites_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func showAllNearSitesView()
}

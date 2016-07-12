//  MainView_Container_NearSites.swift
//  biin
//  Created by Esteban Padilla on 11/27/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit


class MainView_Container_NearSites: BNView {


    var delegate:MainView_Container_NearSites_Delegate?
    var title:UILabel?
    var moreSitesBtn:BNUIButton_More?
    var noMorePlacesLbl:UILabel?

    var subTitle:UILabel?
    var scroll:BNScroll?
    
    var spacer:CGFloat = 1
    
//    var addedSitesIdentifiers:Dictionary<String, SiteMiniView>?
    var addedOrganizationsIdentifiers:Array<String>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        
        self.backgroundColor = UIColor.bnSitesColor()
        
        moreSitesBtn = BNUIButton_More(frame: CGRectMake((screenWidth - SharedUIManager.instance.sitesContainer_headerHeight), 0, SharedUIManager.instance.sitesContainer_headerHeight, SharedUIManager.instance.sitesContainer_headerHeight))
        moreSitesBtn!.icon!.color = UIColor.whiteColor()

        
//        moreSitesBtn = UIButton(frame: CGRectMake((screenWidth - SharedUIManager.instance.sitesContainer_headerHeight), 0, SharedUIManager.instance.sitesContainer_headerHeight, SharedUIManager.instance.sitesContainer_headerHeight))
//        moreSitesBtn!.setTitle(NSLocalizedString("More", comment: "More"), forState: UIControlState.Normal)
//        moreSitesBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        moreSitesBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 11)
        moreSitesBtn!.addTarget(self, action: #selector(self.moreSitesBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(moreSitesBtn!)
        
        title = UILabel(frame: CGRectMake(15, 21, (frame.width - 75), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText = NSLocalizedString("NearYou", comment: "NearYou").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.whiteColor()
        self.addSubview(title!)
        
        noMorePlacesLbl = UILabel(frame: CGRectMake(50, 175, (frame.width - 100), 30))
        noMorePlacesLbl!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText2 = NSLocalizedString("NoMorePlaces", comment: "NoMorePlaces").uppercaseString
        let attributedString2 = NSMutableAttributedString(string:titleText2)
        attributedString2.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText2.characters.count)))
        noMorePlacesLbl!.textAlignment = NSTextAlignment.Center
        noMorePlacesLbl!.numberOfLines = 2
        noMorePlacesLbl!.attributedText = attributedString2
        noMorePlacesLbl!.textColor = UIColor.whiteColor()
        self.addSubview(noMorePlacesLbl!)
        
        let scrollHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
        
        scroll = BNScroll(frame: CGRectMake(0, (SharedUIManager.instance.sitesContainer_headerHeight - 1), screenWidth, scrollHeight), father: self, direction: BNScroll_Direction.HORIZONTAL, space: 1, extraSpace: 0, color: UIColor.clearColor(), delegate: nil)
        self.addSubview(self.scroll!)
        //sites = Array<SiteMiniView>()
//        addedSitesIdentifiers = Dictionary<String, SiteMiniView>()
        addedOrganizationsIdentifiers = Array<String>()
        
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
            if !isFavoriteSite(site.identifier!) {
                if !isSiteAdded(site.identifier!) {
                    if !isOrganizationAdded(site.organization!.identifier!) {
                        let miniSiteHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
                        let miniSiteView = SiteMiniView(frame: CGRectMake(xpos, ypos, siteView_width, miniSiteHeight), father: self, site:site)
                        miniSiteView.isPositionedInFather = true
                        miniSiteView.isReadyToRemoveFromFather = false
                        miniSiteView.delegate = father?.father! as! MainView
                        sites.append(miniSiteView)
                        
                        xpos += siteView_width + 1
                    }
                }
            }
        }
        
        
        if sites.count > 0 {
            title!.alpha = 1
            moreSitesBtn!.alpha = 1
            noMorePlacesLbl!.alpha = 0
        } else {
            moreSitesBtn!.alpha = 0
        }
        
        self.scroll!.addMoreChildren(sites)
        
    }
    
    func addSite(site:BNSite?) {
        
        let ypos:CGFloat = 1
        var siteView_width:CGFloat = 0
        noMorePlacesLbl!.alpha = 0
        moreSitesBtn!.alpha = 1
        
        if self.scroll!.children.count == 0 {
            siteView_width = SharedUIManager.instance.screenWidth
        } else {
            siteView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        }
        
        let miniSiteHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
        let miniSiteView = SiteMiniView(frame: CGRectMake(0, ypos, siteView_width, miniSiteHeight), father: self, site:site)
        
        miniSiteView.isPositionedInFather = true
        miniSiteView.isReadyToRemoveFromFather = false
        miniSiteView.delegate = father?.father! as! MainView
        
        self.scroll?.addChildAtBegining(miniSiteView)
    }
    
    func removeSite(site:BNSite?){
        self.scroll!.removeChildByIdentifier(site!.identifier!)
        
        if self.scroll!.children.count == 0 {
//            title!.alpha = 0
            moreSitesBtn!.alpha = 0
            noMorePlacesLbl!.alpha = 1
        } else if self.scroll!.children.count  == 3 {
            request()
        }
    }
    
    override func refresh() {
        addAllSites()
    }
    
    func isOrganizationAdded(identifier:String) -> Bool {
        for organizarion in addedOrganizationsIdentifiers! {
            if organizarion == identifier {
                return true
            }
        }
        
        addedOrganizationsIdentifiers!.append(identifier)
        return false
    }
    
    func isSiteAdded(identifier:String) -> Bool {
        for view in scroll!.children {
            if view.model!.identifier! == identifier {
                return true
            }
        }
        return false
    }
    
    func isFavoriteSite(identifier:String) -> Bool {
        
        
        if let site = BNAppSharedManager.instance.dataManager.sites[identifier] {
            for (organizarionIdentifier, _) in BNAppSharedManager.instance.dataManager.organizations {
                if site.organization!.identifier! == organizarionIdentifier {
                    for siteIdentifier in BNAppSharedManager.instance.dataManager.favoritesSites {
                        if siteIdentifier == identifier {
                            return true
                        }
                    }
                }
            }
        }
            
        return false
        /*
        for siteIdentifier in BNAppSharedManager.instance.dataManager.favoritesSites {
            if siteIdentifier == identifier {
                return true
            }
        }
        return false
         */
    }

    func updateLikeButtons(){
        for view in self.scroll!.children {
            (view as! SiteMiniView).updateLikeButton()
        }
    }
    
    override func clean(){
        
        scroll!.clean()

//        addedSitesIdentifiers!.removeAll(keepCapacity: false)

        addedOrganizationsIdentifiers!.removeAll()
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

@objc protocol MainView_Container_NearSites_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func showAllNearSitesView()
}

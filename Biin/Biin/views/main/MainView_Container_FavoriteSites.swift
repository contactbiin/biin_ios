//  MainView_Container_FavoriteSites.swift
//  biin
//  Created by Esteban Padilla on 5/13/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainView_Container_FavoriteSites: BNView {
    
    
    var delegate:MainView_Container_FavoriteSites_Delegate?
    var title:UILabel?
    var addFavoritePlacesLbl:UILabel?
    var likeItButton:BNUIButton_LikeIt?

    
    var moreSitesBtn:BNUIButton_More?
    var subTitle:UILabel?
    var scroll:BNScroll?
    
    var spacer:CGFloat = 1
    
    var addedSitesIdentifiers:Dictionary<String, SiteMiniView>?
    
    
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
        let titleText = NSLocalizedString("FavoritePlaces", comment: "FavoritePlaces").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.whiteColor()
        self.addSubview(title!)
        
        var ypos:CGFloat = 100
        let xpos:CGFloat = ((frame.width / 2) - 40)
        
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake(xpos, ypos, 86, 86))
        likeItButton!.addHeartBeatAnimation()
        self.addSubview(likeItButton!)
        
        ypos = ypos + 90
        
        addFavoritePlacesLbl = UILabel(frame: CGRectMake(50, ypos, (frame.width - 100), 30))
        addFavoritePlacesLbl!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText2 = NSLocalizedString("AddFavoritePlaces", comment: "AddFavoritePlaces").uppercaseString
        let attributedString2 = NSMutableAttributedString(string:titleText2)
        attributedString2.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText2.characters.count)))
        addFavoritePlacesLbl!.textAlignment = NSTextAlignment.Center
        addFavoritePlacesLbl!.numberOfLines = 2
        addFavoritePlacesLbl!.attributedText = attributedString2
        addFavoritePlacesLbl!.textColor = UIColor.whiteColor()
        self.addSubview(addFavoritePlacesLbl!)
        
        
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
        delegate!.showAllFavoriteSitesView!()
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
        let favoritesSites = BNAppSharedManager.instance.dataManager.favoritesSites
        
//        var xpos:CGFloat = 0
        let ypos:CGFloat = 1
        var siteView_width:CGFloat = 0
        
        if favoritesSites.count == 1 {
            siteView_width = SharedUIManager.instance.screenWidth
        } else {
            siteView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        }
        
        for i in (0..<favoritesSites.count) {
            if let site = BNAppSharedManager.instance.dataManager.sites[favoritesSites[i]] {
                if site.userLiked {
                    if !isSiteAdded(site.identifier!) {
                        let miniSiteHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
                        let miniSiteView = SiteMiniView(frame: CGRectMake(0, ypos, siteView_width, miniSiteHeight), father: self, site:site)
                        miniSiteView.isPositionedInFather = true
                        miniSiteView.isReadyToRemoveFromFather = false
                        miniSiteView.delegate = father?.father! as! MainView
                        sites.append(miniSiteView)
                        
                        //xpos += siteView_width + 1
                    }
                }
            }
        }
        
        if favoritesSites.count > 0 {
            title!.alpha = 1
            moreSitesBtn!.alpha = 1
            likeItButton!.alpha = 0
            addFavoritePlacesLbl!.alpha = 0
        } else {
            title!.alpha = 0
            moreSitesBtn!.alpha = 0
        }
        
        self.scroll!.addMoreChildren(sites)
    }
    
    func addSite(site:BNSite?) {
        
        title!.alpha = 1
        moreSitesBtn!.alpha = 1
        likeItButton!.alpha = 0
        addFavoritePlacesLbl!.alpha = 0
        
        let ypos:CGFloat = 1
        var siteView_width:CGFloat = 0
                
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
            title!.alpha = 0
            moreSitesBtn!.alpha = 0
            likeItButton!.alpha = 1
            addFavoritePlacesLbl!.alpha = 1
        }
    }
    
    override func refresh() {
        scroll!.clean()
        addedSitesIdentifiers!.removeAll(keepCapacity: false)
        addAllSites()
    }
    
    func isSiteAdded(identifier:String) -> Bool {
        for view in scroll!.children {
            if view.model!.identifier! == identifier {
                return true
            }
        }
        return false
    }
    
    
    override func clean(){
        
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

@objc protocol MainView_Container_FavoriteSites_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func showAllFavoriteSitesView()
}


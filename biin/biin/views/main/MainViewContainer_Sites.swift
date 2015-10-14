//  SitesContainer.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainViewContainer_Sites:BNView, UIScrollViewDelegate {
    
    var delegate:MainViewContainer_Sites_Delegate?
    var title:UILabel?
    var moreSitesBtn:UIButton?
    var subTitle:UILabel?
    var scroll:UIScrollView?
    
    var spacer:CGFloat = 1
    
    var sites:Array<SiteMiniView>?
    var addedSitesIdentifiers:Dictionary<String, SiteMiniView>?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        self.backgroundColor = UIColor.lightGrayColor()
        let screenWidth = SharedUIManager.instance.screenWidth
        
        //var ypos:CGFloat = SharedUIManager.instance.miniView_height + 6

        moreSitesBtn = UIButton(frame: CGRectMake(screenWidth - 50, 0, 50, 38))
        moreSitesBtn!.setTitle(NSLocalizedString("More", comment: "More"), forState: UIControlState.Normal)
        moreSitesBtn!.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        moreSitesBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 11)
        moreSitesBtn!.addTarget(self, action: "moreSitesBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(moreSitesBtn!)
        
        title = UILabel(frame: CGRectMake(15, 11, (frame.width - 75), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText = NSLocalizedString("NearYou", comment: "NearYou").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.darkGrayColor()
        self.addSubview(title!)

        let scrollHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
        scroll = UIScrollView(frame: CGRectMake(0, (SharedUIManager.instance.sitesContainer_headerHeight - 1), screenWidth, scrollHeight))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.clearColor()
        self.addSubview(scroll!)
        
        sites = Array<SiteMiniView>()
        addedSitesIdentifiers = Dictionary<String, SiteMiniView>()

        addAllSites()
    }
    
    deinit{
        print("-------------- deinit in siteView_showcase")
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        if sites?.count > 0 {
            
            for view in scroll!.subviews {
                
                if view is SiteMiniView {
                    (view as! SiteMiniView).removeFromSuperview()
                }
            }
            
            sites!.removeAll(keepCapacity: false)
            addedSitesIdentifiers!.removeAll(keepCapacity: false)

        }
    }
    
    override func setNextState(goto:BNGoto){
        
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
    //instance methods
    //Start all category work, download etc.
    override func getToWork(){
        
    }
    
    //Stop all category work, download etc.
    override func getToRest(){
        
    }
    
    func updateForSite(site: BNSite?){
        
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
        let ypos:CGFloat = 1
        var siteView_width:CGFloat = 0
        
        if sitesArray.count == 1 {
            siteView_width = SharedUIManager.instance.screenWidth
        } else {
            siteView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        }
        
        for site in sitesArray {
            if site.showInView {
                if !isSiteAdded(site.identifier!) {
                    
                    let miniSiteHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
                    let miniSiteView = SiteMiniView(frame: CGRectMake(xpos, ypos, siteView_width, miniSiteHeight), father: self, site:site)
                    miniSiteView.isPositionedInFather = true
                    miniSiteView.isReadyToRemoveFromFather = false
                    miniSiteView.delegate = father?.father! as! MainView
                    
                    sites!.append(miniSiteView)
                    scroll!.addSubview(miniSiteView)
                    
                    xpos += siteView_width + 1
                    
                }
            }
        }
        
        scroll!.contentSize = CGSizeMake(xpos, 100)

        for var i = 0; i < sites!.count; i++ {
            if sites![i].isReadyToRemoveFromFather {
                //println("***** REMOVE SITE:title: \(sites![i].site!.title!)")
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
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //handlePan(scrollView.panGestureRecognizer)
        let mainView = father!.father! as! MainView
        mainView.delegate!.mainView!(mainView, hideMenu: false)
    }
    
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
    }// called on finger up as we are moving
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
    }// called when scroll view grinds to a halt
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        
        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }// called when scrolling animation finished. may be called immediately if already at top
    
    //SiteMiniView_Delegate
    func showSiteView(view: SiteMiniView) {
        
        //(father! as! SiteView).showElementView(element)
    }
    
    func moreSitesBtnAction(sender:UIButton){
        delegate!.showAllSitesView!()
    }
}

@objc protocol MainViewContainer_Sites_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func showAllSitesView()
}
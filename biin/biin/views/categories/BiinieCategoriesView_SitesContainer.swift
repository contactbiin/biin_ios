//  BiinieCategoriesView_SitesContainer.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_SitesContainer: BNView, UIScrollViewDelegate {
    
    //var delegate:BiinieCategoriesView_SiteContainer_Delegate?
    
    var isWorking = false
    var category:BNCategory?
    var sites:Array<SiteMiniView>?
    var scroll:UIScrollView?
    var isScrollDecelerating = false
    
    var siteViewHeight:CGFloat = 0
    var siteViewWidth:CGFloat = 0
    var siteSpacer:CGFloat = 10.0
    var columns:Int = 2
//    var siteRequestIndex:Int = 0
    var siteRequestPreviousLimit:Int = 0
    
    
    var lastRowRequested:Int = 0
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
    }
    
    convenience init(frame:CGRect, father:BNView?, category:BNCategory?){
        self.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appBackground()
        self.category = category
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        scroll = UIScrollView(frame:CGRectMake(0, 0, screenWidth, (screenHeight - SharedUIManager.instance.categoriesHeaderHeight)))
//        scroll!.backgroundColor = UIColor.biinColor()
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.delegate = self
        self.addSubview(scroll!)
        
        addSites()
    }
    
    override func transitionIn() {
        println("trasition in on BiinieCategoriesView_SitesContainer")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on BiinieCategoriesView_SitesContainer")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: BiinieCategoriesView_SitesContainer")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: BiinieCategoriesView_SitesContainer")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //instance methods
    //Start all category work, download etc.
    func getToWork(){
        isWorking = true
        println("\(category!.identifier!) is working")
    }
    
    //Stop all category work, download etc.
    func getToRest(){
        isWorking = false
        println("\(category!.identifier!) is resting")
    }
    
    func addSites() {
        
        var xpos:CGFloat = 0
        var ypos:CGFloat = siteSpacer
        
        var columnCounter = 0
        
        sites = Array<SiteMiniView>()
        
        switch SharedUIManager.instance.deviceType {
        case .iphone4s, .iphone5, .iphone6:
            siteViewWidth = (SharedUIManager.instance.screenWidth - 30) / 2
            siteViewHeight = 240.0
            columns = 2
            break
        case .iphone6Plus:
            siteViewWidth = (SharedUIManager.instance.screenWidth - 40) / 3
            siteViewHeight = SharedUIManager.instance.screenHeight / 4
            columns = 3
            break
        case .ipad:
            siteViewWidth = (SharedUIManager.instance.screenWidth - 40) / 3
            siteViewHeight = SharedUIManager.instance.screenHeight / 3
            columns = 3
            break
        default:
            break
        }
        
        
        for var i = 0; i < category?.sitesDetails.count; i++ {
            
            if columnCounter < columns {
                columnCounter++
                xpos = xpos + siteSpacer
                
            } else {
                ypos = ypos + siteViewHeight + siteSpacer
                xpos = siteSpacer
                columnCounter = 1
            }
            
            var siteIdentifier = category?.sitesDetails[i].identifier!
            var site = BNAppSharedManager.instance.dataManager.sites[ siteIdentifier! ]
            
            var miniSiteView = SiteMiniView(frame: CGRectMake(xpos, ypos, siteViewWidth, siteViewHeight), father: self, site:site)
            
            miniSiteView.delegate = father?.father! as MainView
            
            sites!.append(miniSiteView)
            scroll!.addSubview(miniSiteView)

            xpos = xpos + siteViewWidth
        }
        
        ypos = ypos + siteViewHeight + siteSpacer
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)

        SharedUIManager.instance.miniView_height = siteViewHeight
        SharedUIManager.instance.miniView_width = siteViewWidth
        SharedUIManager.instance.miniView_columns = columns
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        //        println("scrollViewDidScroll")
        manageSitesImageRequest()
    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        //println("scrollViewWillBeginDragging")
        //handlePan(scrollView.panGestureRecognizer)
        var mainView = father!.father! as MainView
        mainView.delegate!.mainView!(mainView, hideMenu: false)
    }
    
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    func scrollViewWillEndDragging(scrollView: UIScrollView!, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //println("scrollViewWillEndDragging")
    }
    
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
//        println("scrollViewDidEndDragging \(decelerate)")
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView!) {
        //println("scrollViewWillBeginDecelerating")
    }// called on finger up as we are moving
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
//        println("scrollViewDidEndDecelerating")
    }// called when scroll view grinds to a halt
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView!) {
        //println("scrollViewDidEndScrollingAnimation")
    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView!) -> Bool {
        //println("scrollViewShouldScrollToTop")
        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView!) {
        //println("scrollViewDidScrollToTops")
    }// called when scrolling animation finished. may be called immediately if already at top
    
    func manageSitesImageRequest(){
        
        if !isWorking { return }
        
        var height = self.siteViewHeight + self.siteSpacer
        var row:Int = Int(floor(self.scroll!.contentOffset.y / height)) + 1

        if lastRowRequested < row {
            
            lastRowRequested = row
            var requestLimit:Int = Int((lastRowRequested + columns) * columns)

            if requestLimit >= sites?.count {
                requestLimit = sites!.count - 1
            }
            

            var i:Int = requestLimit
            var stop:Bool = false
            
            while !stop {

                if i >= siteRequestPreviousLimit {
                    var siteView = sites![i] as SiteMiniView
                    siteView.requestImage()
                    i--
                } else  {
                    stop = true
                }
            }
            
            //Error when archiving: command failed due to signal: segmentation fault: 11
            /*
            for var i = requestLimit; i >= siteRequestPreviousLimit ; i-- {
                //println("requesting for  \(i)")
                var siteView = sites![i] as SiteMiniView
                siteView.requestImage()
            }
            */
            
            siteRequestPreviousLimit = requestLimit + 1
        }
    }
}

//@objc protocol BiinieCategoriesView_SiteContainer_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    //optional func updateCategorControl(view:BiinieCategoriesView_Header,  position:CGFloat)
//}
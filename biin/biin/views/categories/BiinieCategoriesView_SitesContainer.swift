//  BiinieCategoriesView_SitesContainer.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_SitesContainer: BNView, UIScrollViewDelegate {
    
    var isPaused = true
    var category:BNCategory?
    var sites:Array<SiteMiniView>?
    var scroll:UIScrollView?
    
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
        isPaused = false
    }
    
    //Stop all category work, download etc.
    func getToRest(){
        isPaused = true
    }
    
    func addSites() {
        
        var width:CGFloat = 0
        var height:CGFloat = 240
        var xpos:CGFloat = 0
        var ypos:CGFloat = 10.0
        
        var colunmCounter = 1
        var colunms = 2
        var spacer:CGFloat = 10.0
        
        sites = Array<SiteMiniView>()
        
        switch SharedUIManager.instance.deviceType {
        case .iphone4s, .iphone5, .iphone6:
            width = (SharedUIManager.instance.screenWidth - 30) / 2
            break
        case .iphone6Plus:
            width = (SharedUIManager.instance.screenWidth - 40) / 3
            height = SharedUIManager.instance.screenHeight / 4
            colunms = 3
            break
        case .ipad:
            width = (SharedUIManager.instance.screenWidth - 40) / 3
            height = SharedUIManager.instance.screenHeight / 3
            colunms = 3
            break
        default:
            break
        }
        
        
        for var i = 0; i < category?.sitesDetails.count; i++ {
            
            
            if colunmCounter <= colunms {
                colunmCounter++
                xpos = xpos + spacer
                
            } else {
                ypos = ypos + height + spacer
                xpos = spacer
                colunmCounter = 1
            }
            
            
            println("site name for miniview: \(category?.sitesDetails[i].identifier!)")
            var siteIdentifier = category?.sitesDetails[i].identifier!
            var site = BNAppSharedManager.instance.dataManager.sites[ siteIdentifier! ]
            
            var siteView = SiteMiniView(frame: CGRectMake(xpos, ypos, width, height), father: self, site:site)
            
            sites!.append(siteView)
            scroll!.addSubview(siteView)
            
            xpos = xpos + width
        }
        
        ypos = ypos + height + spacer
        println("\(ypos)")
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        //        println("scrollViewDidScroll")
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
        //        println("scrollViewWillEndDragging")
    }
    
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
        //        println("scrollViewDidEndDragging")
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView!) {
        //println("scrollViewWillBeginDecelerating")
    }// called on finger up as we are moving
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        //println("scrollViewDidEndDecelerating")
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
    
}
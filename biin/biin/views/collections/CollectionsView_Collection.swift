//  CollectionsView_Collection.swift
//  biin
//  Created by Esteban Padilla on 2/25/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class CollectionsView_Collection:BNView, UIScrollViewDelegate, SiteView_Delegate, CollectionView_ItemView_Delegate {
    
    var title:UILabel?
    var subTitle:UILabel?
    var scroll:UIScrollView?
    var showcase:BNShowcase?
    
    var isWorking = true
    var spacer:CGFloat = 5
    var columns:Int = 1
    var lastColumnRequested:Int = 0
    var elementRequestPreviousLimit:Int = 0
    
    var items:Array<CollectionView_ItemView>?
    var elements:Array<ElementMiniView>?
    var sites:Array<SiteMiniView>?
    
    var currentPoints = 0
    var timer:NSTimer?
    
    weak var collection:BNCollection?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father:BNView?, collection:BNCollection?) {
        self.init(frame: frame, father:father )
        
        self.collection = collection
        
        self.backgroundColor = UIColor.appMainColor()
        //self.showcase = BNAppSharedManager.instance.dataManager.showcases[showcase!.identifier!]
        //TODO: Add all showcase data here
        
        var ypos:CGFloat = 5
        ypos += 18
        
        title = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.siteView_titleSize + 2)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_titleSize)
        title!.text = self.collection!.title!
        title!.textColor = UIColor.appTextColor()
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_titleSize + 2
        
        subTitle = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 2)))
        subTitle!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        subTitle!.textColor = UIColor.appTextColor()
        subTitle!.text = self.collection!.subTitle!
        self.addSubview(subTitle!)
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        //        var scrollYPos:CGFloat = SharedUIManager.instance.siteView_headerHeight + screenWidth
        var scrollHeight:CGFloat = SharedUIManager.instance.miniView_height + 10
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.elementView_headerHeight, screenWidth, scrollHeight))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.appBackground()
        self.addSubview(scroll!)
        
        //addElementAndSitesViews()
        
        columns = SharedUIManager.instance.miniView_columns
        
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
        
    }
    
    func addElementAndSitesViews(){
        /*
        if let elementsList = self.elements {
            for elementView in elements! {
                elementView.removeFromSuperview()
            }
            
            elements!.removeAll(keepCapacity: false)
        }

        if let siteList = self.sites {
            for siteView in sites! {
                siteView.removeFromSuperview()
            }
            
            sites!.removeAll(keepCapacity: false)
        }

        */
        
        if let itemsList = self.items {
            for itemView in items! {
                itemView.removeFromSuperview()
            }
            
            items!.removeAll(keepCapacity: false)
        }

        
        var itemPosition:Int = 1
        var xpos:CGFloat = spacer
        elementRequestPreviousLimit = 0
        lastColumnRequested = 0
        isWorking = true
        //elements = Array<ElementMiniView>()
//        sites = Array<SiteMiniView>()
        items = Array<CollectionView_ItemView>()
        
        println("collection!.items.count: \(collection!.items.count)")
        
        for item in collection!.items {
            
            var itemView:CollectionView_ItemView?
            //var elementView:ElementMiniView?
            if let element = collection!.elements[item] {
                
                
                itemView = CollectionView_ItemView(frame:CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, element: element, isElement: true, site: nil)
                //elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, element:element, elementPosition: itemPosition, showRemoveBtn: true)
                    //ElementView(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, showBiinItBtn: false)
    
                
            /*} else if let site = collection!.sites[item] {
                
                itemView = CollectionView_ItemView(frame:CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, element: nil, isElement: false, site: site)
            */


            
                if itemPosition < 3 {
                    itemView!.requestImage()
                }
                    

            
                itemView!.collectionScrollPosition = itemPosition
                xpos += SharedUIManager.instance.miniView_width + spacer
                //elementView!.delegate = self
                scroll!.addSubview(itemView!)
                items!.append(itemView!)
    //            elements!.append(elementView!)

            }

        }
        
//        if site!.loyalty!.isSubscribed {
//            //Add game view
//            gameView = Sor iteView_Showcase_Game(frame: CGRectMake(xpos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height + 10), father: self, showcase: showcase!, animatedCircleColor: UIColor.biinColor())
//            scroll!.addSubview(gameView!)
//            xpos += SharedUIManager.instance.screenWidth
//        } else  {
//            joinView = SiteView_Showcase_Join(frame: CGRectMake(xpos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height + 10), father: self, showcase: showcase!)
//            scroll!.addSubview(joinView!)
//            xpos += SharedUIManager.instance.screenWidth
//        }

        xpos += spacer
        
        scroll!.contentSize = CGSizeMake(xpos, 0)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.bounces = false
        scroll!.pagingEnabled = false
    }
    
    override func refresh(){
        addElementAndSitesViews()
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        manageItemViewImageRequest()
    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {

        //handlePan(scrollView.panGestureRecognizer)
        var mainView = father!.father! as! MainView
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

        /*
        if showcase!.isShowcaseGameCompleted {
            return
        }
        
        if site!.loyalty!.isSubscribed {
            
            var isShowcaseGameCompleted = true
            var totalPoints = 0
            currentPoints = 0
            var pointsByElement = 5
            var elementsViewed = 0
            var position = scrollView.bounds.origin.x
            var width = scrollView.contentSize.width
            var showcaseGameWidth = SharedUIManager.instance.screenWidth
            
            println("position: \(scrollView.bounds.origin.x)")
            println("height: \(width)")
            println("showcaseGameHeight: \(showcaseGameWidth)")
            
            if (position >= (width - showcaseGameWidth)){
                
                for (var i = 0; i < self.elements!.count; i++) {
                    if self.elements![i].element!.userViewed {
                        self.gameView!.turnCircleOn((i))
                        elementsViewed++
                        //send userViewElementPost
                    }else {
                        isShowcaseGameCompleted = false
                    }
                }
                
                gameView!.updateYouSeenLbl("\(elementsViewed) of \(self.elements!.count)")
                
                if isShowcaseGameCompleted {
                    totalPoints = self.elements!.count * pointsByElement
                    currentPoints = site!.loyalty!.points
                    self.updatePointCounter()
                    site!.loyalty!.points += totalPoints
                    showcase!.isShowcaseGameCompleted = true
                    father!.changeJoinBtnText("You have \(site!.loyalty!.points) points with us!")
                }
            }
        }
        */
    }// called when scroll view grinds to a halt
    
    /*
    func updatePointCounter() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector:"updatePoints:", userInfo: nil, repeats: true)
    }
    
    func updatePoints(sender:NSTimer){
        
        currentPoints++
        
        if currentPoints <= site!.loyalty!.points {
            //gameView!.updatePointLbl("\(currentPoints)")
            //TODO: update bottom label on site
            (father! as SiteView).updateLoyaltyPoints()
            
        }else {
            timer!.invalidate()
            gameView!.startToAnimateCirclesOnCompleted()
        }
    }
    */
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {

    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {

        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {

    }// called when scrolling animation finished. may be called immediately if already at top
    
    func manageItemViewImageRequest(){
        
        if !isWorking { return }
        
        var width = SharedUIManager.instance.miniView_width + spacer
        var column:Int = Int(floor(self.scroll!.contentOffset.x / width)) + 1
        
        if lastColumnRequested < column {
            
            lastColumnRequested = column
            var requestLimit:Int = Int(lastColumnRequested + columns)
            
            if requestLimit >= collection!.items.count {
                requestLimit = collection!.items.count - 1
                isWorking = false //reach the limit of requests
            }
            
            var i:Int = requestLimit
            var stop:Bool = false
            
            while !stop {
                
                if i >= elementRequestPreviousLimit {
                    
                    
//                    if let element = collection!.elements[collection!.items[i]] {
                        (items![i] as CollectionView_ItemView).requestImage()
                        
                        
//                    } else if let site = collection!.sites[collection!.items[i]] {
                    
//                        var siteView = sites![i] as SiteMiniView
//                        siteView.requestImage()
//                    }
                    
                    i--
                    
                } else  {
                    stop = true
                }
            }
            
            elementRequestPreviousLimit = requestLimit + 1
        }
    }
    
    //ElementMiniView_Delegate
    func showElementView(view:ElementMiniView, position: CGRect) {
        (father! as! CollectionsView).showElementView(view)
    }
    
    func resizeScrollOnRemoved(view:CollectionView_ItemView) {
        var startPosition = 0
        /*
        for var i = 0; i < elements!.count; i++ {
            if elements![i].header!.elementPosition! == view.header!.elementPosition! {
                startPosition = i
                elements!.removeAtIndex(i)
            }
        }
        */
        for var i = 0; i < items!.count; i++ {
            if items![i].collectionScrollPosition == view.collectionScrollPosition {
                startPosition = i
                items!.removeAtIndex(i)
            }
        }
        
        var width:CGFloat = (SharedUIManager.instance.miniView_width + spacer)
        var xpos:CGFloat = (width * CGFloat(startPosition)) + spacer
        
        /*
        for var i = startPosition; i < elements!.count; i++ {
            UIView.animateWithDuration(0.2, animations: {()->Void in
                self.elements![i].frame.origin.x = xpos
            })
            
            xpos += SharedUIManager.instance.miniView_width + spacer
        }
        */
        
        for var i = startPosition; i < items!.count; i++ {
            UIView.animateWithDuration(0.2, animations: {()->Void in
                self.items![i].frame.origin.x = xpos
            })
            
            xpos += SharedUIManager.instance.miniView_width + spacer
        }
        
        xpos += spacer
        
        //        if site!.loyalty!.isSubscribed {
        //            //Add game view
        //            gameView = SiteView_Showcase_Game(frame: CGRectMake(xpos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height + 10), father: self, showcase: showcase!, animatedCircleColor: UIColor.biinColor())
        //            scroll!.addSubview(gameView!)
        //            xpos += SharedUIManager.instance.screenWidth
        //        } else  {
        //            joinView = SiteView_Showcase_Join(frame: CGRectMake(xpos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height + 10), father: self, showcase: showcase!)
        //            scroll!.addSubview(joinView!)
        //            xpos += SharedUIManager.instance.screenWidth
        //        }
        
        scroll!.contentSize = CGSizeMake(xpos, 0)
        //scroll!.setContentOffset(CGPointZero, animated: false)
        //scroll!.bounces = false
        //scroll!.pagingEnabled = false
        
    }

}


//  CollectionsView_Collection.swift
//  biin
//  Created by Esteban Padilla on 2/25/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class CollectionsView_Collection:BNView, UIScrollViewDelegate, ElementMiniView_Delegate {
    
    var title:UILabel?
    var subTitle:UILabel?
    var scroll:UIScrollView?
    var showcase:BNShowcase?
    
    var isWorking = true
    var spacer:CGFloat = 5
    var columns:Int = 1
    var lastColumnRequested:Int = 0
    var elementRequestPreviousLimit:Int = 0
    
//    var items:Array<CollectionView_ItemView>?
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
    
    required init?(coder aDecoder: NSCoder) {
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
        
        var ypos:CGFloat = 3
        
        title = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteView_titleSize)
        title!.text = self.collection!.title!
        title!.textColor = UIColor.biinColor()
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_titleSize + 3
        
        subTitle = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 3)))
        subTitle!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        subTitle!.textColor = UIColor.appTextColor()
        subTitle!.text = self.collection!.subTitle!
        self.addSubview(subTitle!)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        
        //        var scrollYPos:CGFloat = SharedUIManager.instance.siteView_headerHeight + screenWidth
        let scrollHeight:CGFloat = SharedUIManager.instance.miniView_height + 10
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
    
    //Instance methods
    func updateForSite(site: BNSite?){
        
    }
    
    func addElementAndSitesViews(){

        if let _ = self.elements {
            for elementView in elements! {
                elementView.removeFromSuperview()
            }
            
            elements!.removeAll(keepCapacity: false)
        }
        //var itemPosition:Int = 1
        var xpos:CGFloat = spacer
        elementRequestPreviousLimit = 0
        lastColumnRequested = 0
        isWorking = true
        elements = Array<ElementMiniView>()
        /*
        for (_, value) in collection!.elements {
            
            
            if let element = BNAppSharedManager.instance.dataManager.elements[value._id!] {

                //var itemView:CollectionView_ItemView?
                var elementView:ElementMiniView?
                //if let element = collection!.elements[key] {
                    
                    
                    //itemView = CollectionView_ItemView(frame:CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, element: element, isElement: true, site: nil)
                    elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, element:element, elementPosition: itemPosition, showRemoveBtn: true, isNumberVisible:false, showlocation:true)
                        //ElementView(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, showBiinItBtn: false)
        
                    
                /*} else if let site = collection!.sites[item] {
                    
                    itemView = CollectionView_ItemView(frame:CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, element: nil, isElement: false, site: site)
                */


                
                    //if itemPosition < 3 {
                        elementView!.requestImage()
                    //}
                        

                
                    elementView!.collectionScrollPosition = itemPosition
                    elementView!.delegate = self
                    xpos += SharedUIManager.instance.miniView_width + spacer
                    //elementView!.delegate = self
                    scroll!.addSubview(elementView!)
                    //items!.append(itemView!)
                    elements!.append(elementView!)
                    itemPosition += 1
                //}
            } else {

            }
        }
        */
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
        //manageItemViewImageRequest()
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
    
    func manageItemViewImageRequest(){
        
        if !isWorking { return }
        
        if  self.elements == nil { return }
        
        let width = SharedUIManager.instance.miniView_width + spacer
        let column:Int = Int(floor(self.scroll!.contentOffset.x / width)) + 1
        
        if lastColumnRequested < column {
            
            lastColumnRequested = column
            var requestLimit:Int = Int(lastColumnRequested + columns)
            
            if requestLimit >= self.elements!.count {
                requestLimit = self.elements!.count - 1
                isWorking = false //reach the limit of requests
            }
            
            var i:Int = requestLimit
            var stop:Bool = false
            
            while !stop {
                
                if i >= elementRequestPreviousLimit {
                    
                        (elements![i] as ElementMiniView).requestImage()

                    i -= 1
                    
                } else  {
                    stop = true
                }
            }
            
            elementRequestPreviousLimit = requestLimit + 1
        }
    }
    
    //ElementMiniView_Delegate
    func showElementView(viewiew: ElementMiniView, element: BNElement) {
        (father! as! CollectionsView).showElementView(element)
    }
    
    func resizeScrollOnRemoved(view:ElementMiniView) {
        var startPosition = 0
        
        var i:Int = 0
        for _ in self.elements! {
//        for var i = 0; i < self.elements!.count; i++ {
            if self.elements![i].collectionScrollPosition == view.collectionScrollPosition {
                startPosition = i
                self.elements!.removeAtIndex(i)
            }
            i += 1
        }
        
        
        let width:CGFloat = (SharedUIManager.instance.miniView_width + spacer)
        var xpos:CGFloat = (width * CGFloat(startPosition)) + spacer

        i = startPosition
        for _ in self.elements! {
//        for var i = startPosition; i < self.elements!.count; i++ {
            
            UIView.animateWithDuration(0.2, animations: {()->Void in
                self.elements![i].frame.origin.x = xpos
            })
            
            i += 1
            xpos += SharedUIManager.instance.miniView_width + spacer
        }

        xpos += spacer
        
        
        scroll!.contentSize = CGSizeMake(xpos, 0)
        
    }

}


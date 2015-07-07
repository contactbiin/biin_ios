//  BiinieCategoriesView_HighlightsContainer.swift
//  biin
//  Created by Esteban Padilla on 5/19/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_HighlightsContainer: BNView, UIScrollViewDelegate, ElementMiniView_Delegate {
    
    //var delegate:BiinieCategoriesView_SiteContainer_Delegate?
    
    var isWorking = false
    var category:BNCategory?
    var elements:Array<ElementMiniView>?
    var scroll:UIScrollView?
    var isScrollDecelerating = false
    
    var siteViewHeight:CGFloat = 0
    var siteViewWidth:CGFloat = 0
    var siteSpacer:CGFloat = 10.0
    var columns:Int = 2
    //    var siteRequestIndex:Int = 0
    var siteRequestPreviousLimit:Int = 0
    
    
    var lastRowRequested:Int = 0
    
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
    
    convenience init(frame: CGRect, father: BNView?, allElements:Bool) {
        self.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appBackground()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        scroll = UIScrollView(frame:CGRectMake(0, 0, screenWidth, (screenHeight - (SharedUIManager.instance.categoriesHeaderHeight + 20))))
        //        scroll!.backgroundColor = UIColor.biinColor()
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.delegate = self
        scroll!.bounces = false
        self.addSubview(scroll!)
        
        updateHighlights()
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
    
    //instance methods
    //Start all category work, download etc.
    override func getToWork(){
        isWorking = true
        manageSitesImageRequest()
        //println("\(category!.identifier!) is working")
    }
    
    //Stop all category work, download etc.
    override func getToRest(){
        isWorking = false
        //println("\(category!.identifier!) is resting")
    }
    
    
    func updateHighlights(){
        
        lastRowRequested = 0
        siteRequestPreviousLimit = 0
   
        var xpos:CGFloat = 0
        var ypos:CGFloat = siteSpacer
        
        var columnCounter = 0
        
        if elements != nil {
            for elementView in elements! {
                elementView.removeFromSuperview()
            }
            
            elements!.removeAll(keepCapacity: false)
            
        } else {
            elements = Array<ElementMiniView>()
        }
        switch SharedUIManager.instance.deviceType {
        case .iphone4s, .iphone5, .iphone6:
            siteViewWidth = (SharedUIManager.instance.screenWidth - 30) / 2
            siteViewHeight = 280.0
            columns = 2
            break
        case .iphone6Plus:
            siteViewWidth = (SharedUIManager.instance.screenWidth - 30) / 2
            siteViewHeight = (SharedUIManager.instance.screenHeight / 3) + 50
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
        
        
        var sitesArray:Array<BNSite> = Array<BNSite>()
        
        for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
            if category.hasSites {
                for var i = 0; i < category.sitesDetails.count; i++ {
                    
                    var siteIdentifier = category.sitesDetails[i].identifier!
                    var site = BNAppSharedManager.instance.dataManager.sites[ siteIdentifier ]
                    
                    if site!.showcases != nil {
                        sitesArray.append(site!)
                    }
                }
            }
        }
        
        sitesArray = sorted(sitesArray){ $0.biinieProximity < $1.biinieProximity  }
        
        for site in sitesArray {
            for showcase in site.showcases! {
                for element in showcase.elements {
                    
                    var elementData = BNAppSharedManager.instance.dataManager.elements[element._id!]
                    
                    if elementData!.isHighlight {
                    
                        if columnCounter < columns {
                            columnCounter++
                            xpos = xpos + siteSpacer
                            
                        } else {
                            ypos = ypos + siteViewHeight + siteSpacer
                            xpos = siteSpacer
                            columnCounter = 1
                        }
                        
                        var elementMiniView = ElementMiniView(frame: CGRectMake(xpos, ypos, siteViewWidth, siteViewHeight), father: self, element: elementData, elementPosition: 0, showRemoveBtn: false, isNumberVisible:false, isHighlight:true)
                        
                        if columnCounter < 3 {
                            elementMiniView.requestImage()
                        }
                        
                        elementMiniView.delegate = self
                        elements!.append(elementMiniView)
                        scroll!.addSubview(elementMiniView)
                        xpos = xpos + siteViewWidth
                    }
                }
            }
        }
        
        ypos = ypos + siteViewHeight + siteSpacer
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
        
        SharedUIManager.instance.miniView_height = siteViewHeight
        SharedUIManager.instance.miniView_width = siteViewWidth
        SharedUIManager.instance.miniView_columns = columns
        
        getToWork()
    }
    
    override func refresh() {
        //updateHighlights()
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //        println("scrollViewDidScroll")
        manageSitesImageRequest()
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
    }// called when scroll view grinds to a halt
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }// called when scrolling animation finished. may be called immediately if already at top
    
    
    func manageSitesImageRequest(){
        
        if !isWorking { return }
        
        if elements?.count > 0 {
            
            var height = self.siteViewHeight + self.siteSpacer
            var row:Int = Int(floor(self.scroll!.contentOffset.y / height)) + 1
            
            if lastRowRequested < row {
                
                lastRowRequested = row
                var requestLimit:Int = Int((lastRowRequested + columns) * columns)
                
                if requestLimit >= elements?.count {
                    requestLimit = elements!.count - 1
                }
                
                
                var i:Int = requestLimit
                var stop:Bool = false
                
                while !stop {
                    
                    if i >= siteRequestPreviousLimit {
                        var siteView = elements![i] as ElementMiniView
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
    
    //ElementMiniView_Delegate
    func showElementView(view:ElementMiniView, position: CGRect) {
        (father! as! BiinieCategoriesView).showElementView(view)
    }
}

//@objc protocol BiinieCategoriesView_SiteContainer_Delegate:NSObjectProtocol {
///Update categories icons on header
//optional func updateCategorControl(view:BiinieCategoriesView_Header,  position:CGFloat)
//}

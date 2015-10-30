//  BiinieCategoriesView_BiinsContainer.swift
//  biin
//  Created by Esteban Padilla on 5/19/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_BiinsContainer: BNView, UIScrollViewDelegate, ElementMiniView_Delegate {
    
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
    
    var notBiinsView:BNView_NoBiinAvailableSign?
    
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
    
    convenience init(frame: CGRect, father: BNView?, allElements:Bool) {
        self.init(frame: frame, father:father)
        
        self.backgroundColor = UIColor.appBackground()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        scroll = UIScrollView(frame:CGRectMake(0, 0, screenWidth, (screenHeight - (SharedUIManager.instance.categoriesHeaderHeight + 20))))
        //        scroll!.backgroundColor = UIColor.biinColor()
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.delegate = self
        scroll!.bounces = false
        self.addSubview(scroll!)
        
        updateContainer()
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
    
    
    func updateContainer(){
        
        if BNAppSharedManager.instance.dataManager.availableBiins.count > 0 {
            
            if notBiinsView != nil {
                notBiinsView!.alpha = 0
            }
            
            var xpos:CGFloat = 0
            var ypos:CGFloat = siteSpacer
            
            var columnCounter = 0
            
            if elements != nil {
                for view in elements! {
                    view.removeFromSuperview()
                }
            }
            
            elements = Array<ElementMiniView>()
            
            switch SharedUIManager.instance.deviceType {
            case .iphone4s, .iphone5, .iphone6:
                siteViewWidth = (SharedUIManager.instance.screenWidth - 30) / 2
                siteViewHeight = 240.0
                columns = 2
                break
            case .iphone6Plus:
//                siteViewWidth = (SharedUIManager.instance.screenWidth - 40) / 3
//                siteViewHeight = SharedUIManager.instance.screenHeight / 4
                
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
            
            for value in BNAppSharedManager.instance.dataManager.availableBiins {
                
                let element = BNAppSharedManager.instance.dataManager.elements[value]
                
                //for var i = 0; i < category.sitesDetails.count; i++ {
                
                if columnCounter < columns {
                    columnCounter++
                    xpos = xpos + siteSpacer
                    
                } else {
                    ypos = ypos + siteViewHeight + siteSpacer
                    xpos = siteSpacer
                    columnCounter = 1
                }
                
                //var siteIdentifier = category.sitesDetails[i].identifier!
                //var site = BNAppSharedManager.instance.dataManager.sites[ siteIdentifier ]
                
                //var miniSiteView = SiteMiniView(frame: CGRectMake(xpos, ypos, siteViewWidth, siteViewHeight), father: self, site:site)
                let elementMiniView = ElementMiniView(frame: CGRectMake(xpos, ypos, siteViewWidth, siteViewHeight), father: self, element: element, elementPosition: 0, showRemoveBtn: false, isNumberVisible:false, isHighlight:true)
                
                elementMiniView.delegate = self
                elements!.append(elementMiniView)
                scroll!.addSubview(elementMiniView)
                
                if columnCounter < 3 {
                    elementMiniView.requestImage()
                }
                
                xpos = xpos + siteViewWidth
                //}
            }
            
            ypos = ypos + siteViewHeight + siteSpacer
            scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
            
//            SharedUIManager.instance.miniView_height = siteViewHeight
//            SharedUIManager.instance.miniView_width = siteViewWidth
//            SharedUIManager.instance.miniView_columns = columns
            
        } else {
            //Show not biins view
            if notBiinsView == nil {
                
                let xpos = (( SharedUIManager.instance.screenWidth - 170) / 2 )
                let ypos = (( SharedUIManager.instance.screenHeight / 4 ))
                
                notBiinsView = BNView_NoBiinAvailableSign(frame: CGRectMake(0, 0, self.frame.width, self.frame.height), color: UIColor.appButtonColor_Disable(), iconPosition: CGPointMake(xpos, ypos))
                self.addSubview(notBiinsView!)
                
            } else  {
                notBiinsView!.alpha = 1
                
                if elements != nil {
                    
                    for view in elements! {
                        view.removeFromSuperview()
                    }
                    
                    elements!.removeAll(keepCapacity: false)
                    elements = nil
                }
                
            }
        }
    }
    
    override func refresh() {
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //        println("scrollViewDidScroll")
        manageSitesImageRequest()
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
    
    
    func manageSitesImageRequest(){
        
        if !isWorking { return }
        
        if elements != nil {
        
            let height = self.siteViewHeight + self.siteSpacer
            let row:Int = Int(floor(self.scroll!.contentOffset.y / height)) + 1
            
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
                        let siteView = elements![i] as ElementMiniView
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
    
    func showElementView(element:BNElement) {
        (father! as! BiinieCategoriesView).showElementView(element)
    }
}

//@objc protocol BiinieCategoriesView_SiteContainer_Delegate:NSObjectProtocol {
///Update categories icons on header
//optional func updateCategorControl(view:BiinieCategoriesView_Header,  position:CGFloat)
//}
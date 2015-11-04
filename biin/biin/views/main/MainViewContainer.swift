//  MainViewContainer.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainViewContainer: BNView, UIScrollViewDelegate, MainViewDelegate_HighlightsContainer, MainViewDelegate_BiinsContainer {
    
    var header:BiinieCategoriesView_Header?
    var inSiteView:InSiteView?
    var highlightContainer:MainViewContainer_Highlights?
    var sitesContainer:MainViewContainer_Sites?
    var bannerContainer:MainViewContainer_Banner?
    var elementContainers:Array <MainViewContainer_Elements>?

    var scroll:UIScrollView?
    
    var fade:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appBackground()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        scroll = UIScrollView(frame:CGRectMake(0, 0, screenWidth, (screenHeight - 20)))
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.delegate = self
        self.addSubview(scroll!)
        
        inSiteView = InSiteView(frame: CGRectMake(0, (screenHeight - 20), screenWidth, SharedUIManager.instance.inSiteView_Height), father: self)
        inSiteView!.delegate = BNAppSharedManager.instance.mainViewController!.mainView!
        self.addSubview(inSiteView!)
        
        header = BiinieCategoriesView_Header(frame: CGRectMake(0, (screenHeight - (SharedUIManager.instance.categoriesHeaderHeight + 20)), screenWidth, SharedUIManager.instance.categoriesHeaderHeight), father: self)
        self.addSubview(header!)
        
        fade = UIView(frame: frame)
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        
        elementContainers = Array<MainViewContainer_Elements>()
        
        updateContainer()
    }
    
    func updateContainer(){
        
        let screenWidth = SharedUIManager.instance.screenWidth
        //let screenHeight = SharedUIManager.instance.screenHeight
        var ypos:CGFloat = 0
        let spacer:CGFloat = 0
        
        SharedUIManager.instance.highlightContainer_Height = SharedUIManager.instance.screenWidth + SharedUIManager.instance.sitesContainer_headerHeight

        self.highlightContainer = MainViewContainer_Highlights(frame: CGRectMake(0, ypos, screenWidth, (SharedUIManager.instance.highlightContainer_Height + SharedUIManager.instance.highlightView_headerHeight)), father: self)
        self.scroll!.addSubview(self.highlightContainer!)
        ypos += (SharedUIManager.instance.highlightContainer_Height + SharedUIManager.instance.highlightView_headerHeight + spacer)

        let sitesContainerHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.sitesContainer_headerHeight + SharedUIManager.instance.siteMiniView_headerHeight + 1
        

        self.sitesContainer = MainViewContainer_Sites(frame: CGRectMake(0, ypos, screenWidth, sitesContainerHeight), father: self)
        self.sitesContainer!.delegate = (self.father! as! MainView)
        self.scroll!.addSubview(self.sitesContainer!)
        ypos += sitesContainerHeight

        
        self.bannerContainer = MainViewContainer_Banner(frame: CGRectMake(0, ypos, screenWidth, SharedUIManager.instance.bannerContainer_Height), father: self)
        self.scroll!.addSubview(self.bannerContainer!)
        ypos += (SharedUIManager.instance.bannerContainer_Height + spacer)
        
        
        var colorIndex:Int = 0
        for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
            
            if isThereElementsInCategory(category) {
                
                let elementContainer = MainViewContainer_Elements(frame: CGRectMake(0, ypos, screenWidth, SharedUIManager.instance.elementContainer_Height), father: self, category:category, colorIndex:colorIndex)
                elementContainer.delegate = (self.father! as! MainView)
                ypos += (SharedUIManager.instance.elementContainer_Height + spacer)
                self.scroll!.addSubview(elementContainer)
                self.elementContainers!.append(elementContainer)
                
                colorIndex++
                if colorIndex  > 1 {
                    colorIndex = 0
                }
            }
        
        }
    

        self.scroll!.backgroundColor = UIColor.darkGrayColor()
        
        ypos += SharedUIManager.instance.categoriesHeaderHeight
        scroll!.contentSize = CGSize(width: screenWidth, height: ypos)
        
    }
    
    func isThereElementsInCategory (category:BNCategory) ->Bool {
        
        if category.hasSites {
            if category.elements.count > 0 {
                return true
            }
        } 
        
        return false
    }
    
    
    func showMenuBtnActon(sender:BNUIButton) {
        (father as! MainView).showMenu(UIScreenEdgePanGestureRecognizer())
    }
    
    override func transitionIn() {
        
        UIView.animateWithDuration(0.5, animations: {()->Void in
            self.fade!.alpha = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        
        UIView.animateWithDuration(0.1, animations: {()->Void in
            self.fade!.alpha = 0.5
        })
        
        state!.action()
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
    
    override func refresh() {
//        for view in categorySitesContainers! {
//            view.refresh()
//        }
    }

    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //update header delegate categories control.
        //headerDelegate!.updateCategoriesControl!(self, position: scrollView.contentOffset.x)
    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //handlePan(scrollView.panGestureRecognizer)
        let mainView = father! as! MainView
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
    
    func showInSiteView(site:BNSite?){
        
        inSiteView!.updateForSite(site!)
        
        UIView.animateWithDuration(0.25, animations: {()-> Void in
            self.inSiteView!.frame.origin.y = ( SharedUIManager.instance.screenHeight - (SharedUIManager.instance.inSiteView_Height + SharedUIManager.instance.categoriesHeaderHeight + 20 ))
            
            //self.header!.frame.origin.y = (SharedUIManager.instance.screenHeight - (SharedUIManager.instance.categoriesHeaderHeight + SharedUIManager.instance.inSiteView_Height + 20))
        })
    }
    
    func hideInSiteView(){
        
        UIView.animateWithDuration(0.25, animations: {()-> Void in
            self.inSiteView!.frame.origin.y = (SharedUIManager.instance.screenHeight - 20)
            //self.header!.frame.origin.y = SharedUIManager.instance.screenHeight - (SharedUIManager.instance.categoriesHeaderHeight + 20)
        })
    }
    
    func clean(){
        
        if highlightContainer != nil {
            highlightContainer!.clean()
            highlightContainer!.removeFromSuperview()
        }
        
        if sitesContainer != nil {
            sitesContainer!.clean()
            sitesContainer!.removeFromSuperview()
        }
        
        if bannerContainer != nil {
            bannerContainer!.clean()
            bannerContainer!.removeFromSuperview()
        }
        
        if inSiteView != nil {
            inSiteView!.clean()
            inSiteView!.removeFromSuperview()
        }
        
        if header != nil {
            header!.clean()
            header!.removeFromSuperview()
        }
        
        if elementContainers?.count > 0 {
            
            for elementContainer in elementContainers! {
                elementContainer.clean()
                elementContainer.removeFromSuperview()
            }
            
            elementContainers!.removeAll(keepCapacity: false)
        }
        
        elementContainers = nil
        scroll!.removeFromSuperview()
        fade!.removeFromSuperview()
    }
}

//@objc protocol BiinieCategoriesView_Delegate:NSObjectProtocol {
//    ///Update categories icons on header
//    optional func updateCategoriesPoints(view:BiinieCategoriesView, index:Int)
//    optional func updateCategoriesControl(view:BiinieCategoriesView,  position:CGFloat)
//}

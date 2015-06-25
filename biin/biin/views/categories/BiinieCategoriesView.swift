//  BiinieCategoriesView.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView: BNView, UIScrollViewDelegate, ElementView_Delegate, MainViewDelegate_HighlightsContainer, MainViewDelegate_BiinsContainer {
    
    var headerDelegate:BiinieCategoriesView_Delegate?
    
    //var container:CategoriesView_Container?
    var header:BiinieCategoriesView_Header?
    var categorySitesContainers:Array <BNView>?
    var panIndex = 0
    var numberOfCategories = 0
    
    var scroll:UIScrollView?
    
    var highlightsContainer:BiinieCategoriesView_HighlightsContainer?
    var biinsContainer:BiinieCategoriesView_BiinsContainer?
    
    var fade:UIView?
    
//    override init() {
//        super.init()
//    }
    
    var elementView:ElementView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appBackground()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        scroll = UIScrollView(frame:CGRectMake(0, SharedUIManager.instance.categoriesHeaderHeight, screenWidth, (screenHeight - SharedUIManager.instance.categoriesHeaderHeight)))
        
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.delegate = self
        self.addSubview(scroll!)
        
        //addCategoriesSitesContainers()
        
        //HACK: This hack is to show all sites on one category and remove the call to the method before.
        addSitesToOneContainer()
        
        addHightlightsContainer()
        
        addRangedBiinsContainer()
        
        header = BiinieCategoriesView_Header(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.categoriesHeaderHeight), father: self)
        headerDelegate = header
        self.addSubview(header!)
        
        fade = UIView(frame: frame)
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        elementView = ElementView(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight), father: self, showBiinItBtn:true)
        elementView!.delegate = self
        self.addSubview(elementView!)
    }
    
    func showMenuBtnActon(sender:BNUIButton) {
        (father as! MainView).showMenu(UIScreenEdgePanGestureRecognizer())
    }
    
    override func transitionIn() {
        
        UIView.animateWithDuration(0.4, animations: {()->Void in
            self.fade!.alpha = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        
        UIView.animateWithDuration(0.2, animations: {()->Void in
            self.fade!.alpha = 0.25
        })
        
        state!.action()
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
    func addCategoriesSitesContainers(){

        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        var sitesContainerHeight = screenHeight - SharedUIManager.instance.categoriesHeaderHeight
        
        var xpos:CGFloat = 0.0
        var counter = 0
        
        categorySitesContainers?.removeAll(keepCapacity: false)
        categorySitesContainers = Array<BNView>()
        
        numberOfCategories = BNAppSharedManager.instance.dataManager.bnUser!.categories.count
        
        //Sets all user categories on section for further use
        //BNAppSharedManager.instance.dataManager.loadUserSections()
        
        println("BiinieCategoriesView: \(BNAppSharedManager.instance.dataManager.bnUser!.categories.count)")

        
        for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
            
            var frame = CGRectMake(xpos, 0, screenWidth, sitesContainerHeight)
            var sitesContainer = BiinieCategoriesView_SitesContainer(frame: frame, father: self, category:category)
            
            categorySitesContainers!.append(sitesContainer)
            scroll!.addSubview(sitesContainer)
            
            if counter == ( numberOfCategories - 1 ){
                xpos += screenWidth
            }else {
                xpos += screenWidth + SharedUIManager.instance.spacer
            }
            
           
            
            counter++
            
//            if counter == 4 {
//                showFx = true
//            } else {
//                showFx = false
//            }
        }
        
        scroll!.contentSize = CGSizeMake(xpos, 316)
        scroll!.pagingEnabled = true
        
        if categorySitesContainers!.count > 0 {
            categorySitesContainers![0].getToWork()
            //categorySitesContainers![0].manageSitesImageRequest()
        }
        
    }
    
    func addSitesToOneContainer(){
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        var sitesContainerHeight = screenHeight - SharedUIManager.instance.categoriesHeaderHeight
        
        var xpos:CGFloat = 0.0
        var counter = 0
        
        categorySitesContainers?.removeAll(keepCapacity: false)
        categorySitesContainers = Array<BiinieCategoriesView_SitesContainer>()
        
        numberOfCategories = BNAppSharedManager.instance.dataManager.bnUser!.categories.count
        
        //Sets all user categories on section for further use
        //BNAppSharedManager.instance.dataManager.loadUserSections()
        
        println("BiinieCategoriesView: \(BNAppSharedManager.instance.dataManager.bnUser!.categories.count)")
        println("Categories backup \(BNAppSharedManager.instance.biinieCategoriesBckup.count)")

        
        //for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
            
            var frame = CGRectMake(xpos, 0, screenWidth, sitesContainerHeight)
            var sitesContainer = BiinieCategoriesView_SitesContainer(frame: frame, father: self, allSites: true) //BiinieCategoriesView_SitesContainer(frame: frame, father: self, category:category)
            
            categorySitesContainers!.append(sitesContainer)
            scroll!.addSubview(sitesContainer)
            
            if counter == ( numberOfCategories - 1 ){
                xpos += screenWidth
            }else {
                xpos += screenWidth + SharedUIManager.instance.spacer
            }
            
            
            
            //counter++
            
            //            if counter == 4 {
            //                showFx = true
            //            } else {
            //                showFx = false
            //            }
        //}
        
        scroll!.contentSize = CGSizeMake(xpos, 316)
        scroll!.pagingEnabled = true
        
        if categorySitesContainers!.count > 0 {
            categorySitesContainers![0].getToWork()
            //categorySitesContainers![0].manageSitesImageRequest()
        }
    }
    
    func addHightlightsContainer() {

        //var counter = 0
        
        //categorySitesContainers?.removeAll(keepCapacity: false)
        //categorySitesContainers = Array<BiinieCategoriesView_SitesContainer>()
        
        //numberOfCategories = BNAppSharedManager.instance.dataManager.bnUser!.categories.count
        
        //Sets all user categories on section for further use
        //BNAppSharedManager.instance.dataManager.loadUserSections()
        
        //println("BiinieCategoriesView: \(BNAppSharedManager.instance.dataManager.bnUser!.categories.count)")
        //println("Categories backup \(BNAppSharedManager.instance.biinieCategoriesBckup.count)")
        
        
        //for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
        
        if highlightsContainer == nil {
            
            var screenWidth = SharedUIManager.instance.screenWidth
            var screenHeight = SharedUIManager.instance.screenHeight
            var sitesContainerHeight = screenHeight - SharedUIManager.instance.categoriesHeaderHeight
            
            var xpos:CGFloat = screenWidth + 1
            
            var frame = CGRectMake(xpos, 0, screenWidth, sitesContainerHeight)
            highlightsContainer = BiinieCategoriesView_HighlightsContainer(frame: frame, father: self, allElements: true)
            //BiinieCategoriesView_SitesContainer(frame: frame, father: self, category:category)
            
            categorySitesContainers!.append(highlightsContainer!)
            scroll!.addSubview(highlightsContainer!)
            
            //if counter == ( numberOfCategories - 1 ){
            //    xpos += screenWidth
            //}else {
            //    xpos += screenWidth + SharedUIManager.instance.spacer
            //}
            
            
            
            //counter++
            
            //            if counter == 4 {
            //                showFx = true
            //            } else {
            //                showFx = false
            //            }
            //}
            xpos += screenWidth
            scroll!.contentSize = CGSizeMake(xpos, 316)
            scroll!.pagingEnabled = true
        }
        
        //if categorySitesContainers!.count > 0 {
          //  categorySitesContainers![0].getToWork()
            //categorySitesContainers![0].manageSitesImageRequest()
        //}
    }
    
    func addRangedBiinsContainer() {
        
        if biinsContainer == nil {
            var screenWidth = SharedUIManager.instance.screenWidth
            var screenHeight = SharedUIManager.instance.screenHeight
            var sitesContainerHeight = screenHeight - SharedUIManager.instance.categoriesHeaderHeight
            
            var xpos:CGFloat = screenWidth + 2
            //var counter = 0
            
            //categorySitesContainers?.removeAll(keepCapacity: false)
            //categorySitesContainers = Array<BiinieCategoriesView_SitesContainer>()
            
            //numberOfCategories = BNAppSharedManager.instance.dataManager.bnUser!.categories.count
            
            //Sets all user categories on section for further use
            //BNAppSharedManager.instance.dataManager.loadUserSections()
            
            //println("BiinieCategoriesView: \(BNAppSharedManager.instance.dataManager.bnUser!.categories.count)")
            //println("Categories backup \(BNAppSharedManager.instance.biinieCategoriesBckup.count)")
            
            
            //for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {

            xpos += screenWidth
            var frame = CGRectMake(xpos, 0, screenWidth, sitesContainerHeight)
            biinsContainer = BiinieCategoriesView_BiinsContainer(frame: frame, father: self, allElements: true)
            //BiinieCategoriesView_SitesContainer(frame: frame, father: self, category:category)
            
            categorySitesContainers!.append(biinsContainer!)
            scroll!.addSubview(biinsContainer!)
            
            //if counter == ( numberOfCategories - 1 ){
            //    xpos += screenWidth
            //}else {
            //    xpos += screenWidth + SharedUIManager.instance.spacer
            //}
            
            
            
            //counter++
            
            //            if counter == 4 {
            //                showFx = true
            //            } else {
            //                showFx = false
            //            }
            //}
            xpos += screenWidth
            scroll!.contentSize = CGSizeMake(xpos, 316)
            scroll!.pagingEnabled = true
            
            //if categorySitesContainers!.count > 0 {
            //  categorySitesContainers![0].getToWork()
            //categorySitesContainers![0].manageSitesImageRequest()
            //}
        }
    }
    
    func showNotification(){
        header!.showNotification()
    }
    
    func hideNotification(){
        header!.hideNotification()
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //update header delegate categories control.
        headerDelegate!.updateCategoriesControl!(self, position: scrollView.contentOffset.x)
    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //handlePan(scrollView.panGestureRecognizer)
        var mainView = father! as! MainView
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
        
        var width = SharedUIManager.instance.screenWidth
        var page:Int = Int(floor(scrollView.contentOffset.x / width))
        
        if page < 0 {
            return
        }
        
        width = width + 1
        var xpos:CGFloat = CGFloat(page) * width
        var position = CGPointMake(xpos, 0)
        
        scroll!.setContentOffset(position, animated: true)
        
        if page != panIndex {
            
            panIndex = page
            println("change categories to \(panIndex)")
            
            for container in categorySitesContainers! {
                container.getToRest()
            }
            
            categorySitesContainers![panIndex].getToWork()
            headerDelegate!.updateCategoriesPoints!(self, index:panIndex)
//            self.bottomViewDelegate!.changedSection!(self, sectionIndex:self.panIndex)
//            self.sectionsViewDelegate!.changedPoint!(self, pointIndex: self.panIndex)
            
        }
        
    }// called when scroll view grinds to a halt
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
    }// called when scrolling animation finished. may be called immediately if already at top

    func showElementView(elementMiniView:ElementMiniView?){
        
        println("BiinieCategoriesView.showElementView()")
        
        elementView!.updateElementData(elementMiniView)
        
        UIView.animateWithDuration(0.3, animations: {()-> Void in
            self.elementView!.frame.origin.x = 0
            self.fade!.alpha = 0.25
        })
    }
    
    func hideElementView(view:ElementMiniView?) {
        UIView.animateWithDuration(0.4, animations: {() -> Void in
            self.elementView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
            }, completion: {(completed:Bool)-> Void in
                
                if !view!.element!.userViewed {
                    view!.userViewedElement()
                }
                
                self.elementView!.clean()
        })
    }
    
    
    func updateHighlightsContainer(view: MainView, update: Bool) {
        println("updateHighlightsContainer() in BiinieCategoriesView")
        highlightsContainer!.updateHighlights()
    }
    
    func updateBiinsContainer(view: MainView, update: Bool) {
        println("updateBiinsContainer() in BiinieCategoriesView")
        biinsContainer!.updateContainer()
    }
}

@objc protocol BiinieCategoriesView_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func updateCategoriesPoints(view:BiinieCategoriesView, index:Int)
    optional func updateCategoriesControl(view:BiinieCategoriesView,  position:CGFloat)
}
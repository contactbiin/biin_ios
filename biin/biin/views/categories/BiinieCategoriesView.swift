//  BiinieCategoriesView.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView: BNView, UIScrollViewDelegate {
    
    var headerDelegate:BiinieCategoriesView_Delegate?
    
    //var container:CategoriesView_Container?
    var header:BiinieCategoriesView_Header?
    var categorySitesContainers:Array <BiinieCategoriesView_SitesContainer>?
    var panIndex = 0
    var numberOfCategories = 0
    
    var scroll:UIScrollView?
    
    var fade:UIView?
    
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
        
        self.backgroundColor = UIColor.appBackground()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        scroll = UIScrollView(frame:CGRectMake(0, SharedUIManager.instance.categoriesHeaderHeight, screenWidth, (screenHeight - SharedUIManager.instance.categoriesHeaderHeight)))
        
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.delegate = self
        self.addSubview(scroll!)
        
        addCategoriesSitesContainers()
        
        header = BiinieCategoriesView_Header(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.categoriesHeaderHeight), father: self)
        headerDelegate = header
        self.addSubview(header!)
        
        fade = UIView(frame: frame)
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
    }
    
    override func transitionIn() {
        println("trasition in on BiinieCategoriesView")
        
        UIView.animateWithDuration(0.4, animations: {()->Void in
            self.fade!.alpha = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on BiinieCategoriesView")
        
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
            println("showUserControl: BiinieCategoriesView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: BiinieCategoriesView")
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
        categorySitesContainers = Array<BiinieCategoriesView_SitesContainer>()
        
        numberOfCategories = BNAppSharedManager.instance.dataManager.bnUser!.categories.count
        
        //Sets all user categories on section for further use
        //BNAppSharedManager.instance.dataManager.loadUserSections()
        
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
            categorySitesContainers![0].manageSitesImageRequest()
        }
        
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        //update header delegate categories control.
        headerDelegate!.updateCategoriesControl!(self, position: scrollView.contentOffset.x)
    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        //println("scrollViewWillBeginDragging")
        //handlePan(scrollView.panGestureRecognizer)
        var mainView = father! as MainView
        mainView.delegate!.mainView!(mainView, hideMenu: false)
    }
    
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    func scrollViewWillEndDragging(scrollView: UIScrollView!, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //println("scrollViewWillEndDragging")
    }
    
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
        //println("scrollViewDidEndDragging")
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView!) {
        //println("scrollViewWillBeginDecelerating")
    }// called on finger up as we are moving
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        
        var width = SharedUIManager.instance.screenWidth
        var page:Int = Int(floor(scrollView.contentOffset.x / width))
        
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

@objc protocol BiinieCategoriesView_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func updateCategoriesPoints(view:BiinieCategoriesView, index:Int)
    optional func updateCategoriesControl(view:BiinieCategoriesView,  position:CGFloat)
}
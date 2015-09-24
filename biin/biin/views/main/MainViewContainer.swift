//  MainViewContainer.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainViewContainer: BNView, UIScrollViewDelegate, ElementView_Delegate, MainViewDelegate_HighlightsContainer, MainViewDelegate_BiinsContainer {
    
    var headerDelegate:BiinieCategoriesView_Delegate?
    
    //var container:CategoriesView_Container?
    var header:BiinieCategoriesView_Header?
    
    var highlightsContainer:HighlightsContainer?
    
    //var categorySitesContainers:Array <BNView>?
    //var panIndex = 0
    //var numberOfCategories = 0
    
    var scroll:UIScrollView?
    
    //var highlightsContainer:BiinieCategoriesView_HighlightsContainer?
    //var biinsContainer:BiinieCategoriesView_BiinsContainer?
    
    var fade:UIView?
    
    //    override init() {
    //        super.init()
    //    }
    
    var elementView:ElementView?
    
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
        
        scroll = UIScrollView(frame:CGRectMake(0, SharedUIManager.instance.categoriesHeaderHeight, screenWidth, (screenHeight - SharedUIManager.instance.categoriesHeaderHeight)))
        
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.delegate = self
        self.addSubview(scroll!)
        
        //addCategoriesSitesContainers()
        
        //HACK: This hack is to show all sites on one category and remove the call to the method before.
        //addSitesToOneContainer()
        
        //addHightlightsContainer()
        
        //addRangedBiinsContainer()
        
        header = BiinieCategoriesView_Header(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.categoriesHeaderHeight), father: self)
        headerDelegate = header
        //self.addSubview(header!)
        
        fade = UIView(frame: frame)
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        highlightsContainer = HighlightsContainer(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.highlightsContainer_Height), father: self)
        self.scroll!.addSubview(highlightsContainer!)
        
        elementView = ElementView(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight), father: self, showBiinItBtn:true)
        elementView!.delegate = self
        self.addSubview(elementView!)
    }
    
    func showMenuBtnActon(sender:BNUIButton) {
        (father as! MainView).showMenu(UIScreenEdgePanGestureRecognizer())
    }
    
    override func transitionIn() {
        
        //UIView.animateWithDuration(0.4, animations: {()->Void in
            self.fade!.alpha = 0
        //})
    }
    
    override func transitionOut( state:BNState? ) {
        
        //UIView.animateWithDuration(0.2, animations: {()->Void in
            self.fade!.alpha = 0.25
        //})
        
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
    
    override func refresh() {
//        for view in categorySitesContainers! {
//            view.refresh()
//        }
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
    
    func showElementView(element:BNElement){
        
        
        elementView!.updateElementData(element)
        
        UIView.animateWithDuration(0.3, animations: {()-> Void in
            self.elementView!.frame.origin.x = 0
            self.fade!.alpha = 0.25
        })
    }
    
    
    func hideElementView(element: BNElement) {
        
        UIView.animateWithDuration(0.4, animations: {() -> Void in
            self.elementView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
            }, completion: {(completed:Bool)-> Void in
                
                //                if !view!.element!.userViewed {
                //                    view!.userViewedElement()
                //                }
                
                self.elementView!.clean()
        })
    }
    
    
    func updateHighlightsContainer(view: MainView, update: Bool) {

    }
    
    func updateBiinsContainer(view: MainView, update: Bool) {
    
    }
}

//@objc protocol BiinieCategoriesView_Delegate:NSObjectProtocol {
//    ///Update categories icons on header
//    optional func updateCategoriesPoints(view:BiinieCategoriesView, index:Int)
//    optional func updateCategoriesControl(view:BiinieCategoriesView,  position:CGFloat)
//}

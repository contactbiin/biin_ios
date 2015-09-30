//  MainViewContainer_Banner.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainViewContainer_Banner:BNView, UIScrollViewDelegate, ElementMiniView_Delegate, SiteView_Delegate {
    
    var title:UILabel?
    var subTitle:UILabel?
    var image:BNUIImageView?
    
    var scroll:UIScrollView?
    
    var spacer:CGFloat = 1
    
    var hightlights:Array<HighlightView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        self.backgroundColor = UIColor.bnOrangeLight()
        
        //TODO: Add all showcase data here
        let screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 100//SharedUIManager.instance.miniView_height + 6
        //ypos += 18
        
        title = UILabel(frame: CGRectMake(10, ypos, (frame.width - 10), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        title!.text = "BANNER"
        title!.textColor = UIColor.whiteColor()
        
        //        if let color = self.showcase!.titleColor {
        //            title!.textColor = self.showcase!.titleColor!
        //        } else {
        //            title!.textColor = UIColor.appTextColor()
        //        }
        
        var banner = UIImageView(image: UIImage(named: "cityBanner.png"))
        banner.frame = CGRectMake(0, 0, frame.width, frame.height)
        self.addSubview(banner)
        
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_showcase_titleSize + 2
        
        subTitle = UILabel(frame: CGRectMake(10, ypos, (frame.width - 10), (SharedUIManager.instance.siteView_showcase_subTittleSize + 2)))
        subTitle!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_showcase_subTittleSize)
        subTitle!.textColor = UIColor.whiteColor()
        subTitle!.text = "Banner subtitle"
        self.addSubview(subTitle!)
        
        //TESTING NOTIFICATIONS
        //        addNotificationBtn = UIButton(frame: CGRectMake((frame.width - 30), 5, 20, 20))
        //        addNotificationBtn!.backgroundColor = UIColor.redColor()
        //        addNotificationBtn!.addTarget(self, action: "addNotificationBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        //        self.addSubview(addNotificationBtn!)
        
        //        var scrollYPos:CGFloat = SharedUIManager.instance.siteView_headerHeight + screenWidth
        let scrollHeight:CGFloat = SharedUIManager.instance.miniView_height + 2
        scroll = UIScrollView(frame: CGRectMake(0, 0, screenWidth, scrollHeight))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.clearColor()
        //self.addSubview(scroll!)
        
        
        
        //addElementViews()
    }
    
    deinit{
        print("-------------- deinit in siteView_showcase")
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        
    }
    
    override func setNextState(option:Int){
        
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
    //instance methods
    //Start all category work, download etc.
    override func getToWork(){
        
    }
    
    //Stop all category work, download etc.
    override func getToRest(){
        
    }
    
    func updateForSite(site: BNSite?){
        
    }
    
    func addElementViews(){
        /*
        var elementPosition:Int = 1
        var xpos:CGFloat = 0
        var elementsViewed = 0
        elements = Array<ElementMiniView>()
        
        var elementView_width:CGFloat = 0
        
        if showcase!.elements.count == 1 {
        elementView_width = SharedUIManager.instance.screenWidth
        } else if showcase!.elements.count == 2 {
        elementView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        } else if showcase!.elements.count == 3 {
        elementView_width = ((SharedUIManager.instance.screenWidth - 2) / 3)
        } else {
        elementView_width = SharedUIManager.instance.miniView_width
        }
        
        if self.site!.organization!.isLoyaltyEnabled && self.site!.organization!.loyalty!.isSubscribed {
        isLoyaltyEnabled = true
        }
        
        for element in showcase!.elements {
        
        
        let elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, elementView_width, SharedUIManager.instance.miniView_height), father: self, element:BNAppSharedManager.instance.dataManager.elements[element._id!], elementPosition:elementPosition, showRemoveBtn:false, isNumberVisible:isLoyaltyEnabled)
        
        if element != showcase!.elements.last {
        xpos += elementView_width + spacer
        } else  {
        xpos += (elementView_width - 1)
        }
        
        elementView.delegate = self
        scroll!.addSubview(elementView)
        elements!.append(elementView)
        elementPosition++
        
        
        
        if element.userViewed {
        elementsViewed++
        }
        
        elementView.requestImage()
        
        }
        
        xpos += spacer
        
        if self.site!.organization!.isLoyaltyEnabled {
        if self.site!.organization!.loyalty!.isSubscribed {
        //Add game view
        gameView = SiteView_Showcase_Game(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height), father: self, showcase: showcase!, animatedCircleColor: UIColor.biinColor())
        scroll!.addSubview(gameView!)
        xpos += SharedUIManager.instance.screenWidth
        } else  {
        joinView = SiteView_Showcase_Join(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height), father: self, showcase: showcase!)
        scroll!.addSubview(joinView!)
        xpos += SharedUIManager.instance.screenWidth
        }
        
        if !self.showcase!.isShowcaseGameCompleted {
        let of = NSLocalizedString("Of", comment: "Of")
        gameView!.updateYouSeenLbl("\(elementsViewed) \(of) \(self.elements!.count)")
        }
        }
        
        scroll!.contentSize = CGSizeMake(xpos, 0)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.bounces = false
        scroll!.pagingEnabled = false
        */
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
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
    
    //ElementMiniView_Delegate
    func showElementView(viewiew: ElementMiniView, element: BNElement) {
        (father! as! SiteView).showElementView(element)
    }
}

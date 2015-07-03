//  SiteView_Showcase.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Showcase:BNView, UIScrollViewDelegate, ElementMiniView_Delegate, SiteView_Delegate {
    
    var title:UILabel?
    var subTitle:UILabel?
    var scroll:UIScrollView?
    //weak var biin:BNBiin?
    weak var showcase:BNShowcase?

    var isWorking = true
    var spacer:CGFloat = 5
    var columns:Int = 1
    var lastColumnRequested:Int = 0
    var elementRequestPreviousLimit:Int = 0
    
    var elements:Array<ElementMiniView>?
    var gameView:SiteView_Showcase_Game?
    var joinView:SiteView_Showcase_Join?
    

    weak var site:BNSite?
    var currentPoints = 0
    var timer:NSTimer?
    
    //var addNotificationBtn:UIButton?
    
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
    
    convenience init(frame: CGRect, father:BNView?, showcase:BNShowcase?, site:BNSite?) {
        self.init(frame: frame, father:father )
        
        //self.biin = biin
        
        self.backgroundColor = UIColor.appMainColor()
        self.showcase = BNAppSharedManager.instance.dataManager.showcases[showcase!.identifier!]
        self.site = site
        
        //TODO: Add all showcase data here
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 1
        //ypos += 18
        
        title = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteView_titleSize)
        title!.text = self.showcase!.title
        
        if let color = self.showcase!.titleColor {
            title!.textColor = self.showcase!.titleColor!
        } else {
            title!.textColor = UIColor.appTextColor()
        }
        
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_titleSize + 3
        
        subTitle = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 2)))
        subTitle!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        subTitle!.textColor = UIColor.appTextColor()
        subTitle!.text = self.showcase!.subTitle!
        self.addSubview(subTitle!)
        
        //TESTING NOTIFICATIONS
//        addNotificationBtn = UIButton(frame: CGRectMake((frame.width - 30), 5, 20, 20))
//        addNotificationBtn!.backgroundColor = UIColor.redColor()
//        addNotificationBtn!.addTarget(self, action: "addNotificationBtn:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(addNotificationBtn!)
        
        //        var scrollYPos:CGFloat = SharedUIManager.instance.siteView_headerHeight + screenWidth
        var scrollHeight:CGFloat = SharedUIManager.instance.miniView_height + 10
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.siteView_headerHeight, screenWidth, scrollHeight))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.appShowcaseBackground()
        self.addSubview(scroll!)
    
        addElementViews()
        
        columns = SharedUIManager.instance.miniView_columns
        
    }
    
//    func addNotificationBtn(sender:UIButton){
        //TEST: Add some notifications
        //var notification = BNNotification(title: "\(self.biin!.site!.title!)", text: "A test notification for site \(self.biin!.site!.title!)", biin: self.biin!, notificationType: BNNotificationType.STIMULUS, time:NSDate())
        
        //BNAppSharedManager.instance.processNotification(notification)

//    }
    
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
    //instance methods
    //Start all category work, download etc.
    override func getToWork(){
        isWorking = true
        manageElementMiniViewImageRequest()
        println("\(showcase!.identifier!) is working")
    }
    
    //Stop all category work, download etc.
    override func getToRest(){
        isWorking = false
        println("\(showcase!.identifier!) is resting")
    }
    
    func updateForSite(site: BNSite?){
     
    }
    
    func addElementViews(){
        
        var elementPosition:Int = 1
        var xpos:CGFloat = spacer
        elements = Array<ElementMiniView>()
        
        for element in showcase!.elements {
            var elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, element:BNAppSharedManager.instance.dataManager.elements[element._id!], elementPosition:elementPosition, showRemoveBtn:false, isNumberVisible:true)
            xpos += SharedUIManager.instance.miniView_width + spacer
            elementView.delegate = self
            scroll!.addSubview(elementView)
            elements!.append(elementView)
            elementPosition++
            
            if elementPosition < 3 {
                elementView.requestImage()
            }
        }
        
        xpos += spacer
        
        if self.site!.loyalty!.isSubscribed {
            //Add game view
            gameView = SiteView_Showcase_Game(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height), father: self, showcase: showcase!, animatedCircleColor: UIColor.biinColor())
            scroll!.addSubview(gameView!)
            xpos += SharedUIManager.instance.screenWidth
        } else  {
            joinView = SiteView_Showcase_Join(frame: CGRectMake(xpos, spacer, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height), father: self, showcase: showcase!)
            scroll!.addSubview(joinView!)
            xpos += SharedUIManager.instance.screenWidth
        }
        
        scroll!.contentSize = CGSizeMake(xpos, 0)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.bounces = false
        scroll!.pagingEnabled = false
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        manageElementMiniViewImageRequest()
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
        
        if showcase!.isShowcaseGameCompleted {
            return
        }
        
        if self.site!.loyalty!.isSubscribed {
            
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
                    currentPoints = self.site!.loyalty!.points
                    self.updatePointCounter()
                    self.site!.loyalty!.points += totalPoints
                    showcase!.isShowcaseGameCompleted = true
                    father!.changeJoinBtnText("You have \(self.site!.loyalty!.points) points with us!")
                }
            }
        }
    }// called when scroll view grinds to a halt
    
    func updatePointCounter() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector:"updatePoints:", userInfo: nil, repeats: true)
    }
    
    func updatePoints(sender:NSTimer){
        
        currentPoints++
        
        if currentPoints <= self.site!.loyalty!.points {
            //gameView!.updatePointLbl("\(currentPoints)")
            //TODO: update bottom label on site
            (father! as! SiteView).updateLoyaltyPoints()
            
        }else {
            timer!.invalidate()
            gameView!.startToAnimateCirclesOnCompleted()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {

    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {

        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {

    }// called when scrolling animation finished. may be called immediately if already at top
    
    func manageElementMiniViewImageRequest(){
        
        if !isWorking { return }
        
        var width = SharedUIManager.instance.miniView_width + spacer
        var column:Int = Int(floor(self.scroll!.contentOffset.x / width)) + 1
        

        
        if lastColumnRequested < column {
            
            lastColumnRequested = column
            var requestLimit:Int = Int(lastColumnRequested + columns)

            if requestLimit >= elements?.count {
                requestLimit = elements!.count - 1
                isWorking = false //reach the limit of requests
            }
            

            var i:Int = requestLimit
            var stop:Bool = false
            
            while !stop {
                
                if i >= elementRequestPreviousLimit {
                    var elementView = elements![i] as ElementMiniView
                    elementView.requestImage()
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
        (father! as! SiteView).showElementView(view)
    }
}



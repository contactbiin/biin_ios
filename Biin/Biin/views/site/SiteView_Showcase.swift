//  SiteView_Showcase.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Showcase:BNView, UIScrollViewDelegate {
    
    var title:UILabel?
    var subTitle:UILabel?
    var scroll:BNScroll?
    //weak var biin:BNBiin?
    weak var showcase:BNShowcase?

    var isWorking = true
    var spacer:CGFloat = 1
    var columns:Int = 1
    var lastColumnRequested:Int = 0
    var elementRequestPreviousLimit:Int = 0
    
    //var elements:Array<ElementMiniView>?
    var gameView:SiteView_Showcase_Game?
    var joinView:SiteView_Showcase_Join?
    
    weak var site:BNSite?
    var isLoyaltyEnabled = false
    
    var currentPoints = 0
    var timer:NSTimer?
    
    //var addNotificationBtn:UIButton?
    
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
    
    convenience init(frame: CGRect, father:BNView?, showcase:BNShowcase?, site:BNSite?, colorIndex:Int) {
        self.init(frame: frame, father:father)
        
        
//        var textColor:UIColor?
//        switch colorIndex {
//        case 0:
////             self.backgroundColor = site!.media[0].vibrantColor
//            self.backgroundColor = UIColor.lightGrayColor()
//            textColor = UIColor.bnGrayDark()
////        case 1:
////             self.backgroundColor = site!.media[0].vibrantLightColor
//        case 1:
////             self.backgroundColor = site!.media[0].vibrantDarkColor
//            self.backgroundColor = UIColor.grayColor()
//            textColor = UIColor.whiteColor()
//        default:
//            self.backgroundColor = UIColor.lightGrayColor()
//            textColor = UIColor.bnGrayDark()
//            break
//        }
        
        let textColor = UIColor.whiteColor()
        self.backgroundColor = UIColor.appBackground()
        
       //!.colorWithAlphaComponent(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
        self.showcase = showcase//BNAppSharedManager.instance.dataManager.showcases[showcase!.identifier!]
        self.site = site
        
        //TODO: Add all showcase data here
        let screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 21//SharedUIManager.instance.miniView_height + 6
        //ypos += 18
        
        title = UILabel(frame: CGRectMake(15, ypos, (frame.width - 30), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)        
        let titleText = self.showcase!.title!.uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = textColor
        
//        if let color = self.showcase!.titleColor {
//            title!.textColor = self.showcase!.titleColor!
//        } else {
//            title!.textColor = UIColor.appTextColor()
//        }
        
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_showcase_titleSize + 2
        
//        subTitle = UILabel(frame: CGRectMake(15, ypos, (frame.width - 30), (SharedUIManager.instance.siteView_showcase_subTittleSize + 2)))
//        subTitle!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_showcase_subTittleSize)
//        subTitle!.textColor = UIColor.whiteColor()
        //subTitle!.text = self.showcase!.subTitle!
        ///self.addSubview(subTitle!)
        
        //TESTING NOTIFICATIONS
//        addNotificationBtn = UIButton(frame: CGRectMake((frame.width - 30), 5, 20, 20))
//        addNotificationBtn!.backgroundColor = UIColor.redColor()
//        addNotificationBtn!.addTarget(self, action: "addNotificationBtn:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(addNotificationBtn!)
        
        //        var scrollYPos:CGFloat = SharedUIManager.instance.siteView_headerHeight + screenWidth
        let scrollHeight:CGFloat = SharedUIManager.instance.miniView_height + 2
        
        //scroll = UIScrollView(frame: CGRectMake(0,  (SharedUIManager.instance.siteView_showcaseHeaderHeight - 1), screenWidth, scrollHeight))
        scroll = BNScroll(frame: CGRectMake(0,  (SharedUIManager.instance.siteView_showcaseHeaderHeight - 1), screenWidth, scrollHeight), father:self, direction: BNScroll_Direction.HORIZONTAL, space: 1, extraSpace: 0, color: UIColor.clearColor(), delegate: nil)
        self.addSubview(scroll!)
    
        addElementViews()
        
        columns = SharedUIManager.instance.miniView_columns
        
    }
    
//    func addNotificationBtn(sender:UIButton){
        //TEST: Add some notifications
        //var notification = BNNotification(title: "\(self.biin!.site!.title!)", text: "A test notification for site \(self.biin!.site!.title!)", biin: self.biin!, notificationType: BNNotificationType.STIMULUS, time:NSDate())
        
        //BNAppSharedManager.instance.processNotification(notification)

//    }
    
    deinit{

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
    //instance methods
    //Start all category work, download etc.
    override func getToWork(){
        isWorking = true
        manageElementMiniViewImageRequest()
    }
    
    //Stop all category work, download etc.
    override func getToRest(){
        isWorking = false
    }
    
    func updateForSite(site: BNSite?){
     
    }
    
    func addElementViews(){
        
        if showcase!.elements.count > 0 {
        
            
            var elementPosition:Int = 1
            var xpos:CGFloat = 0
            var elementsViewed = 0
            
            var elementView_width:CGFloat = 0
            
            if showcase!.elements.count == 1 {
                elementView_width = SharedUIManager.instance.screenWidth
            } else if showcase!.elements.count == 2 {
                elementView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
            }  else {
                elementView_width = SharedUIManager.instance.miniView_width
            }
            
//            if self.site!.organization!.isLoyaltyEnabled && self.site!.organization!.loyalty!.isSubscribed {
//                isLoyaltyEnabled = true
//            }
            
            var elements = Array<ElementMiniView>()

            
            for element_identifier in showcase!.elements {

                if !isAddedToScroll(element_identifier) {
                    
                    if let element = BNAppSharedManager.instance.dataManager.elements[element_identifier] {
                        element.showcase = self.showcase
                        
                        let elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, elementView_width, SharedUIManager.instance.miniView_height_showcase), father: self, element:element, elementPosition:elementPosition, showRemoveBtn:false, isNumberVisible:isLoyaltyEnabled, showlocation:false)
                            elementView.isElementMiniViewInSite = true
                        
                        if element_identifier != showcase!.elements.last {
                            xpos += elementView_width + spacer
                        } else  {
                            xpos += (elementView_width - 1)
                        }
                        
                        elementView.delegate = BNAppSharedManager.instance.mainViewController!.mainView!
                        elements.append(elementView)
                        elementPosition += 1
                        
                        if element.userViewed {
                            elementsViewed += 1
                        }
                        
                        //if elementPosition < 4 {
                            elementView.requestImage()
                        //}
                    } else {
                        print("NO ELMENT IN elements list: \(element_identifier) and is on showcase: \(showcase!.identifier!)")
                    }
                }
            }
            
            scroll!.addMoreChildren(elements)
            
            if showcase!.elements_quantity <= scroll!.children.count {
                scroll!.disableRefreshControl()
            }
            
            /*
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
            */
            //scroll!.setChildrenPosition()
        }
    }
    
    func isAddedToScroll(identifier:String) ->Bool {
        for view in scroll!.children {
            if (view as! ElementMiniView).element!.identifier! == identifier {
                return true
            }
        }
        return false
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        manageElementMiniViewImageRequest()
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
        /*
        if isLoyaltyEnabled {
            
            if showcase!.isShowcaseGameCompleted {
                return
            }
            
            var isShowcaseGameCompleted = true
            var totalPoints = 0
            currentPoints = 0
            let pointsByElement = 5
            var elementsViewed = 0
            let position = scrollView.bounds.origin.x
            let width = scrollView.contentSize.width
            let showcaseGameWidth = SharedUIManager.instance.screenWidth
            
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
                
                let of = NSLocalizedString("Of", comment: "Of")
                gameView!.updateYouSeenLbl("\(elementsViewed) \(of) \(self.elements!.count)")
                
                if isShowcaseGameCompleted {
                    totalPoints = self.elements!.count * pointsByElement
                    currentPoints = self.site!.organization!.loyalty!.points
                    self.updatePointCounter()
                    self.site!.organization!.addPoints(totalPoints)
                    showcase!.isShowcaseGameCompleted = true
                    father!.changeJoinBtnText("You have \(self.site!.organization!.loyalty!.points) points with us!")
                }
            }
        }
*/
    }// called when scroll view grinds to a halt
    
    func updatePointCounter() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector:#selector(self.updatePoints(_:)), userInfo: nil, repeats: true)
    }
    
    func updatePoints(sender:NSTimer){
        
//        currentPoints++
        
//        if currentPoints <= self.site!.organization!.loyalty!.points {
            //gameView!.updatePointLbl("\(currentPoints)")
            //TODO: update bottom label on site
            (father! as! SiteView).updateLoyaltyPoints()
            
//        }else {
            timer!.invalidate()
            gameView!.startToAnimateCirclesOnCompleted()
//        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {

    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {

        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {

    }// called when scrolling animation finished. may be called immediately if already at top
    
    func manageElementMiniViewImageRequest(){
        
        /*
        if !isWorking { return }
        
        let width = SharedUIManager.instance.miniView_width + spacer
        let column:Int = Int(floor(self.scroll!.scroll!.contentOffset.x / width)) + 1
        

        
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
                    let elementView = elements![i] as ElementMiniView
                    elementView.requestImage()
                    i--
                } else  {
                    stop = true
                }
            }
            
            elementRequestPreviousLimit = requestLimit + 1
        }
*/
    }
    
    override func clean(){
        self.scroll!.clean()
    }
    
    override func request() {
        self.showcase!.batch += 1
        BNAppSharedManager.instance.dataManager.requestElementsForShowcase(self.showcase, view: self)
    }
    
    override func requestCompleted() {
        self.addElementViews()
        self.scroll!.requestCompleted()
    }
}



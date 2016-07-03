//  MainView_Container_Highlights.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.


import Foundation
import UIKit

class MainView_Container_Highlights:BNView, UIScrollViewDelegate {
    
    var title:UILabel?
    var scroll:UIScrollView?
    var currentHighlight:Int = 0
    
    var timer:NSTimer?
    
    var hightlights:Array<HighlightView>?
    var points:Array<BNUIPointView>?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        
        super.init(frame: frame, father:father )
        self.backgroundColor = UIColor.darkGrayColor()
        
        
        title = UILabel(frame: CGRectMake(10, 16, (frame.width - 20), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText = NSLocalizedString("Recomended", comment: "Recomended").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.whiteColor()
        self.addSubview(title!)
        
        //TODO: Add all showcase data here
        
        
        
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.sitesContainer_headerHeight
            , frame.width, (frame.height - SharedUIManager.instance.sitesContainer_headerHeight)))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.backgroundColor = UIColor.lightGrayColor()
        scroll!.pagingEnabled = true
        self.addSubview(scroll!)
        
        hightlights = Array<HighlightView>()
        points = Array<BNUIPointView>()
        updateHighlightView()
        
        startTimer()
        
    }
    
    deinit{ }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {

    }
    
    override func setNextState(goto:BNGoto){

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
    
    func change(sender:NSTimer){
        if currentHighlight < hightlights!.count {
            let xpos:CGFloat = SharedUIManager.instance.screenWidth * CGFloat((currentHighlight + 1))
            scroll!.setContentOffset(CGPoint(x: xpos, y: 0), animated: true)
        }
    }
    
    
    func updateHighlightView(){
        
        if BNAppSharedManager.instance.dataManager.highlights.count > 0{

            var xpos:CGFloat = 0
            var xpos_for_point:CGFloat = ((SharedUIManager.instance.screenWidth - CGFloat((BNAppSharedManager.instance.dataManager.highlights.count - 1 ) * 20)) / 2)

            let highlightHeight:CGFloat = ((SharedUIManager.instance.highlightContainer_Height + SharedUIManager.instance.highlightView_headerHeight)) - SharedUIManager.instance.sitesContainer_headerHeight
            
            for highllight in BNAppSharedManager.instance.dataManager.highlights {
                
                let element = BNAppSharedManager.instance.dataManager.elements[highllight.identifier]
                element!.showcase = BNAppSharedManager.instance.dataManager.showcases[highllight.showcase]
                element!.showcase!.site = BNAppSharedManager.instance.dataManager.sites[highllight.site]
                
                let highlightView = HighlightView(frame: CGRectMake(xpos, 0, SharedUIManager.instance.screenWidth, highlightHeight), father: self, element: element!)
                
                highlightView.delegate = BNAppSharedManager.instance.mainViewController!.mainView!
                scroll!.addSubview(highlightView)
                hightlights!.append(highlightView)
                highlightView.requestImage()
                xpos += (SharedUIManager.instance.screenWidth )
                
                let point = BNUIPointView(frame: CGRectMake(xpos_for_point, 40, 10, 10), activeColor: UIColor.whiteColor())
                points!.append(point)
                self.addSubview(point)
                xpos_for_point += 20
            }
            
            points![0].setActive()
            
            let lastHightLight = HighlightView(frame: CGRectMake(xpos, 0, SharedUIManager.instance.screenWidth, highlightHeight), father: self, element: hightlights![0].element!)
            lastHightLight.frame.origin.x = xpos
            lastHightLight.requestImage()
            lastHightLight.delegate = BNAppSharedManager.instance.mainViewController!.mainView!
            scroll!.addSubview(lastHightLight)
            hightlights!.append(lastHightLight)
            xpos += (SharedUIManager.instance.screenWidth )
            
            scroll!.contentSize = CGSizeMake(xpos, SharedUIManager.instance.highlightContainer_Height)
        }
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {

    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //handlePan(scrollView.panGestureRecognizer)
        //let mainView = father!.father! as! MainView
        //mainView.delegate!.mainView!(mainView, hideMenu: false)
        stopTimer()
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
        let scrollPosition = scrollView.contentOffset
        currentHighlight = Int(scrollPosition.x / SharedUIManager.instance.screenWidth)
        
        if currentHighlight == (hightlights!.count - 1) {
            scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            currentHighlight = 0
        }
        
        setCurrentPoint()
        startTimer()
        
    }// called when scroll view grinds to a halt
    
    func setCurrentPoint() {
        
        for point in points! {
            point.setInactive()
        }
        
        points![currentHighlight].setActive()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset
        currentHighlight = Int(scrollPosition.x / SharedUIManager.instance.screenWidth)
        
        if currentHighlight == (hightlights!.count - 1) {
            scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            currentHighlight = 0
        }
        
        setCurrentPoint()

    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        
        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {


    }// called when scrolling animation finished. may be called immediately if already at top
    
    //ElementMiniView_Delegate
//    func showElementView(element: BNElement) {
//        (father! as! MainViewContainer).showElementView(element)
//    }

    func stopTimer(){
        if timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
    }
    
    func startTimer(){
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(6.0, target: self, selector: #selector(MainView_Container_Highlights.change(_:)), userInfo: nil, repeats: true)
        }
    }
    
    override func clean() {
        
        if hightlights?.count > 0 {
            
            for highlight in self.hightlights! {
                highlight.clean()
                highlight.removeFromSuperview()
            }
            
            for point in points! {
                point.removeFromSuperview()
            }
            
            points!.removeAll()

            hightlights!.removeAll(keepCapacity: false)
        }
        
        hightlights = nil
        scroll?.removeFromSuperview()
        self.timer!.invalidate()
    }
}




//  MainView_Container_Banner.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainView_Container_Banner:BNView, UIScrollViewDelegate {
    
    var image:BNUIImageView?
    var scroll:UIScrollView?
    
    var currentHighlight:Int = 0
    var timer:NSTimer?
    
    var hightlights:Array<UIImageView>?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        self.backgroundColor = UIColor.bnOrangeLight()
        
        var xpos:CGFloat = 0

        scroll = UIScrollView(frame: CGRectMake(0, 0, frame.width, frame.height))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.clearColor()
        self.addSubview(scroll!)
        
        hightlights = Array<UIImageView>()
        
        let banner = UIImageView(image: UIImage(named: "cityBanner.png"))
        banner.frame = CGRectMake(xpos, 0, frame.width, frame.height)
        hightlights!.append(banner)
        scroll!.addSubview(banner)
        xpos += frame.width
        
        let banner2 = UIImageView(image: UIImage(named: "banner1.jpg"))
        banner2.frame = CGRectMake(xpos, 0, frame.width, frame.height)
        hightlights!.append(banner2)
        scroll!.addSubview(banner2)
        xpos += frame.width
        
        let banner3 = UIImageView(image: UIImage(named: "pizza.jpg"))
        banner3.frame = CGRectMake(xpos, 0, frame.width, frame.height)
        hightlights!.append(banner3)
        scroll!.addSubview(banner3)
        xpos += frame.width

        let banner4 = UIImageView(image: UIImage(named: "vintage.jpg"))
        banner4.frame = CGRectMake(xpos, 0, frame.width, frame.height)
        hightlights!.append(banner4)
        scroll!.addSubview(banner4)
        xpos += frame.width

        let banner5 = UIImageView(image: UIImage(named: "cityBanner.png"))
        banner5.frame = CGRectMake(xpos, 0, frame.width, frame.height)
        hightlights!.append(banner5)
        scroll!.addSubview(banner5)
        xpos += frame.width

        
        scroll!.contentSize = CGSizeMake(xpos, 0)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.pagingEnabled = true
        
        startTimer()

    }
    
    deinit{    }
    
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
    //Start all category work, download etc.
    override func getToWork(){
        
    }
    
    //Stop all category work, download etc.
    override func getToRest(){
        
    }
    
    func updateForSite(site: BNSite?){
        
    }
    
    func change(sender:NSTimer){
        if currentHighlight < hightlights!.count {
            let xpos:CGFloat = SharedUIManager.instance.screenWidth * CGFloat((currentHighlight))
            scroll!.setContentOffset(CGPoint(x: xpos, y: 0), animated: true)
            currentHighlight += 1
        }
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
        let scrollPosition = scrollView.contentOffset
        currentHighlight = Int(scrollPosition.x / SharedUIManager.instance.screenWidth)
        
        
        
    }// called when scroll view grinds to a halt
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        if currentHighlight == hightlights!.count {
            scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            currentHighlight = 0
        }
    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        
        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }// called when scrolling animation finished. may be called immediately if already at top
    
    func stopTimer(){
        self.timer!.invalidate()
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(7.5, target: self, selector: #selector(self.change(_:)), userInfo: nil, repeats: true)
        timer!.fire()
    }
    
    override func clean(){
        if hightlights?.count > 0 {
            
            for view in scroll!.subviews {
                view.removeFromSuperview()
            }
            
            hightlights!.removeAll(keepCapacity: false)
        }
    }
}

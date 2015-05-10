//  BNUIScrollView.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIScrollView:UIView, UIScrollViewDelegate {
    
    var media:Array<BNMedia>?// = Array<BNMedia>()
    var images:[(image:BNUIImageView , requested:Bool)] = []
    var points:Array<BNUIPointView>?
    var previousPoint:Int = 0
    
    var scroll:UIScrollView?
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scroll = UIScrollView(frame: frame)
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.delegate = self
        self.addSubview(scroll!)
    }
    
    convenience init(frame: CGRect, site:BNSite?) {
        self.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect) {
        
    }
    
    func updateImages(media:Array<BNMedia>){
        
        clean()
        
        if media.count > 0 {
            

            self.media = media
            
            var totalLength:CGFloat = CGFloat((media.count - 1) * 20)
            var space:CGFloat = (SharedUIManager.instance.screenWidth - totalLength) / 2.0
            var xpos:CGFloat = (space - 5)
            
            var scrollXPos:CGFloat = 0
            
            
            for var i:Int = 0; i < self.media!.count; i++ {
                
                var point = BNUIPointView(frame: CGRectMake((xpos), (SharedUIManager.instance.screenWidth - 25), 14, 14), categoryIdentifier:"")
                self.points!.append(point)
                self.addSubview(point)
                xpos += 20
                
                //Add images to scroll
                var image = BNUIImageView(frame: CGRectMake(scrollXPos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth))
                image.backgroundColor = self.media![i].domainColor
                
                if i == 0 {
                    
                    self.images += [(image:image, requested:true)]
                    BNAppSharedManager.instance.networkManager.requestImageData(self.media![i].url!, image: image)
                    
                } else {
                    self.images += [(image:image, requested:false)]
                }
                
                scroll!.addSubview(image)
                scrollXPos += SharedUIManager.instance.screenWidth
            }
            
            points![previousPoint].setActive()
            scroll!.contentSize = CGSizeMake(scrollXPos, 0)
            scroll!.setContentOffset(CGPointZero, animated: false)
            scroll!.bounces = false
            scroll!.pagingEnabled = true
            
        }
    }
    
    func changedPoint(pointIndex: Int) {
        points![previousPoint].setInactive()
        points![pointIndex].setActive()
        previousPoint = pointIndex
    }
    
    func clean(){
        
        previousPoint = 0

        if points?.count > 0{
            for point in self.points! {
                point.removeFromSuperview()
            }
            
            for view in self.scroll!.subviews {
                if view.isKindOfClass(BNUIImageView) {
                    view.removeFromSuperview()
                }
            }
        }
        
        self.images = []
        self.points = Array<BNUIPointView>()
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //        println("scrollViewDidScroll")
//        manageSitesImageRequest()
    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //println("scrollViewWillBeginDragging")
    }
    
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //println("scrollViewWillEndDragging")
    }
    
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView ) {
        //println("scrollViewWillBeginDecelerating")
    }// called on finger up as we are moving
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView ) {
        //        println("scrollViewDidEndDecelerating")
        
        var index = Int(scrollView.contentOffset.x / 320)
        
        changedPoint(index)
        
        if !images[index].requested {
            BNAppSharedManager.instance.networkManager.requestImageData(self.media![index].url!, image:images[index].image)
            images[index].requested = true
        }
        
        //println("scrollViewDidEndDecelerating: \(index)")
        
    }// called when scroll view grinds to a halt
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        //println("scrollViewDidEndScrollingAnimation")
    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        //println("scrollViewShouldScrollToTop")
        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        //println("scrollViewDidScrollToTops")
    }// called when scrolling animation finished. may be called immediately if already at top

    
}

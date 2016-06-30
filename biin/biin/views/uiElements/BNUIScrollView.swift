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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scroll = UIScrollView(frame: frame)
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        self.addSubview(scroll!)
    }
    
    convenience init(frame: CGRect, site:BNSite?) {
        self.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect) {
        
    }
    
    func updateImages(media:Array<BNMedia>, isElement:Bool){
        
        clean()
        
        let distance:CGFloat = (SharedUIManager.instance.screenWidth - 25)
        
//        if isElement {
//            distance = (SharedUIManager.instance.screenWidth - (SharedUIManager.instance.elementView_headerHeight + 15))
//        }
        
        if media.count > 0 {
        //if false {
            self.media = media
            
            let totalLength:CGFloat = CGFloat((media.count - 1) * 20)
            let space:CGFloat = (SharedUIManager.instance.screenWidth - totalLength) / 2.0
            var xpos:CGFloat = (space - 5)
            
            var scrollXPos:CGFloat = 0
            
            var i:Int = 0
            for _ in self.media! {
//            for var i:Int = 0; i < self.media!.count; i++ {

                if self.media!.count > 1 {
                    let point = BNUIPointView(frame: CGRectMake((xpos), distance, 10, 10), categoryIdentifier:"", activeColor:self.media![0].vibrantColor!)
                    self.points!.append(point)
                    self.addSubview(point)
                    xpos += 20
                }
                
                //Add images to scroll
//                let image = BNUIImageView(frame: CGRectMake(scrollXPos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth))
                let image = BNUIImageView(frame: CGRectMake(scrollXPos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth), color:self.media![i].vibrantColor!)
                //image.backgroundColor = self.media![i].vibrantColor
                
                if i == 0 {
                    
                    self.images += [(image:image, requested:true)]
                    BNAppSharedManager.instance.networkManager.requestImageData(self.media![i].url!, image: image)
                    
                } else {
                    self.images += [(image:image, requested:false)]
                }
                
                scroll!.addSubview(image)
                scrollXPos += SharedUIManager.instance.screenWidth
                i += 1
            }
            
            if points!.count > 0 {
                points![previousPoint].setActive()
            }
            
            scroll!.contentSize = CGSizeMake(scrollXPos, 0)
            scroll!.setContentOffset(CGPointZero, animated: false)
            scroll!.pagingEnabled = true
            
        } else {
            
            self.media = Array<BNMedia>()
            
            //let totalLength:CGFloat = CGFloat((media.count - 1) * 20)
            //let space:CGFloat = (SharedUIManager.instance.screenWidth - totalLength) / 2.0
            //var xpos:CGFloat = (space - 5)
            
            var scrollXPos:CGFloat = 0
            
            //for var i:Int = 0; i < self.media!.count; i++ {
                
                //var point = BNUIPointView(frame: CGRectMake((xpos), (SharedUIManager.instance.screenWidth - 25), 14, 14), categoryIdentifier:"")
                //self.points!.append(point)
                //self.addSubview(point)
                //xpos += 20
                
                //Add images to scroll
            let image = BNUIImageView(frame: CGRectMake(scrollXPos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth), color:UIColor.whiteColor())
                image.image =  UIImage(contentsOfFile: "noImage.jpg")
                image.showAfterDownload()
                //image.backgroundColor = self.media![i].domainColor
                
                //if i == 0 {
                    
                    self.images += [(image:image, requested:true)]
                    //BNAppSharedManager.instance.networkManager.requestImageData(self.media![i].url!, image: image)
                    
                //} else {
                    //self.images += [(image:image, requested:false)]
                //}
                
                scroll!.addSubview(image)
                scrollXPos += SharedUIManager.instance.screenWidth
            //}
            
            //points![previousPoint].setActive()
            scroll!.contentSize = CGSizeMake(scrollXPos, 0)
            scroll!.setContentOffset(CGPointZero, animated: false)
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
        
        for image in images {
            image.image.removeFromSuperview()
        }
        
//        for (var i = 0; i < images.count; i++) {
//            self.images[i].image.removeFromSuperview()
//        }
        
        self.images = []
        self.points = Array<BNUIPointView>()
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {


    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {

    }
    
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

    }
    
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView ) {

    }// called on finger up as we are moving
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView ) {

        
        let index = Int(scrollView.contentOffset.x / SharedUIManager.instance.screenWidth)
        
        changedPoint(index)
        
        if !images[index].requested {
            BNAppSharedManager.instance.networkManager.requestImageData(self.media![index].url!, image:images[index].image)
            images[index].requested = true
        }
        

        
    }// called when scroll view grinds to a halt
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {

    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {

        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {

    }// called when scrolling animation finished. may be called immediately if already at top


}

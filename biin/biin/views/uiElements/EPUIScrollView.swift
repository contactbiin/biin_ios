//  EPUIScrollView.swift
//  ScrollUpdated
//  Created by Esteban Padilla on 11/16/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit


class EPUIScrollView: UIView {

    var scroll:UIScrollView?
    var refreshControl:UIRefreshControl?
    var isHorizontal:Bool = false
    var subViewPosition:CGFloat = 0
    var space:CGFloat = 0
    var extraSpace:CGFloat = 0
    var children:Array<UIView> = Array<UIView>()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, isHorizontal:Bool, text:String, space:CGFloat, extraSpace:CGFloat, color:UIColor, showRefreshControl:Bool) {

        self.init(frame: frame)
        self.backgroundColor = color
        self.isHorizontal = isHorizontal
        self.space = space
        self.extraSpace = extraSpace
        
        if isHorizontal {
            self.scroll = UIScrollView(frame: CGRectMake(0, 0, frame.height, frame.width))
            self.scroll!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 2))
            self.scroll!.frame.origin.y = 0
            self.scroll!.frame.origin.x = 0
        } else {
            self.scroll = UIScrollView(frame: CGRectMake(0, 0, frame.width, frame.height))
        }
        
        self.addSubview(self.scroll!)
        self.scroll!.alwaysBounceVertical = false
        self.scroll!.backgroundColor = color
        self.scroll!.showsVerticalScrollIndicator = false
        self.scroll!.showsHorizontalScrollIndicator = false
        
        if showRefreshControl {
            self.refreshControl = UIRefreshControl(frame: CGRectMake(0, 0, 0, 0))
            self.refreshControl!.backgroundColor = UIColor.clearColor()
            self.refreshControl!.attributedTitle = NSAttributedString(string:text)

            var attributes:[String : AnyObject]? = [ NSForegroundColorAttributeName: UIColor.whiteColor()]
            attributes![ NSFontAttributeName ] = UIFont(name: "Lato-Regular", size: 10)
            let attributedTitle = NSAttributedString(string: text.uppercaseString, attributes: attributes)
            self.refreshControl!.attributedTitle = attributedTitle
            
            self.refreshControl!.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
            self.refreshControl!.tintColor = UIColor.whiteColor()
            scroll!.addSubview(self.refreshControl!)
        }
    }
    
    func addChild(view:UIView) {
        children.append(view)
    }
    
    func setChildrenPosition(){
    
        if isHorizontal {
            
            for var i = (self.children.count - 1); i >= 0; i-- {
                self.children[i].transform = CGAffineTransformMakeRotation(CGFloat(M_PI / -2))
                self.children[i].frame.origin.y = subViewPosition
                self.children[i].frame.origin.x = 0
                self.subViewPosition += self.children[i].frame.height + space
                self.scroll!.addSubview(self.children[i])
                self.scroll!.contentSize = CGSize(width: self.frame.height, height:(self.subViewPosition - self.space))
            }
            
            let ypos = (self.scroll!.contentSize.height - self.frame.width)
            self.scroll!.setContentOffset(CGPoint(x: 0, y:ypos), animated: false)
            
        } else {
            
            for view in self.children {
                
                view.frame.origin.y = self.subViewPosition
                self.subViewPosition += view.frame.height + space
                self.scroll!.addSubview(view)
                self.scroll!.contentSize = CGSize(width: self.frame.width, height:((self.subViewPosition + self.extraSpace) - self.space))

            }
        }
    }
    
    func refresh(){
        
        // -- DO SOMETHING AWESOME (... or just wait 3 seconds) --
        // This is where you'll make requests to an API, reload data, or process information
        let delayInSeconds = 3.0;
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            // When done requesting/reloading/processing invoke endRefreshing, to close the control
            self.refreshControl!.endRefreshing()
            print("Completed")
        }
        // -- FINISHED SOMETHING AWESOME, WOO! --
    }
}

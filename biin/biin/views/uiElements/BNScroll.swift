//  BNScroll.swift
//  biin
//  Created by Esteban Padilla on 11/25/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNScroll: BNView, UIScrollViewDelegate {
    
    var scroll:UIScrollView?
    var isHorizontal:Bool = false
    var childPosition:CGFloat = 0
    var space:CGFloat = 0
    var extraSpace:CGFloat = 0
    var children:Array<BNView> = Array<BNView>()
    var direction:BNScroll_Direction?

    var doUpdatePosition = true
    var positionToScroll:CGFloat = 0
    var updateEnable = true
    
    var isRuningRequest = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father:BNView, direction:BNScroll_Direction, space:CGFloat, extraSpace:CGFloat, color:UIColor, delegate:UIScrollViewDelegate?) {
        
        self.init(frame: frame, father:father )
        self.backgroundColor = color
        self.direction = direction
        self.space = space
        self.extraSpace = extraSpace
        
        self.scroll = UIScrollView(frame: CGRectMake(0, 0, frame.width, frame.height))
        self.addSubview(self.scroll!)
        self.scroll!.showsHorizontalScrollIndicator = false
        self.scroll!.showsVerticalScrollIndicator = false
        self.scroll!.alwaysBounceVertical = false
        self.scroll!.backgroundColor = UIColor.clearColor()
        
        if delegate == nil {
            self.scroll!.delegate = self
        } else {
            self.scroll!.delegate = delegate
        }
    }
    
    func addChild(view:BNView) {
        children.append(view)
        scroll!.addSubview(view)
    }
    
    func setChildrenPosition(){
        
        childPosition = 0
        
        switch self.direction! {
        case .HORIZONTAL:
            for var i = 0; i < children.count; i++ {
                
                if !children[i].isAddedToScroll {
                    self.children[i].isAddedToScroll = true
                    self.children[i].frame.origin.y = 0
                    self.children[i].frame.origin.x = childPosition
                }
                
                self.childPosition += self.children[i].frame.width + space
            }
            
            self.scroll!.contentSize = CGSize(width: (self.childPosition - self.space), height:self.frame.height)
            
            break
        case .VERTICAL:
            
            for var i = 0; i < children.count; i++ {
                
                if !children[i].isAddedToScroll {
                    self.children[i].isAddedToScroll = true
                    self.children[i].frame.origin.y = childPosition
                    self.children[i].frame.origin.x = 0
                }
                
                self.childPosition += self.children[i].frame.height + space
            }
            
            self.scroll!.contentSize = CGSize(width: self.frame.width, height:(self.childPosition - self.space))
            
            break
        case .VERTICAL_TWO_COLS:
            
            break
        }
    }
    
    override func refresh(){ }
    
    func addMoreChildren(){
        
        let height:CGFloat = 300
        let width:CGFloat = self.frame.width
        var lastIndex = self.children.count
        var moreChildren = Array<BNView>()
        
        for var i = 0; i < 5; i++ {
            let box = BNView(frame:CGRectMake(0, 0, width, height))
            box.backgroundColor = UIColor.greenColor()
            let label = UILabel(frame:CGRectMake(10, 10, width, 20))
            label.text = "View number: \(lastIndex)"
            box.addSubview(label)
            moreChildren.append(box)
            lastIndex++
        }
        
        addMoreChildren(moreChildren)
    }
    
    
    func addMoreChildren(childrenToAdd:Array<BNView>){
        
        for var i = 0; i < childrenToAdd.count; i++ {
            self.addChild(childrenToAdd[i])
        }
        
        self.doUpdatePosition = false
        self.setChildrenPosition()
        
        isRuningRequest = false
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if isRuningRequest || !updateEnable { return }
        
        switch self.direction! {
        case .HORIZONTAL:
            
            let width = self.scroll!.frame.width
            let contentWidth = self.scroll!.contentSize.width
            let xOffSet = self.scroll!.contentOffset.x
            
            if ((xOffSet + width) >= (contentWidth - width)) {
                isRuningRequest = true
                positionToScroll = xOffSet
                self.father!.request()
            }
            break
        case .VERTICAL, .VERTICAL_TWO_COLS:
            
            let height = self.scroll!.frame.height
            let contentHeight = self.scroll!.contentSize.height
            let yOffSet = self.scroll!.contentOffset.y
            
            if ((yOffSet + height) >= (contentHeight - height)) {
                isRuningRequest = true
                positionToScroll = yOffSet
                self.father!.request()

            }
            break
        }
    }
    
    func clean(){
        
        if self.children.count > 0 {
            
            for view in scroll!.subviews {
                
                if view is ElementMiniView {
                    (view as! ElementMiniView).removeFromSuperview()
                }
            }
            
            children.removeAll(keepCapacity: false)
        }
    }
    
    override func requestCompleted() {
     
    }
    
    func disableRefreshControl(){
        updateEnable = false
    }
}

enum BNScroll_Direction {
    case VERTICAL
    case VERTICAL_TWO_COLS
    case HORIZONTAL
}

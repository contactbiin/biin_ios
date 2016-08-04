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
    var colunmCounter:Int = 0
    var colunmXpos:CGFloat = 0

    var space:CGFloat = 0
    var extraSpace:CGFloat = 0
    var children:Array<BNView> = Array<BNView>()
    var direction:BNScroll_Direction?

    var doUpdatePosition = true
    var positionToScroll:CGFloat = 0
    var updateEnable = true
    
    var isRuningRequest = false
    
    var lastScrollPosition:CGFloat = 0
    var loadingIndicator:UIActivityIndicatorView?
    var loadingIndicatorView:UIView?
    
    var leftSpace:CGFloat = 0
    
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
        
        
        /*
        loadingIndicatorView = UIView(frame:CGRectMake(((frame.width / 2) - 20), ((frame.width / 2) - 20), 50, 50))
        loadingIndicatorView!.backgroundColor = color
        self.addSubview(loadingIndicatorView!)
        
        loadingIndicator = UIActivityIndicatorView(frame: CGRectMake(((frame.width / 2) - 20), ((frame.width / 2) - 20), 40, 40))
        loadingIndicator!.hidesWhenStopped = true
        loadingIndicator!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator!.startAnimating();
        self.addSubview(loadingIndicator!)
        */
        
    }
    
    func addChildAtBegining(view:BNView){
        
        let viewWidth:CGFloat = view.frame.width
        view.frame.origin.x = 0
        childPosition = view.frame.width + space
        
        switch self.direction! {
            case .HORIZONTAL:
                
                for i in (0..<children.count) {
        
                    if self.children[i].frame.width > viewWidth {
                       self.children[i].updateWidth(CGRectMake(self.children[i].frame.origin.x, self.children[i].frame.origin.y, viewWidth, self.children[i].frame.height))
                    }
                    
                    UIView.animateWithDuration(0.2, animations: {()-> Void in
                        self.children[i].frame.origin.x = self.childPosition
                    })
                    
                    self.childPosition += self.children[i].frame.width + space
                }
                
                self.scroll!.contentSize = CGSize(width: (self.childPosition - self.space), height:self.frame.height)
                
                break
            case .VERTICAL:
                break
            case .VERTICAL_TWO_COLS:
                break
        }
        
        children.insert(view, atIndex: 0)
        scroll!.addSubview(view)
    }
    
    func removeChildByIdentifier(identifier:String){
        
//        let viewWidth:CGFloat = view.frame.width
//        view.frame.origin.x = 0
        childPosition = 0
        
//        var startToAnimate = false
        
        switch self.direction! {
        case .HORIZONTAL:
            
            
            for i in (0..<children.count) {

                if self.children[i].model!.identifier! == identifier {
                    self.children[i].removeFromSuperview()
                    self.children.removeAtIndex(i)
                    break
                }
            }
            
            if children.count == 1 {
                print("solo uno")
                let viewWidth:CGFloat = SharedUIManager.instance.screenWidth
                self.children[0].updateWidth(CGRectMake(0, 0, viewWidth, self.children[0].frame.height))
                self.children[0].frame.origin.x = self.childPosition
            } else {
                for i in (0..<children.count) {
            
                    UIView.animateWithDuration(0.2, animations: {()-> Void in
                        self.children[i].frame.origin.x = self.childPosition
                    })
                
                    self.childPosition += self.children[i].frame.width + space
            
                }
            }
            
            self.scroll!.contentSize = CGSize(width: (self.childPosition - self.space), height:self.frame.height)
            
            break
        case .VERTICAL:
            
            for i in (0..<children.count) {
                
                if self.children[i].model!.identifier! == identifier {
                    self.children[i].removeFromSuperview()
                    self.children.removeAtIndex(i)
                    break
                }
            }

            var ypos:CGFloat = 0
            for i in (0..<children.count) {
                UIView.animateWithDuration(0.2, animations: {()-> Void in
                    self.children[i].frame.origin.y = ypos
                    ypos += (self.children[i].frame.height + self.space)
                })
            }

            self.scroll!.contentSize = CGSize(width:self.frame.width, height:ypos)
            
            break
        case .VERTICAL_TWO_COLS:
            break
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
            
            for i in (0..<children.count) {

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
            
            for i in (0..<children.count){
                
                if !children[i].isAddedToScroll {
                    self.children[i].isAddedToScroll = true
                    self.children[i].frame.origin.y = childPosition
                    self.children[i].frame.origin.x = leftSpace
                }
                
                self.childPosition += self.children[i].frame.height + space
            }
            
            self.scroll!.contentSize = CGSize(width: self.frame.width, height:(self.childPosition - self.space + self.extraSpace ))
            
            break
        case .VERTICAL_TWO_COLS:
            
            colunmCounter = 0
            colunmXpos = 0
            for i in (0..<children.count){
                
                self.children[i].isAddedToScroll = true
                self.children[i].frame.origin.y = childPosition
                self.children[i].frame.origin.x = colunmXpos
                
                colunmXpos += self.children[i].frame.width + space
                colunmCounter += 1
                
                if colunmCounter == 2 {
                    colunmCounter = 0
                    colunmXpos = 0
                    childPosition += (children[i].frame.height + space)
                }
            }
            
            if colunmCounter == 1 {
                childPosition += (children[0].frame.height)
            }
            
            self.scroll!.contentSize = CGSize(width: self.frame.width, height:(self.childPosition - self.space))
            
            break
        }
    }
    
    override func refresh(){ }
    
//    func addMoreChildren(){
//        
//        let height:CGFloat = 300
//        let width:CGFloat = self.frame.width
//        var lastIndex = self.children.count
//        var moreChildren = Array<BNView>()
//        
//        for var i = 0; i < 5; i++ {
//            let box = BNView(frame:CGRectMake(0, 0, width, height))
//            box.backgroundColor = UIColor.greenColor()
//            let label = UILabel(frame:CGRectMake(10, 10, width, 20))
//            label.text = "View number: \(lastIndex)"
//            box.addSubview(label)
//            moreChildren.append(box)
//            lastIndex++
//        }
//        
//        addMoreChildren(moreChildren)
//    }
    
    
    func addMoreChildren(childrenToAdd:Array<BNView>){
        
        for i in (0..<childrenToAdd.count) {
//        for var i = 0; i < childrenToAdd.count; i++ {
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
            
            
            //print("yOffSet:\(yOffSet)")
            
            
            if ((yOffSet + height) >= (contentHeight - height)) {
                isRuningRequest = true
                positionToScroll = yOffSet
                self.father!.request()
            }
            
            break
        }
    }
    
    override func clean(){
        
        colunmXpos = 0
        childPosition = 0
        colunmCounter = 0
        
        if self.children.count > 0 {
            
            for view in scroll!.subviews {
                
                view.removeFromSuperview()
//                if view is ElementMiniView {
//                    (view as! ElementMiniView).removeFromSuperview()
//                }
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

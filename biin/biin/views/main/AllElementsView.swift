//
//  AllElementsView.swift
//  biin
//
//  Created by Esteban Padilla on 10/8/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

class AllElementsView: BNView {
    
    var delegate:AllElementsView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var scroll:BNScroll?
//    var showcase:BNShowcase?
    var category:BNCategory?
    var spacer:CGFloat = 1

//    var elements:Array<ElementMiniView>?
//    var addedElementsIdentifiers:Dictionary<String, BNElement>?
    
    var fade:UIView?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father: BNView?, showBiinItBtn:Bool) {
        
        self.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.whiteColor()
        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
//        visualEffectView.frame = self.bounds
//        self.addSubview(visualEffectView)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 10
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, 16))
        let titleText = "All elements"
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.blackColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 0, 35, 35))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
        backBtn!.layer.borderColor = UIColor.darkGrayColor().CGColor
        backBtn!.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        self.addSubview(backBtn!)
        
        ypos = 35
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.darkGrayColor()
        
//        scroll = UIScrollView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - (ypos + 20))))
        scroll = BNScroll(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - (ypos + 20))), father: self, direction: BNScroll_Direction.VERTICAL_TWO_COLS, space: 1, extraSpace: 0, color: UIColor.clearColor(), delegate: nil)
//        scroll!.backgroundColor = UIColor.clearColor()
//        scroll!.pagingEnabled = false
        self.addSubview(scroll!)
        self.addSubview(line)
        
//        addedElementsIdentifiers = Dictionary<String, BNElement>()
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        if state!.stateType != BNStateType.ElementState || state!.stateType == BNStateType.SiteState {
            UIView.animateWithDuration(0.3, animations: {()->Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
                }, completion: {(completed:Bool)->Void in
                    self.scroll!.scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            })
        }
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
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegate!.hideAllElementsView!(self.category)
    }
    
    func isSameCategory(category:BNCategory?) -> Bool {
        if self.category != nil {
            if self.category!.identifier! == category!.identifier! {
                return true
            }
        }
        
        self.category = category
        return false
    }
    
    func isElementAdded(_id:String) -> Bool {
        for view in scroll!.children {
            if (view as! ElementMiniView).element!._id! == _id {
                return true
            }
        }
        return false
    }
    
    func updateCategoryData(category:BNCategory?) {
        
        if !isSameCategory(category) {
//            self.backgroundColor = category!.backgroundColor
            self.scroll!.backgroundColor = category!.backgroundColor
            scroll!.clean()
            let titleText = category!.name!//.uppercaseString
            let attributedString = NSMutableAttributedString(string:titleText)
            attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
            title!.attributedText = attributedString
            
            
//            if elements != nil {
//                addedElementsIdentifiers!.removeAll(keepCapacity: false)
//                for view in elements! {
//                    view.removeFromSuperview()
//                }
//            } else {
//                elements = Array<ElementMiniView>()
//                addedElementsIdentifiers = Dictionary<String, BNElement>()
//            }
            
//            self.showcase = nil
//            showcase = BNShowcase()
            
//            for (_, element) in category!.elements {
//                if addedElementsIdentifiers![element._id!] == nil {
//                    self.showcase!.elements.append(element)
//                    addedElementsIdentifiers![element._id!] = element
//                }
//            }
            
//            var xpos:CGFloat = 0
//            var ypos:CGFloat = 0
//            var colunmCounter = 0
            let miniViewHeight:CGFloat = SharedUIManager.instance.miniView_height
            
            var elementView_width:CGFloat = 0
            
            if category!.elements.count == 1 {
                elementView_width = SharedUIManager.instance.screenWidth
            } else {
                elementView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
            }
            
            var elements = Array<ElementMiniView>()

            
            for (element_id, element) in category!.elements {
                
                if element._id != nil {
                    if !isElementAdded(element._id!) {

           
                        
                        let elementView = ElementMiniView(frame: CGRectMake(0, 0, elementView_width, miniViewHeight), father: self, element:element, elementPosition:0, showRemoveBtn:false, isNumberVisible:false, showlocation:true)
                        
                        elementView.requestImage()
                        elementView.delegate = father! as! MainView
        //                scroll!.addSubview(elementView)
                        elements.append(elementView)
                
//                        xpos += elementView_width + spacer
//                        colunmCounter++
//                        
//                        if colunmCounter == 2 {
//                            colunmCounter = 0
//                            xpos = 0
//                            ypos += (miniViewHeight + 1)
//                        }
                        
                    }
                } else {
                    print("\(element_id)")
                    category!.elements.removeValueForKey(element_id)
                }
            }
            self.scroll!.addMoreChildren(elements)

//            scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
//            scroll!.setContentOffset(CGPointZero, animated: false)
        } else {
            
            let miniViewHeight:CGFloat = SharedUIManager.instance.miniView_height
            
            var elementView_width:CGFloat = 0
            
            if category!.elements.count == 1 {
                elementView_width = SharedUIManager.instance.screenWidth
            } else {
                elementView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
            }
            
            var elements = Array<ElementMiniView>()
            
            for (element_id, element) in category!.elements {
                
                if element._id != nil {
                    if !isElementAdded(element._id!) {
                        
                        
                        
                        let elementView = ElementMiniView(frame: CGRectMake(0, 0, elementView_width, miniViewHeight), father: self, element:element, elementPosition:0, showRemoveBtn:false, isNumberVisible:false, showlocation:true)
                        
                        elementView.requestImage()
                        elementView.delegate = father! as! MainView
                        elements.append(elementView)
                    }
                } else {
                    print("\(element_id)")
                    category!.elements.removeValueForKey(element_id)
                }
            }
            
            self.scroll!.addMoreChildren(elements)
        }
    }
    
    func showFade(){
        UIView.animateWithDuration(0.2, animations: {()-> Void in
            self.fade!.alpha = 0.5
        })
    }
    
    func hideFade(){
        UIView.animateWithDuration(0.5, animations: {()-> Void in
            self.fade!.alpha = 0
        })
    }
    
    func clean(){

        delegate = nil
        title?.removeFromSuperview()
        backBtn?.removeFromSuperview()
//        showcase = nil
        category = nil
        fade?.removeFromSuperview()
//        
//        if elements != nil {
//            for view in elements! {
//                view.clean()
//                view.removeFromSuperview()
//            }
//        }
        
//        elements?.removeAll()
//        addedElementsIdentifiers?.removeAll()
        scroll?.clean()
    }
    
    override func refresh() {
        updateCategoryData(category)
    }
    
    override func request() {
        //        self.showcase!.batch++
        BNAppSharedManager.instance.dataManager.requestElementsForCategory(self.category!, view: self)
    }
    
    override func requestCompleted() {
        updateCategoryData(category)
        self.scroll!.requestCompleted()
    }
}

@objc protocol AllElementsView_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func hideAllElementsView(category:BNCategory?)
}

//  AllCollectedView.swift
//  biin
//  Created by Esteban Padilla on 10/8/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class AllCollectedView: BNView, ElementMiniView_Delegate {
    
    var delegate:AllCollectedView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var scroll:UIScrollView?
    var showcase:BNShowcase?
    var category:BNCategory?
    var spacer:CGFloat = 1
    
    var elements:Array<ElementMiniView>?
    var addedElementsIdentifiers:Dictionary<String, BNElement>?
    
//    var fade:UIView?
    
    var likedElementsBtn:UIButton?
    var likedSitesBtn:UIButton?
    
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
        let titleText = NSLocalizedString("Collections", comment: "title").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.blackColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 0, 35, 35))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
        backBtn!.layer.borderColor = UIColor.darkGrayColor().CGColor
        backBtn!.layer.backgroundColor = UIColor.darkGrayColor().CGColor
//        backBtn!.layer.cornerRadius  = 17.5
//        backBtn!.layer.borderWidth = 1
//        backBtn!.layer.masksToBounds = true
        self.addSubview(backBtn!)
        
        ypos = 35
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.darkGrayColor()
        
        scroll = UIScrollView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - (ypos + 20))))
        scroll!.backgroundColor = UIColor.lightGrayColor()
        scroll!.bounces = false
        scroll!.pagingEnabled = false
        self.addSubview(scroll!)
        self.addSubview(line)
        
        addedElementsIdentifiers = Dictionary<String, BNElement>()
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        
        likedElementsBtn = UIButton(frame: CGRectMake(0, (screenHeight - 80), ((screenWidth / 2) - 2), 60))
        likedElementsBtn!.setTitle("Products", forState: UIControlState.Normal)
        likedElementsBtn!.backgroundColor = UIColor.redColor()
        self.addSubview(likedElementsBtn!)
        
        likedSitesBtn = UIButton(frame: CGRectMake((screenWidth / 2), (screenHeight - 80), (screenWidth / 2), 60))
        likedSitesBtn!.setTitle("Sites", forState: UIControlState.Normal)
        likedSitesBtn!.backgroundColor = UIColor.blueColor()
        self.addSubview(likedSitesBtn!)
        
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
        if state!.stateType != BNStateType.ElementState {
            UIView.animateWithDuration(0.3, animations: {()->Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
                }, completion: {(completed:Bool)->Void in
                    self.scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
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
        delegate!.hideAllCollectedView!()
    }
    
    func updateCollectedElements() {
        
        //print("updateCollectedElements")
        
        if elements != nil {
            addedElementsIdentifiers!.removeAll(keepCapacity: false)
            for view in elements! {
                view.removeFromSuperview()
            }
        } else {
            elements = Array<ElementMiniView>()
            addedElementsIdentifiers = Dictionary<String, BNElement>()
        }
    
        self.showcase = nil
        showcase = BNShowcase()

        /*
        for (_, collection) in BNAppSharedManager.instance.dataManager.bnUser!.collections! {
            for (_,element) in collection.elements {
                if addedElementsIdentifiers![element._id!] == nil {
                    self.showcase!.elements.append(element)
                    addedElementsIdentifiers![element._id!] = element
                }
            }
        }
         */
        
        var xpos:CGFloat = 0
        var ypos:CGFloat = 0
        var colunmCounter = 0
        let miniViewHeight:CGFloat = SharedUIManager.instance.miniView_height
        
        var elementView_width:CGFloat = 0
        
        if showcase!.elements.count == 1 {
            elementView_width = SharedUIManager.instance.screenWidth
        } else {
            elementView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        }
    
        for element_identifier in showcase!.elements {
            
            let element = BNAppSharedManager.instance.dataManager.elements_by_identifier[element_identifier]
            
            let elementView = ElementMiniView(frame: CGRectMake(xpos, ypos, elementView_width, miniViewHeight), father: self, element:element, elementPosition:0, showRemoveBtn:true, isNumberVisible:false, showlocation:false)
            
            elementView.requestImage()
            elementView.delegate = father! as! MainView
            elementView.delegateAllCollectedView = self
            scroll!.addSubview(elementView)
            elements!.append(elementView)
            
            xpos += elementView_width + spacer
            colunmCounter += 1
            
            if colunmCounter == 2 {
                colunmCounter = 0
                xpos = 0
                ypos += (miniViewHeight + 1)
            }
        }

        
        if colunmCounter == 1 {
            ypos += elements![0].frame.height
        }
        
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
        scroll!.setContentOffset(CGPointZero, animated: false)
    }
    
    
//    override func showFade(){
//        UIView.animateWithDuration(0.2, animations: {()-> Void in
//            self.fade!.alpha = 0.5
//        })
//    }
//    
//    func hideFade(){
//        UIView.animateWithDuration(0.5, animations: {()-> Void in
//            self.fade!.alpha = 0
//        })
//    }
    
    override func refresh() {
        updateCollectedElements()
    }
    
    func resizeScrollOnRemoved(view: ElementMiniView) {
        removeElementCollected(view)
    }
    
    func removeElementCollected(view: ElementMiniView){
        
        var xpos:CGFloat = 0
        var ypos:CGFloat = 0
        var colunmCounter = 0
        let miniViewHeight:CGFloat = SharedUIManager.instance.miniView_height
        
        var elementView_width:CGFloat = 0
        

        var i:Int = 0
        for _ in elements! {
//        for var i = 0; i < elements!.count; i++ {
            if elements![i].element!._id! == view.element!._id {
                elements!.removeAtIndex(i)
                continue
            }
            i += 1
        }
        
        i = 0
        
        for _ in elements! {
//        for var i = 0; i < elements!.count; i++ {
            
            if showcase!.elements.count == 1 {
                elementView_width = SharedUIManager.instance.screenWidth
            } else {
                elementView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
            }
            
            elements![i].frame = CGRectMake(xpos, ypos, elementView_width, miniViewHeight)
            
            xpos += elementView_width + spacer
            colunmCounter += 1
            
            if colunmCounter == 2 {
                colunmCounter = 0
                xpos = 0
                ypos += (miniViewHeight + 1)
            }

        }
    }
    
    override func clean(){
        delegate = nil
        title?.removeFromSuperview()
        backBtn?.removeFromSuperview()
        scroll?.removeFromSuperview()
        showcase = nil
        category = nil
        
        if elements != nil {
            for view in elements! {
                view.removeFromSuperview()
            }
        }
        addedElementsIdentifiers?.removeAll()
        elements?.removeAll()
        
        fade?.removeFromSuperview()
    }
    
    func show() {
        
    }
}


@objc protocol AllCollectedView_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func hideAllCollectedView()
}

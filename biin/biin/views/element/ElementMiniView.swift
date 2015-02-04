//  ElementMiniView.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementMiniView: BNView {
    
    var delegate:ElementMiniView_Delegate?
    var element:BNElement?
    var image:BNUIImageView?
    var header:ElementMiniView_Header?
    var imageRequested = false
    
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, element:BNElement?){
        self.init(frame: frame, father:father )
        
        self.layer.borderColor = UIColor.appMainColor().CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        //self.layer.shadowOffset = CGSizeMake(0, 0.5)
        //self.layer.shadowRadius = 1
        //self.layer.shadowOpacity = 0.25
        self.element = BNAppSharedManager.instance.dataManager.elements[element!._id!]
        
        if let color = self.element!.media[0].domainColor? {
            self.backgroundColor = color
        } else {
            self.backgroundColor = UIColor.appMainColor()
        }
        
        
        //Positioning image
        var imageSize = frame.height - SharedUIManager.instance.miniView_headerHeight
        var xpos = ((imageSize - frame.width) / 2 ) * -1
        image = BNUIImageView(frame: CGRectMake(xpos, SharedUIManager.instance.miniView_headerHeight, imageSize, imageSize))
        image!.alpha = 0
        self.addSubview(image!)
        
        header = ElementMiniView_Header(frame: CGRectMake(0, 0, frame.width, SharedUIManager.instance.miniView_headerHeight), father: self, element:self.element)
        self.addSubview(header!)
        header!.updateSocialButtonsForElement(self.element)
        
        var tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isFirstResponder()
    }
    
    override func transitionIn() {
        println("trasition in on SiteMiniView")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on SiteMiniView")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: SiteMiniView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: SiteMiniView")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    func requestImage(){
        
        if imageRequested { return }
        
        imageRequested = true
        BNAppSharedManager.instance.networkManager.requestImageData(element!.media[0].url!, image: image)
    }
    
    /* Gesture hadlers */
    func handleTap(sender:UITapGestureRecognizer) {
        
        //var siteContainer = father as BiinieCategoriesView_SitesContainer
        //var position = father!.father!.convertRect(self.frame, fromView: siteContainer.scroll!)
        //delegate!.showSiteView!(self, site: site, position:position)
        
    }
}

@objc protocol ElementMiniView_Delegate:NSObjectProtocol {
    optional func showElementView(view:ElementMiniView, element:BNElement?, position:CGRect)
}

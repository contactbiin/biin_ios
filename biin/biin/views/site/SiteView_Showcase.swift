//  SiteView_Showcase.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Showcase:BNView, UIScrollViewDelegate {
    
    var title:UILabel?
    var subTitle:UILabel?
    var scroll:UIScrollView?
    var showcase:BNShowcase?
    
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
    
    convenience init(frame: CGRect, father:BNView?, showcase:BNShowcase?) {
        self.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        self.showcase = BNAppSharedManager.instance.dataManager.showcases[showcase!.identifier!]
        //TODO: Add all showcase data here
        
        var ypos:CGFloat = 5
        ypos += 18
        
        title = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.siteView_titleSize + 2)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_titleSize)
        title!.text = self.showcase!.title
        title!.textColor = self.showcase!.titleColor!
        self.addSubview(title!)
        
        ypos += SharedUIManager.instance.siteView_titleSize + 2
        
        subTitle = UILabel(frame: CGRectMake(6, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 2)))
        subTitle!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_subTittleSize)
        subTitle!.textColor = UIColor.appTextColor()
        subTitle!.text = self.showcase!.subTitle!
        self.addSubview(subTitle!)
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        //        var scrollYPos:CGFloat = SharedUIManager.instance.siteView_headerHeight + screenWidth
        var scrollHeight:CGFloat = SharedUIManager.instance.miniView_height + 10
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.siteView_headerHeight, screenWidth, scrollHeight))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.appBackground()
        self.addSubview(scroll!)
        
        addElementViews()
    }
    
    override func transitionIn() {
        println("trasition in on SiteView_Showcase")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on SiteView_Showcase")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: SiteView_Showcase")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: SiteView_Showcase")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance methods
    func updateForSite(site: BNSite?){
     
    }
    
    func addElementViews(){
        
        var xpos:CGFloat = 5
        for element in showcase!.elements {
            var elementView = ElementMiniView(frame: CGRectMake(xpos, 5, SharedUIManager.instance.miniView_width, SharedUIManager.instance.miniView_height), father: self, element: element)
            xpos += SharedUIManager.instance.miniView_width + 5
            scroll!.addSubview(elementView)
        }
        
        
        xpos += 5
        scroll!.contentSize = CGSizeMake(xpos, 0)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.bounces = false
        scroll!.pagingEnabled = false
    }
}


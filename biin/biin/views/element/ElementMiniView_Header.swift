//  ElementMiniView_Header.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementMiniView_Header:BNView {
    
    var buttonsView:SocialButtonsView?
    var circleLabel:BNUICircleLabel?
    var elementPosition:Int?
    
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
    
    convenience init(frame:CGRect, father:BNView?, element:BNElement?, elementPosition:Int, showCircle:Bool){
        self.init(frame: frame, father:father )
        self.backgroundColor = UIColor.appMainColor()
        self.elementPosition = elementPosition
        
        var ypos:CGFloat = 4
        var xpos:CGFloat = 4
        buttonsView = SocialButtonsView(frame: CGRectMake(0, ypos, frame.width, 15), father: self, element: element)
        self.addSubview(buttonsView!)
        
        ypos += 17
        
        if showCircle {
            circleLabel = BNUICircleLabel(frame: CGRectMake(xpos, 24, 25, 25), color:element!.textColor!, text: "\(elementPosition)", textSize: 14, isFilled: false)
            self.addSubview(circleLabel!)
            xpos += 28
            
            if element!.userViewed {
                circleLabel!.animateCircleIn()
            }
        }
        
        var title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 35), (SharedUIManager.instance.miniView_titleSize + 2)))
        title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
        title.textColor = element!.textColor!
        title.text = element!.title!
        self.addSubview(title)
        
        ypos += SharedUIManager.instance.miniView_titleSize + 2
        
        var subTitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 35), (SharedUIManager.instance.miniView_subTittleSize + 2)))
        subTitle.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_subTittleSize)
        subTitle.textColor = UIColor.appTextColor()
        subTitle.text = element!.subTitle!
        self.addSubview(subTitle)
    }
    
    override func transitionIn() {
        println("trasition in on ElementMiniView_Header")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on ElementMiniView_Header")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: ElementMiniView_Header")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: ElementMiniView_Header")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance methods    
    func updateSocialButtonsForElement(element: BNElement?){
        buttonsView!.updateSocialButtonsForElement(element)
    }
    
    func activateCircle(){
        circleLabel!.animateCircleIn()
    }
}

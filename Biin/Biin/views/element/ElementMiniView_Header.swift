//  ElementMiniView_Header.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementMiniView_Header:BNView {

    var circleLabel:BNUICircleLabel?
    var containerView:UIView?
    var elementPosition:Int?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, element:BNElement?, elementPosition:Int, showCircle:Bool){
        self.init(frame: frame, father:father )
        //self.backgroundColor = UIColor.appMainColor()
        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
//        visualEffectView.frame = self.bounds
//        self.addSubview(visualEffectView)
        
        containerView = UIView(frame: self.bounds)
        
//        if element!.showcase!.site!.media.count > 0 {

            containerView!.backgroundColor =  element!.showcase!.site!.organization!.primaryColor!//element!.media[0].vibrantColor
//        } else {
//            containerView!.backgroundColor = UIColor.darkGrayColor()
//        }
        
        self.addSubview(containerView!)
        
        
        self.elementPosition = elementPosition
        
        let ypos:CGFloat = 5
        var xpos:CGFloat = 5

        if showCircle {
            circleLabel = BNUICircleLabel(frame: CGRectMake(xpos, ypos, 25, 25), color:element!.media[0].vibrantColor!, text: "\(elementPosition)", textSize: 14, isFilled: false)
            self.addSubview(circleLabel!)
            xpos += 28
            
            if element!.userViewed {
                circleLabel!.animateCircleIn()
            }
        }
        
//        let percentageViewSize:CGFloat = (SharedUIManager.instance.miniView_headerHeight - 30 )
//        ypos = 5
//        let title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - (xpos + 5 + percentageViewSize)), (SharedUIManager.instance.miniView_titleSize + 3)))
//        title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
//        title.textColor = UIColor.bnGrayDark()
//        title.text = element!.title!
//        self.addSubview(title)
        
//        ypos += SharedUIManager.instance.miniView_titleSize
//        
//        let subTitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - (xpos + 5)), (SharedUIManager.instance.miniView_subTittleSize + 3)))
//        subTitle.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.miniView_subTittleSize)
//        subTitle.textColor = UIColor.bnGrayDark()
//        subTitle.text = element!.subTitle!
//        self.addSubview(subTitle)
    }
    
    override func transitionIn() {

    }
    
    override func transitionOut( state:BNState? ) {

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
    
    //Instance methods    
    func updateSocialButtonsForElement(element: BNElement?){
        //buttonsView!.updateSocialButtonsForElement(element)
    }
    
    func activateCircle(){
        circleLabel!.animateCircleIn()
    }
    
    override func clean() {
        circleLabel?.removeFromSuperview()
        containerView?.removeFromSuperview()
    }
}

//  BNUIPointView.swift
//  Biin
//  Created by Esteban Padilla on 7/18/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNUIPointView:UIView {

    var icon:BNIcon?
    //var iconView:BNIconView?
    //var color = UIColor.appButtonColor()
    var activeColor:UIColor?
    var inactiveColor:UIColor?
    
    var isActive = false
    
    var label:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.setInactive()
    }
    
    convenience init(frame: CGRect, categoryIdentifier:String, activeColor:UIColor) {
        self.init(frame: frame)
        
        label = UILabel(frame: CGRectMake(0, 13, 100, 20))
        label!.textColor = UIColor.whiteColor()
        label!.textAlignment = NSTextAlignment.Center
        label!.alpha = 0
        label!.font = UIFont(name: "Lato-Black", size: 13)
        self.addSubview(label!)
        

        setLabelText(NSLocalizedString(categoryIdentifier, comment:categoryIdentifier))
        
        //createIcon(sectionIdentifier)
        self.activeColor = activeColor
        inactiveColor = UIColor.appButtonColor()
    }
    
    convenience init(frame: CGRect, activeColor:UIColor) {
        self.init(frame:frame)
        self.activeColor = activeColor
        inactiveColor = UIColor.appButtonColor()
    }
    
    
    override func drawRect(rect:CGRect){
        
        if isActive {
            let ovalPath = UIBezierPath(ovalInRect: CGRectMake(1, 1, 8, 8))
            self.activeColor!.setFill()
            ovalPath.fill()
//            UIColor.orangeColor().setStroke()
//            ovalPath.lineWidth = 2
//            ovalPath.stroke()

        }else{
            let ovalPath = UIBezierPath(ovalInRect: CGRectMake(3, 3, 6, 6))
            self.inactiveColor!.setFill()
            ovalPath.fill()
        }
    }
    
    func setInactive(){
        isActive = false
        UIView.animateWithDuration(0.5, animations: {() -> Void in
            self.alpha = 1.0
            self.label?.alpha = 0.0
            //self.iconView?.alpha = 0.0
        })
        
        setNeedsDisplay()
//        iconView?.isActive = true
//        iconView?.setNeedsDisplay()
    }
    
    func setActive(){
        isActive = true
        UIView.animateWithDuration(0.25, animations: {() -> Void in
            self.alpha = 1.0
            //self.label?.alpha = 1.0
            //self.iconView?.alpha = 1.0
        })
        
        setNeedsDisplay()
//        iconView?.isActive = false
//        iconView?.setNeedsDisplay()
    }
    
    func setLabelText(text:String){
        label!.text = text
        label!.sizeToFit()
        let posx = (label!.frame.width / 2)
        label!.frame.origin.x = 0
        label!.frame.origin.x -= (posx - 6)
    }
    
    func createIcon(sectionIdentifier:String){
        /*
        var position:CGRect?
        
        switch sectionIdentifier {
            case "Food":
                icon = BurgerIcon(color: UIColor.whiteColor(), scale: 1.0, position: CGPointMake(0, 0), stroke: 1.0, isFilled: false)
                position = CGRectMake(-10, -35, 32, 32)
            break
            case "MyBiins":
                icon = CactusIcon(color: UIColor.whiteColor(), scale: 1.0, position: CGPointMake(0, 0), stroke: 1.0, isFilled: false)
                position = CGRectMake(-7, -35, 32, 32)
            break
            case "Technology":
                icon = TV(color: UIColor.whiteColor(), scale: 1.0, position: CGPointMake(0, 0), stroke: 1.0, isFilled: false)
                position = CGRectMake(-10, -35, 32, 32)
            break
            case "Shoes":
                icon = ShoesIcon(color: UIColor.whiteColor(), scale: 1.0, position: CGPointMake(0, 0), stroke: 1.0, isFilled: false)
                position = CGRectMake(-10, -30, 32, 32)
            break
        default:
            break
        }
        
        //iconView = BNIconView(frame:position!, icon: icon!)
        //iconView!.backgroundColor = UIColor.clearColor();
        //iconView!.alpha = 0
        //self.addSubview(iconView!)
        */
    }
}

enum BNSectionIcon {
    case BURGER
    case NONE
}
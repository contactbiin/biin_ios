//  BNUIAlertView_Header.swift
//  biin
//  Created by Esteban Padilla on 2/11/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIAlertView_Header:UIView {
    
    var father:BNUIAlertView?
    var icon:BNIcon?
    var type:BNUIAlertView_Type?
    var position:CGPoint?
    var size:CGSize?
    var radius:CGFloat?
    var color:UIColor?
    
    var text:String?
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
        icon = BNIcon_Biin(color: UIColor.appMainColor(), position: CGPoint(x: 5, y: 5))
    }
    
    convenience init(frame: CGRect, type:BNUIAlertView_Type?, text:String?, father:BNUIAlertView?) {
        self.init(frame:frame)
        self.type = type
        self.father = father
        
        //self.layer.shadowOffset = CGSizeMake(0, 2)
        //self.layer.shadowOpacity = 0.15
        
        //radius = 5.0
        self.position = CGPoint(x:0, y:0 )
        self.size = CGSize(width: frame.width, height: frame.height)
        
        self.text = text!.uppercaseString
        
        label = UILabel(frame: CGRectMake(0, 80, SharedUIManager.instance.screenWidth, 18))
        label!.font = UIFont(name: "Lato-Light", size: 16)
        label!.textColor = UIColor.appMainColor()
        label!.textAlignment = NSTextAlignment.Center
        self.addSubview(label!)
        addIcon()
    }
    
    override func drawRect(rect:CGRect){
        
        //// Frames
        let frame = CGRectMake(position!.x, position!.y, size!.width, size!.height)
        
        //// back Drawing
        let backPath = UIBezierPath(rect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height))//UIBezierPath(roundedRect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height), byRoundingCorners: UIRectCorner.BottomLeft | UIRectCorner.BottomRight, cornerRadii: CGSizeMake(radius!, radius!))
        

        backPath.closePath()
        color!.setFill()
        backPath.fill()
        
        //icon?.drawCanvas()
    }
    
    func addIcon(){
        switch self.type! {
        case .Bad_credentials:
            //icon = BNIcon_KeyholeSmall(color: UIColor.appMainColor(), position: CGPoint(x: 11, y: 81))
            self.color = UIColor.bnOrange()
            self.label!.text = text!
            
//            var closeBtn = BNUIButton_CloseAlert(frame: CGRectMake((SharedUIManager.instance.screenWidth - 40), 82, 30, 30))
//            closeBtn.addTarget(father!, action: "closeBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
//            self.addSubview(closeBtn)
            
            break
        case .Please_wait:
            //icon = BNIcon_SmileFace1(color: UIColor.appMainColor(), position: CGPoint(x: 11, y: 81))
            self.color = UIColor.blackColor()
            self.label!.text = text!.uppercaseString
            break
        case .Saved:
            //icon = BNIcon_SmileFace1(color: UIColor.appMainColor(), position: CGPoint(x: 11, y: 81))
            self.color = UIColor.biinColor()
            self.label!.text = text!
            
//            var closeBtn = BNUIButton_CloseAlert(frame: CGRectMake((SharedUIManager.instance.screenWidth - 40), 82, 30, 30), iconColor:self.color!)
//            closeBtn.addTarget(father!, action: "closeBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
//            self.addSubview(closeBtn)
            
            break
        default:
            break
        }
    }
}
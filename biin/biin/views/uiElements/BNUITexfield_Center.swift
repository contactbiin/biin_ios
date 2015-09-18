//  BNUITexfield_Center.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
class BNUITexfield_Center:UIView {
    
    var textField:UITextField?
    var isShowingError = false
    var position:CGPoint?
    var size:CGSize?
    var radius:CGFloat?
    var color:UIColor?
    
    var point:UIView?
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, placeHolderText:String) {
        self.init(frame:frame)
        
        self.backgroundColor = UIColor.appButtonColor_Disable()
        
        textField = UITextField(frame: CGRectMake(15, 0, (frame.width - 50), frame.height))
        textField!.font = UIFont(name: "Lato-Light", size: 18)
        textField!.textColor = UIColor.appTextColor()
//        textField!.placeholder = placeHolderText
        textField!.returnKeyType = UIReturnKeyType.Go
        textField!.keyboardAppearance = UIKeyboardAppearance.Light
        textField!.clearsOnBeginEditing = true
        self.addSubview(textField!)
        
        let str = NSAttributedString(string: placeHolderText, attributes: [NSForegroundColorAttributeName:UIColor.appButtonColor()])
        textField!.attributedPlaceholder = str
        
        radius = 15.0
        self.color = UIColor.appBackground()
        self.position = CGPoint(x:0, y:0 )
        self.size = CGSize(width: frame.width, height: frame.height)
        
        point = UIView(frame: CGRectMake((self.frame.width - 15), 5, 10, 10))
        point!.backgroundColor = UIColor.appButtonColor_Disable()
        point!.layer.cornerRadius = 5
        self.addSubview(point!)
    }
    
    override func drawRect(rect: CGRect) {
        //// Frames
        //let frame = CGRectMake(position!.x, position!.y, size!.width, size!.height)
        
        //// back Drawing
        //let backPath = UIBezierPath(rect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height))
        //color!.setFill()
        //backPath.fill()
        //UIColor.whiteColor().setStroke()
        //backPath.lineWidth = 5
        //backPath.stroke()
    }
    
    func showError(){
        point!.backgroundColor = UIColor.redColor()
        isShowingError = true
        setNeedsDisplay()
    }
    
    func hideError(){
        point!.backgroundColor = UIColor.appMainColor()
        isShowingError = false
        setNeedsDisplay()
    }
    
    func isValid()->Bool {
        if textField!.text!.isEmpty {
            showError()
            return false
        }else {
            hideError()
            return true
        }
    }
}


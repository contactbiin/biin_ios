//
//  BNUITexfield_Top.swift
//  biin
//
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit
class BNUITexfield_Top:UIView {

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
//        self.layer.borderColor = UIColor.appButtonColor_Disable().CGColor
//        self.layer.borderWidth = 1
        
        textField = UITextField(frame: CGRectMake(15, 0, (frame.width - 30), frame.height))
        textField!.font = UIFont(name: "Lato-Light", size: 18)
        textField!.textColor = UIColor.appTextColor()
//        textField!.placeholder = placeHolderText
        textField!.returnKeyType = UIReturnKeyType.Next
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
        //var backPath = UIBezierPath(roundedRect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height), byRoundingCorners: UIRectCorner.TopLeft | UIRectCorner.TopRight, cornerRadii: CGSizeMake(radius!, radius!))
        //backPath.closePath()
        //color!.setFill()
        //backPath.fill()
        
    }
    
    func showError(){
        point!.backgroundColor = UIColor.redColor()
        isShowingError = true
//        setNeedsDisplay()
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
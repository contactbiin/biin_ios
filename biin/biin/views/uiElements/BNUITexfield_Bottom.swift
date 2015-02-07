//  BNUITexfield_Bottom.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
class BNUITexfield_Bottom:UIView {
    
    var textField:UITextField?
    var isShowingError = false
    var position:CGPoint?
    var size:CGSize?
    var radius:CGFloat?
    var color:UIColor?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, placeHolderText:String) {
        self.init(frame:frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        textField = UITextField(frame: CGRectMake(15, 0, (frame.width - 50), frame.height))
        textField!.font = UIFont(name: "Lato-Light", size: 16)
        textField!.textColor = UIColor.appBackground()
        textField!.placeholder = placeHolderText
        textField!.returnKeyType = UIReturnKeyType.Go
        textField!.keyboardAppearance = UIKeyboardAppearance.Light
        textField!.clearsOnBeginEditing = true
        self.addSubview(textField!)
        
        radius = 15.0
        self.color = UIColor.appMainColor()
        self.position = CGPoint(x:0, y:0 )
        self.size = CGSize(width: frame.width, height: frame.height)
    }
    
    override func drawRect(rect: CGRect) {
    
        //// Frames
        let frame = CGRectMake(position!.x, position!.y, size!.width, size!.height)
        
        
        //// back Drawing
        var backPath = UIBezierPath(roundedRect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height), byRoundingCorners: UIRectCorner.BottomLeft | UIRectCorner.BottomRight, cornerRadii: CGSizeMake(radius!, radius!))
        backPath.closePath()
        color!.setFill()
        backPath.fill()
        
    }
    
    func showError(){
        color = UIColor.bnOrange()
        isShowingError = true
        setNeedsDisplay()
    }
    
    func hideError(){
        color = UIColor.appMainColor()
        isShowingError = false
        setNeedsDisplay()
    }
    
    func isValid()->Bool {
        if textField!.text.isEmpty {
            showError()
            return false
        }else {
            hideError()
            return true
        }
    }
    
}

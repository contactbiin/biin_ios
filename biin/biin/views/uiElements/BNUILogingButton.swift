//
//  BNUILogingButton.swift
//  biin
//
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit
class BNUILogingButton:UIButton {
    
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
    
    convenience init(frame:CGRect, color:UIColor, text:String){
        self.init(frame:frame)
        
        radius = 25
        self.color = color
        self.position = CGPoint(x:3, y:3 )
        self.size = CGSize(width: (frame.width - 5), height: (frame.height - 5))
        
        var label = UILabel(frame: CGRectMake(0, ((frame.height - 20) / 2), frame.width, 20))
        label.text = text
        label.textColor = UIColor.appMainColor()
        label.font = UIFont(name: "Lato-Light", size: 18)
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
    }

    override func drawRect(rect: CGRect) {

        //// Frames
        let frame = CGRectMake(position!.x, position!.y, size!.width, size!.height)
        
        
        //// back Drawing
        let backPath = UIBezierPath(roundedRect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height), cornerRadius: radius!)
        color!.setFill()
        backPath.fill()
        UIColor.whiteColor().setStroke()
        backPath.lineWidth = 3
        backPath.stroke()
    }
    

}
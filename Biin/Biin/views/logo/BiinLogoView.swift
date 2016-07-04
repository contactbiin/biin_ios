//  BiinLogoView.swift
//  biin
//  Created by Esteban Padilla on 2/27/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import CoreGraphics
import QuartzCore
import UIKit

class BiinLogoView : UIButton {
    
    
    let i1_line: CGPath = {
        //// Bezier 2 Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(72.71, 76.9))
        bezierPath.addLineToPoint(CGPointMake(72.71, 38.57))
        bezierPath.lineCapStyle = .Round;
        bezierPath.lineJoinStyle = .Round;
        bezierPath.lineWidth = 6
        bezierPath.stroke()
        return bezierPath.CGPath
    }()
    
    let i2_line: CGPath = {
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(89.74, 76.9))
        bezier3Path.addLineToPoint(CGPointMake(89.74, 38.57))
        bezier3Path.lineCapStyle = .Round;
        bezier3Path.lineJoinStyle = .Round;
        bezier3Path.lineWidth = 6
        bezier3Path.stroke()
        return bezier3Path.CGPath
    }()
    
    
    let b_line: CGPath = {
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 0))
        bezierPath.addLineToPoint(CGPointMake(0, 49.19))
        bezierPath.addCurveToPoint(CGPointMake(28.15, 76.9), controlPoint1: CGPointMake(0, 64.51), controlPoint2: CGPointMake(12.68, 76.9))
        bezierPath.addCurveToPoint(CGPointMake(56.15, 49.19), controlPoint1: CGPointMake(43.63, 76.9), controlPoint2: CGPointMake(56.15, 64.51))
        bezierPath.addCurveToPoint(CGPointMake(28.15, 21.48), controlPoint1: CGPointMake(56.15, 33.87), controlPoint2: CGPointMake(43.63, 21.48))
        bezierPath.addCurveToPoint(CGPointMake(15.24, 24.56), controlPoint1: CGPointMake(23.49, 21.48), controlPoint2: CGPointMake(19.13, 22.63))
        bezierPath.lineCapStyle = .Round;
        bezierPath.lineJoinStyle = .Round;
        bezierPath.lineWidth = 6
        bezierPath.stroke()
        return bezierPath.CGPath
    }()
    
    let n_line: CGPath = {
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(106.54, 76.9))
        bezier4Path.addLineToPoint(CGPointMake(106.54, 43.18))
        bezier4Path.addCurveToPoint(CGPointMake(128.47, 21.48), controlPoint1: CGPointMake(106.54, 31.25), controlPoint2: CGPointMake(116.42, 21.48))
        bezier4Path.addCurveToPoint(CGPointMake(150.4, 43.18), controlPoint1: CGPointMake(140.52, 21.48), controlPoint2: CGPointMake(150.4, 31.25))
        bezier4Path.addLineToPoint(CGPointMake(150.4, 76.9))
        bezier4Path.lineCapStyle = .Round;
        
        bezier4Path.lineJoinStyle = .Round;
        
        bezier4Path.lineWidth = 6
        bezier4Path.stroke()
        
        return bezier4Path.CGPath
    }()
    
    let point_1: CGPath = {
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(69.9, 17.6, 7.2, 8.2))
        ovalPath.fill()
        return ovalPath.CGPath
    }()
    
    
    let menuStrokeStart: CGFloat = 0
    let menuStrokeEnd: CGFloat = 1
    
    let hamburgerStrokeStart: CGFloat = 0
    let hamburgerStrokeEnd: CGFloat = 0
    
    
    var letter_b: CAShapeLayer! = CAShapeLayer()
    var letter_i1: CAShapeLayer! = CAShapeLayer()
    var letter_i2: CAShapeLayer! = CAShapeLayer()
    var letter_n: CAShapeLayer! = CAShapeLayer()
    var point1: CAShapeLayer! = CAShapeLayer()
    var point2: CAShapeLayer! = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.letter_b.path = b_line
        self.letter_i1.path = i1_line
        self.letter_i2.path = i2_line
        self.letter_n.path = n_line
        self.point1.path = point_1
        self.point2.path = point_1
        
        for layer in [ self.letter_b,self.letter_i1, self.letter_i2, self.letter_n ] {
            
            layer.fillColor = nil
            layer.strokeColor = UIColor.blackColor().CGColor
            layer.lineWidth = 6
            layer.miterLimit = 6
            layer.lineCap = kCALineCapRound
            layer.masksToBounds = true
            
            let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 6, .Round, .Miter, 6)
            
            layer.bounds = CGPathGetPathBoundingBox(strokingPath)
            
            layer.actions = [
                "strokeStart": NSNull(),
                "strokeEnd": NSNull(),
                "transform": NSNull()
            ]
            
            self.layer.addSublayer(layer)
        }
        
        point1.actions = [
            "strokeStart": NSNull(),
            "strokeEnd": NSNull(),
            "transform": NSNull()
        ]
        point1.fillColor = UIColor(red: 0.904, green: 0.516, blue: 0.109, alpha: 1.000).CGColor
        self.layer.addSublayer(point1)
        
        point2.actions = [
            "strokeStart": NSNull(),
            "strokeEnd": NSNull(),
            "transform": NSNull()
        ]
        point2.fillColor = UIColor(red: 0.904, green: 0.516, blue: 0.109, alpha: 1.000).CGColor
        self.layer.addSublayer(point2)
        
        self.letter_b.strokeStart = hamburgerStrokeStart
        self.letter_b.strokeEnd = hamburgerStrokeEnd
        self.letter_b.position = CGPointMake(35, 45)
        
        self.letter_i1.strokeStart = hamburgerStrokeStart
        self.letter_i1.strokeEnd = hamburgerStrokeEnd
        self.letter_i1.position = CGPointMake(80, 63)
        
        self.point1.position = CGPointMake(6, 8)
        
        self.letter_i2.strokeStart = hamburgerStrokeStart
        self.letter_i2.strokeEnd = hamburgerStrokeEnd
        self.letter_i2.position = CGPointMake(95, 63)
        
        self.point2.position = CGPointMake(21, 8)
        
        
        
        self.letter_n.strokeStart = hamburgerStrokeStart
        self.letter_n.strokeEnd = hamburgerStrokeEnd
        self.letter_n.position = CGPointMake(135, 55)
        
        //        self.point1.strokeStart = hamburgerStrokeStart
        //        self.point1.strokeEnd = hamburgerStrokeEnd
        
    }
    
    var showsMenu: Bool = false {
        didSet {
            
            //            let strokeStart = CABasicAnimation(keyPath: "strokeStart")
            //            strokeStart.toValue = menuStrokeStart
            //            strokeStart.duration = 0.6
            //            strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0, -0.5, 0.5, 1)
            //            strokeStart.delegate = self
            //            self.letter_b.ocb_applyAnimation(strokeStart)
            
            let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            strokeEnd.setValue("b_end", forKey:"animationID")
            strokeEnd.delegate = self
            strokeEnd.toValue = menuStrokeEnd
            strokeEnd.duration = 0.75
            strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            self.letter_b.ocb_applyAnimation(strokeEnd)
            
            
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if let animationID: AnyObject = anim.valueForKey("animationID") {
            
            //print("\(animationID as! String)")
            
            if animationID as! String == "b_end" {
                i1_animation()
            } else if animationID as! String == "i1_end" {
                i2_animation()
            } else if animationID as! String == "i2_end" {
                n_animation()
            }
        }
    }
    
    
    func i1_animation(){
        
        //        let strokeStart = CABasicAnimation(keyPath:"strokeStart")
        //        strokeStart.delegate = self
        //        strokeStart.toValue = menuStrokeStart
        //        strokeStart.duration = 0.3
        //        strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0, -0.15, 0.5, 1)
        //        self.letter_i1.ocb_applyAnimation(strokeStart)
        
        let strokeEnd = CABasicAnimation(keyPath:"strokeEnd")
        strokeEnd.delegate = self
        strokeEnd.setValue("i1_end", forKey:"animationID")
        strokeEnd.toValue = menuStrokeEnd
        strokeEnd.duration = 0.5
        strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.letter_i1.ocb_applyAnimation(strokeEnd)
    }
    
    func i2_animation(){
        //        let strokeStart = CABasicAnimation(keyPath:"strokeStart")
        //        strokeStart.delegate = self
        //        strokeStart.toValue = menuStrokeStart
        //        strokeStart.duration = 0.3
        //        strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0, -0.15, 0.5, 1)
        //        self.letter_i2.ocb_applyAnimation(strokeStart)
        
        let strokeEnd = CABasicAnimation(keyPath:"strokeEnd")
        strokeEnd.delegate = self
        strokeEnd.setValue("i2_end", forKey:"animationID")
        strokeEnd.toValue = menuStrokeEnd
        strokeEnd.duration = 0.4
        strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.letter_i2.ocb_applyAnimation(strokeEnd)
    }
    
    func n_animation(){
        //        let strokeStart = CABasicAnimation(keyPath:"strokeStart")
        //        strokeStart.delegate = self
        //        strokeStart.toValue = menuStrokeStart
        //        strokeStart.duration = 0.3
        //        strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0, -0.15, 0.5, 1)
        //        self.letter_n.ocb_applyAnimation(strokeStart)
        
        let strokeEnd = CABasicAnimation(keyPath:"strokeEnd")
        strokeEnd.delegate = self
        strokeEnd.setValue("n_end", forKey:"animationID")
        strokeEnd.toValue = menuStrokeEnd
        strokeEnd.duration = 0.5
        strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.letter_n.ocb_applyAnimation(strokeEnd)
    }
    
}

extension CALayer {
    func ocb_applyAnimation(animation: CABasicAnimation) {
        let copy = animation.copy() as! CABasicAnimation
        
        if copy.fromValue == nil {
            copy.fromValue = self.presentationLayer()!.valueForKeyPath(copy.keyPath!)
        }
        
        self.addAnimation(copy, forKey: copy.keyPath)
        self.setValue(copy.toValue, forKeyPath:copy.keyPath!)
    }
}

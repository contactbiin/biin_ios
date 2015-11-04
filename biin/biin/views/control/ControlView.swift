//  ControlView.swift
//  Biin
//  Created by Esteban Padilla on 9/9/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import Foundation
import UIKit

class ControlView:BNView {
    
    var centerView:UIView?
    var controlOrientation = ControlOrientation.None
    var isTransitioning = false
    /*
    var awareBtn:BNUICircleButton?
    var likeBtn:BNUICircleButton?
    var commentBtn:BNUICircleButton?
    var sendBtn:BNUICircleButton?
    var removeBtn:BNUICircleButton?
    */
    var initialBtnPosition = CGPointMake(-18, -18)

    var likeBtnRightPosition = CGPointMake(-78, -106)
    var likeBtnLeftPosition = CGPointMake(33, -106)
    
    var commentBtnRightPosition = CGPointMake(-115, -61)
    var commentBtnLeftPosition = CGPointMake(70, -61)

    var sendBtnRightPosition = CGPointMake(-121, -3)
    var sendBtnLeftPosition = CGPointMake(76, -3)

    var removeBtnRightPosition = CGPointMake(-94, 49)
    var removeBtnLeftPosition = CGPointMake(49, 49)
    
    //var buttons = Array<BNUICircleButton>()
    var currentButtonIndex = -1
    
    weak var currentView:BNView?
    
    var buttonsLbl:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father: BNView?) {
        super.init(frame: frame, father: father)
        /*
        centerView = UIView(frame:CGRectMake(-25, -25, 50, 50))
        centerView!.layer.cornerRadius = 25
        centerView!.layer.borderWidth = 2
        centerView!.layer.borderColor = UIColor.bnWhite().CGColor
        centerView!.alpha = 0
        self.addSubview(centerView!)
        
        var btnFrame = CGRectMake(initialBtnPosition.x, initialBtnPosition.y, 40, 40)
        
        awareBtn = BNUICircleButton(frame:btnFrame, color: UIColor.blackColor(), iconColor: UIColor.bnWhite(), iconStroke: 1.5, iconType: BNUIIConType.BookmarkCircle, iconAlignment: BNUIIconAlignment.Center, isIconFilled: true, fontSize: 0, hasLabel:false, alpha:0.5, hasBorder:true, borderWidth:3, borderColor:UIColor.whiteColor(), hasShadow:true)
        self.addSubview(awareBtn!)
        
        likeBtn = BNUICircleButton(frame:btnFrame, color: UIColor.blackColor(), iconColor: UIColor.bnWhite(), iconStroke: 1.5, iconType: BNUIIConType.LikeCircle, iconAlignment: BNUIIconAlignment.Center, isIconFilled: true, fontSize: 0, hasLabel:false, alpha:0.5, hasBorder:true, borderWidth:3, borderColor:UIColor.whiteColor(), hasShadow:true)
        self.addSubview(likeBtn!)
        
        commentBtn = BNUICircleButton(frame:btnFrame, color: UIColor.blackColor(), iconColor: UIColor.bnWhite(), iconStroke: 1.5, iconType: BNUIIConType.CommentCircle, iconAlignment: BNUIIconAlignment.Center, isIconFilled: true, fontSize: 0, hasLabel:false, alpha:0.5, hasBorder:true, borderWidth:3, borderColor:UIColor.whiteColor(), hasShadow:true)
        self.addSubview(commentBtn!)
        
        sendBtn = BNUICircleButton(frame:btnFrame, color: UIColor.blackColor(), iconColor: UIColor.bnWhite(), iconStroke: 1.5, iconType: BNUIIConType.Send, iconAlignment: BNUIIconAlignment.Center, isIconFilled: true, fontSize: 0,hasLabel:false,  alpha:0.5, hasBorder:true, borderWidth:3, borderColor:UIColor.whiteColor(), hasShadow:true)
        self.addSubview(sendBtn!)
        
        removeBtn = BNUICircleButton(frame:btnFrame, color: UIColor.blackColor(), iconColor: UIColor.bnWhite(), iconStroke: 1.5, iconType: BNUIIConType.GarbageCan, iconAlignment: BNUIIconAlignment.Center, isIconFilled: false, fontSize: 0, hasLabel:false, alpha:0.5, hasBorder:true, borderWidth:3, borderColor:UIColor.whiteColor(), hasShadow:true)
        self.addSubview(removeBtn!)
        
        buttons.append(awareBtn!)
        buttons.append(likeBtn!)
        buttons.append(commentBtn!)
        buttons.append(sendBtn!)
        buttons.append(removeBtn!)
        
        buttonsLbl = UILabel(frame: CGRectMake(-20, -143, 40, 15))
        buttonsLbl!.text = "Aware"
        buttonsLbl!.numberOfLines = 0
        buttonsLbl!.textColor = UIColor.whiteColor()
        buttonsLbl!.layer.backgroundColor = UIColor.bnBlack().colorWithAlphaComponent(0.8).CGColor
        buttonsLbl!.layer.cornerRadius = 7
        buttonsLbl!.font = UIFont(name: "Lato-Bold", size: 10)
        buttonsLbl!.textAlignment = NSTextAlignment.Center
        buttonsLbl!.sizeToFit()
        buttonsLbl!.frame = CGRectMake(-20, -143, (buttonsLbl!.frame.width + 20), (buttonsLbl!.frame.height + 1))
        self.addSubview(buttonsLbl!)
        */
        hideUserControl()
    }
    
    override func transitionIn() {
        
        isTransitioning = true
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            
            self.centerView!.alpha = 1
            
            }, completion: {(completed:Bool)->Void in

                self.isTransitioning = false
                
                switch self.controlOrientation {
                case .Left:
                    self.showUserControlForLeftOrientation()
                case .Right:
                    self.showUserControlForRightOrientation()
                default:
                    break
                }
        })
    }
    
    override func transitionOut( nextState:BNState? ) {
        
        
        
        isTransitioning = true
        
        UIView.animateWithDuration(0.1, animations: {()->Void in
        
            self.centerView!.alpha = 0
            
            }, completion: {(completed:Bool)->Void in
                
                self.isTransitioning = false
                self.hideUserControl()
        })
    }
    
    func showUserControlForLeftOrientation() {

        /*
        UIView.animateWithDuration(0.3, animations: {()->Void in
            
            self.awareBtn!.alpha = 1
            self.likeBtn!.alpha = 1
            self.commentBtn!.alpha = 1
            self.sendBtn!.alpha = 1
            self.removeBtn!.alpha = 1
            
        })
        
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            
            self.awareBtn!.frame.origin.y = -123
        }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.05, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            
            self.likeBtn!.frame.origin = self.likeBtnLeftPosition
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.06, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            
            self.commentBtn!.frame.origin = self.commentBtnLeftPosition
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.07, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            
            self.sendBtn!.frame.origin = self.sendBtnLeftPosition
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.08, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            
            self.removeBtn!.frame.origin = self.removeBtnLeftPosition
            
            }, completion: nil)

        */
    }
    
    func showUserControlForRightOrientation() {
/*
        UIView.animateWithDuration(0.3, animations: {()->Void in
            
            self.awareBtn!.alpha = 1
            self.likeBtn!.alpha = 1
            self.commentBtn!.alpha = 1
            self.sendBtn!.alpha = 1
            self.removeBtn!.alpha = 1
            
        })
        
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            
            self.awareBtn!.frame.origin.y = -123
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.05, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            
            self.likeBtn!.frame.origin = self.likeBtnRightPosition

            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.06, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in

            self.commentBtn!.frame.origin = self.commentBtnRightPosition
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.07, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            
            self.sendBtn!.frame.origin = self.sendBtnRightPosition

            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.08, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in

            self.removeBtn!.frame.origin = self.removeBtnRightPosition
            
            }, completion: nil)
*/
    }
    
    func hideUserControl() {
        /*
        buttonsLbl!.alpha = 0
        
        awareBtn!.alpha = 0
        likeBtn!.alpha = 0
        commentBtn!.alpha = 0
        sendBtn!.alpha = 0
        removeBtn!.alpha = 0
        
        awareBtn!.frame.origin.y = -18
        likeBtn!.frame.origin = initialBtnPosition
        commentBtn!.frame.origin = initialBtnPosition
        sendBtn!.frame.origin = initialBtnPosition
        removeBtn!.frame.origin = initialBtnPosition
        */
    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if value {
            
            currentView = son
            transitionIn()
            adjustUserControlOrientation(point)
            self.frame = CGRectMake(point.x, point.y, self.frame.width, self.frame.height)
            
        } else {

            switch currentButtonIndex {
            case 0:
                currentView?.awareBtnAction()
            case 1:
                currentView?.likeBtnAction()
            case 2:
                currentView?.commentBtnAction()
            case 3:
                currentView?.sendBtnAction()
            case 4:
                currentView?.removeBtnAction()
            default:
                break
            }
            
            resetButtons()
            currentButtonIndex = -1
            transitionOut(nil)
            currentView = nil
        }
    }
    
    override func updateUserControl(position:CGPoint){
    }
    
    func resetButtons() {

    }
    
    func adjustButtonLbl(index:Int){

        buttonsLbl!.text = ""
        buttonsLbl!.sizeToFit()
        
        switch index {
        case 0:
            buttonsLbl!.text = "Aware"
        case 1:
            buttonsLbl!.text = "Like"
        case 2:
            buttonsLbl!.text = "Comment"
        case 3:
            buttonsLbl!.text = "Send"
        case 4:
            buttonsLbl!.text = "Remove"
        default:
            break
        }
        
        buttonsLbl!.sizeToFit()
        buttonsLbl!.frame = CGRectMake(getButtonsLblXpos(index), getButtonsLblYpos(index), (buttonsLbl!.frame.width + 20), (buttonsLbl!.frame.height + 4))
    }
    
    func getButtonsLblXpos(index:Int)->CGFloat{
        switch controlOrientation {
        case .Right:
            switch index {
            case 0:
                return -20
            case 1:
                return -95
            case 2:
                return -160
            case 3:
                return -160
            case 4:
                return -160
            default:
                break
            }
        case .Left:
            switch index {
            case 0:
                return -20
            case 1:
                return 50
            case 2:
                return 100
            case 3:
                return 120
            case 4:
                return 100
            default:
                break
            }
        default:
            break
        }
        return 0
    }

    func getButtonsLblYpos(index:Int)->CGFloat {
        switch index {
        case 0:
            return -150
        case 1:
            return -134
        case 2:
            return -87
        case 3:
            return -20
        case 4:
            return 65
        default:
            break
        }
        return 0
    }
    
    func adjustUserControlOrientation(position:CGPoint) {
        if position.x <= (SharedUIManager.instance.screenWidth / 2) {
            controlOrientation = ControlOrientation.Left
        } else {
            controlOrientation = ControlOrientation.Right
        }
    }
}

enum ControlOrientation {
    case None
    case Left
    case Right
}
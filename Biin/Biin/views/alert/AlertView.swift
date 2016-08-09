//  AlertView.swift
//  Biin
//  Created by Esteban Padilla on 7/28/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class AlertView: BNView {
    
    var delegate:AlertView_Delegate?
    var titleLbl:UILabel?
    var textLbl:UILabel?
    var okBtn:UIButton?
    var cancelBtn:BNUIButton_Close?
    var backgroundView:UIView?
    
    var goto:BNGoto?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.clearColor()
        
        var width:CGFloat = SharedUIManager.instance.alertView_Width
        let height:CGFloat = 300
        
        backgroundView = UIView(frame: CGRectMake(0, 0, width, height))
        backgroundView!.backgroundColor = UIColor.whiteColor()
        backgroundView!.layer.cornerRadius = 5
        backgroundView!.layer.masksToBounds = true
        self.addSubview(backgroundView!)
        
        cancelBtn = BNUIButton_Close(frame: CGRect(x: 0, y: (height - 50), width: 50, height: 50), iconColor: UIColor.whiteColor())
        cancelBtn!.backgroundColor = UIColor.bnRed()
        cancelBtn!.icon!.position = CGPoint(x: 18, y: 18)
        cancelBtn!.addTarget(self, action: #selector(self.cancelBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backgroundView!.addSubview(cancelBtn!)
        
        okBtn = UIButton(frame: CGRect(x: 50, y: (height - 50), width: (width - 50), height:50))
        okBtn!.backgroundColor = UIColor.bnBlue()
        okBtn!.setTitle("OK", forState: UIControlState.Normal)
        okBtn!.titleLabel!.font = UIFont(name:"Lato-Black", size:18)
        okBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        okBtn!.addTarget(self, action: #selector(self.okBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backgroundView!.addSubview(okBtn!)
        
        width = (width - 40)
        titleLbl = UILabel(frame: CGRectMake(20, 40, width, 20))
        titleLbl!.font = UIFont(name:"Lato-Black", size:18)
        titleLbl!.textColor = UIColor.appTextColor()
        titleLbl!.textAlignment = NSTextAlignment.Center
        titleLbl!.numberOfLines = 0
        backgroundView!.addSubview(titleLbl!)
        
        textLbl = UILabel(frame: CGRectMake(20, 60, width,18))
        textLbl!.font = UIFont(name:"Lato-Regular", size:16)
        textLbl!.textColor = UIColor.appTextColor()
        textLbl!.textAlignment = NSTextAlignment.Center
        textLbl!.numberOfLines = 0
        backgroundView!.addSubview(textLbl!)
    
        addFade()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
    }
    
    override func setNextState(goto:BNGoto){
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
    
    //Instance Methods
    func cancelBtnAction(sender:UIButton) {
        delegate!.hideOnCancelRequest!(self)
        UIView.animateWithDuration(0.25, animations: {()-> Void in
            self.frame.origin.x = SharedUIManager.instance.screenWidth
        })
    }
    
    func okBtnAction(sender:UIButton) {
        delegate!.hideOnOKRequest!(self, goto:self.goto!)
    }
    
    
    override func clean() {
        delegate = nil
        titleLbl?.removeFromSuperview()
        textLbl?.removeFromSuperview()
        okBtn?.removeFromSuperview()
        cancelBtn?.removeFromSuperview()
        backgroundView?.removeFromSuperview()
    }
    
    func show() {
        
    }
    
    func updateAlertView(title:String, text:String, goto:BNGoto, model:BNObject?) {
        
        self.model = model
        self.goto = goto
        
        var ypos:CGFloat = titleLbl!.frame.origin.y
        titleLbl!.text = title
        titleLbl!.sizeToFit()
        titleLbl!.frame.origin.x = ((self.backgroundView!.frame.width - self.titleLbl!.frame.width) / 2)
        
        ypos += (titleLbl!.frame.height + 20)
        
        textLbl!.frame.origin.y = ypos
        textLbl!.text = text
        textLbl!.sizeToFit()
        textLbl!.frame.origin.x = ((self.backgroundView!.frame.width - self.textLbl!.frame.width) / 2)
        
        let height:CGFloat = (ypos + textLbl!.frame.height + 40 + 50)
        ypos = ((SharedUIManager.instance.screenHeight - height) / 2)
        let xpos:CGFloat = ((SharedUIManager.instance.screenWidth - self.backgroundView!.frame.width) / 2)
        self.backgroundView!.frame = CGRect(x: xpos, y: ypos, width: self.backgroundView!.frame.width, height: height)
        
        cancelBtn!.frame.origin.y = (height - 50)
        okBtn!.frame.origin.y = (height - 50)
    }
    
    func hideAlertFromMainView(){
        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(self.hide(_:)), userInfo: nil, repeats: false)
        
    }
    
    @objc private func hide(sender:NSTimer) {
        UIView.animateWithDuration(0.25, animations: {() -> Void in
            self.frame.origin.x = SharedUIManager.instance.screenWidth
            }, completion: {(completed:Bool) -> Void in
            self.hideFade()
        })
        
    }
}

@objc protocol AlertView_Delegate:NSObjectProtocol {
    optional func hideOnCancelRequest(view:AlertView)
    optional func hideOnOKRequest(view:AlertView, goto:BNGoto)
}

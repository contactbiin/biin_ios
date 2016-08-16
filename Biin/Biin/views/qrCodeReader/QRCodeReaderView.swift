//  QRCodeReaderView.swift
//  Biin
//  Created by Esteban Padilla on 7/28/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class QRCodeReaderView: BNView {
    
    var delegate:QRCodeReaderView_Delegate?
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
        let xpos:CGFloat = ((SharedUIManager.instance.screenWidth - width) / 2)
        
        backgroundView = UIView(frame: CGRect(x: xpos, y: ((SharedUIManager.instance.screenHeight - height) / 2), width:width, height: height))
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
        okBtn!.backgroundColor = UIColor.bnGray()
        okBtn!.setTitle(NSLocalizedString("Reading", comment: "Reading"), forState: UIControlState.Normal)
        okBtn!.titleLabel!.font = UIFont(name:"Lato-Black", size:18)
        okBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        okBtn!.addTarget(self, action: #selector(self.okBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        okBtn!.userInteractionEnabled = false
        backgroundView!.addSubview(okBtn!)
        
        width = (width - 40)
        titleLbl = UILabel(frame: CGRectMake(20, 10, width, 20))
        titleLbl!.font = UIFont(name:"Lato-Black", size:18)
        titleLbl!.textColor = UIColor.appTextColor()
        titleLbl!.textAlignment = NSTextAlignment.Center
        titleLbl!.numberOfLines = 0
        backgroundView!.addSubview(titleLbl!)
        
        addFade()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        
        UIView.animateWithDuration(0.25, animations: {() -> Void in
                self.frame.origin.x = 0
            }, completion: {(completed:Bool) -> Void in
                self.delegate!.addQRCodeReader!()
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
            }, completion: {(completed:Bool) -> Void in
                self.okBtn!.userInteractionEnabled = false
                self.okBtn!.backgroundColor = UIColor.bnGray()
                self.okBtn!.setTitle(NSLocalizedString("Reading", comment: "Reading"), forState: UIControlState.Normal)
        })
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
        delegate!.hideQRCodeReaderView!(self)
        //delegate!.hideOnCancelRequest!(self)
//        UIView.animateWithDuration(0.25, animations: {()-> Void in
//            self.frame.origin.x = SharedUIManager.instance.screenWidth
//        })
    }
    
    func okBtnAction(sender:UIButton) {
        delegate?.addStar!()
        
//        UIView.animateWithDuration(0.25, animations: {()-> Void in
//            self.frame.origin.x = SharedUIManager.instance.screenWidth
//        })
    }
    
    
    override func clean() {
        delegate = nil
        titleLbl?.removeFromSuperview()
        okBtn?.removeFromSuperview()
        cancelBtn?.removeFromSuperview()
        backgroundView?.removeFromSuperview()
    }
    
    func show() {
        
    }

    func addQRCodeReader(){
        
        
    }
    
    func removeQRCodeReader() {
        
    }
    
    func hideAlertFromMainView(){
        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(self.hide(_:)), userInfo: nil, repeats: false)
    }
    
    @objc private func hide(sender:NSTimer) {
        hideFade()
        self.frame.origin.x = SharedUIManager.instance.screenWidth
    }
    
    func showQRCodeReaded(){
        //TODO called readQRCode request.
        
        okBtn!.userInteractionEnabled = true
        okBtn!.setTitle(NSLocalizedString("OK", comment: "OK"), forState: UIControlState.Normal)
        okBtn!.backgroundColor = UIColor.bnBlue()
    }
}

@objc protocol QRCodeReaderView_Delegate:NSObjectProtocol {
    optional func addStar()
    optional func hideQRCodeReaderView(view:QRCodeReaderView)
    optional func addQRCodeReader()
}

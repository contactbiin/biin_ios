//  GiftView.swift
//  Biin
//  Created by Esteban Padilla on 7/2/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.


import Foundation
import UIKit

class GiftView: BNView {
    
    var delegate:GiftView_Delegate?
    var gift:BNGift?
    var image:BNUIImageView?
    var imageRequested = false

    var removeItButton:BNUIButton_LikeIt?
    var titleLbl:UILabel?
    var messageLbl:UILabel?
    var receivedLbl:UILabel?
    
    var actionBtn:UIButton?
    var shareBtn:UIButton?
    
    var expiredTitleLbl:UILabel?
    var expiredDateLbl:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, gift:BNGift?){
        
        self.init(frame: frame, father:father )
        
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        self.gift = gift
        
        removeItButton = BNUIButton_LikeIt(frame: CGRectMake((frame.width - 30), (5), 25, 25))
        removeItButton!.icon!.color = UIColor.grayColor()
        removeItButton!.changedIcon(true)
        removeItButton!.setNeedsDisplay()
        removeItButton!.addTarget(self, action: #selector(self.removeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(removeItButton!)
        
        
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        
    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
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
    
    func requestImage(){
        
        if imageRequested { return }
        
        imageRequested = true
        
        if gift!.imageUrl != "" {
            BNAppSharedManager.instance.networkManager.requestImageData(gift!.imageUrl!, image: image)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
    }
    
    override func refresh() {
        
    }
    
    override func clean(){
        delegate = nil
        gift = nil
        image?.removeFromSuperview()
        removeItButton?.removeFromSuperview()
        
    }

    func removeBtnAction(sender:UIButton){

    }
}

@objc protocol GiftView_Delegate:NSObjectProtocol {
//    optional func showElementView( view:ElementMiniView, element:BNElement )
//    optional func showElementViewFromSite( view:ElementMiniView, element:BNElement )
//    optional func resizeScrollOnRemoved(view:ElementMiniView )
}

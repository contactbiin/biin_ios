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

    var removeItButton:BNUIButton_Close?
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
        
        
        var xpos:CGFloat = 5
        var ypos:CGFloat = 5
        var width:CGFloat = 1
        let height:CGFloat = 1
        var viewHeight:CGFloat = 0
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        self.gift = gift
        
        removeItButton = BNUIButton_Close(frame: CGRectMake((frame.width - 27), 5, 22, 22), iconColor: UIColor.bnGrayLight())
        removeItButton!.icon!.color = UIColor.bnGrayLight()
        removeItButton!.addTarget(self, action: #selector(self.removeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(removeItButton!)
        
        image = BNUIImageView(frame: CGRectMake(xpos, ypos, SharedUIManager.instance.giftView_imageSize, SharedUIManager.instance.giftView_imageSize), color:UIColor.bnGrayLight())
        self.addSubview(image!)
        requestImage()
        
        ypos = 5
        xpos = (SharedUIManager.instance.giftView_imageSize + 10)
        width = (frame.width - (xpos + 27))
        titleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height: height))
        titleLbl!.text = gift!.name!
        titleLbl!.textColor = UIColor.biinColor()
        titleLbl!.font = UIFont(name: "Lato-Black", size: 24)
        titleLbl!.textAlignment = NSTextAlignment.Left
        titleLbl!.numberOfLines = 0
        titleLbl!.sizeToFit()
        self.addSubview(titleLbl!)
        
        viewHeight += 10
        viewHeight += titleLbl!.frame.height
        
        
        ypos = viewHeight
        width = (frame.width - (xpos + 5))
        messageLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width:width, height: height))
        messageLbl!.text = gift?.message!
        messageLbl!.textColor = UIColor.bnGrayDark()
        messageLbl!.font = UIFont(name: "Lato-Light", size: 14)
        messageLbl!.textAlignment = NSTextAlignment.Left
        messageLbl!.numberOfLines = 0
        messageLbl!.sizeToFit()
        self.addSubview(messageLbl!)
        
        viewHeight += 5
        viewHeight += messageLbl!.frame.height
        
        ypos = viewHeight
        receivedLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height: height))
        receivedLbl!.text = gift!.receivedDate!.bnDisplayDateFormatt().uppercaseString
        receivedLbl!.textColor = UIColor.bnGrayDark()
        receivedLbl!.font = UIFont(name: "Lato-Regular", size: 10)
        receivedLbl!.textAlignment = NSTextAlignment.Left
        receivedLbl!.numberOfLines = 0
        receivedLbl!.sizeToFit()
        self.addSubview(receivedLbl!)
        
        
        viewHeight += receivedLbl!.frame.height
        viewHeight += 5
        
        if viewHeight >= (SharedUIManager.instance.giftView_imageSize + 10) {
            ypos = viewHeight
        } else {
            ypos = (SharedUIManager.instance.giftView_imageSize + 10)
        }

        receivedLbl!.frame.origin.y = (ypos - (receivedLbl!.frame.height + 2))

        let line = UIView(frame: CGRect(x: 5, y: ypos, width: (frame.width - 10), height: 1))
        line.backgroundColor = UIColor.bnGrayLight()
        self.addSubview(line)
        
        if viewHeight >= (SharedUIManager.instance.giftView_imageSize + 10) {
            viewHeight += SharedUIManager.instance.giftView_bottomHeight
            self.frame = CGRect(x: 0, y: 0, width: frame.width, height: viewHeight)
        }
        

        
        
        
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

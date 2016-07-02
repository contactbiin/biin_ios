//  SiteView_Showcase_Join.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Showcase_Join:BNView {
    
    var youSeenTitleLbl:UILabel?
    var youSeenLbl:UILabel?
    
    var circleIcon:BNUIJoinGameIconView?
    
//    override init() {
//        super.init()
//    }
    
    deinit {

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, showcase:BNShowcase ) {
        
        self.init(frame:frame, father:father)
        
        self.backgroundColor = UIColor.appMainColor()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        self.layer.masksToBounds = true
        
        youSeenTitleLbl = UILabel(frame: CGRectMake(0, (frame.height * 0.6), frame.width, 22))
        youSeenTitleLbl!.font = UIFont(name: "Lato-Regular", size: 20)
        youSeenTitleLbl!.textColor = UIColor.appTextColor()
        youSeenTitleLbl!.text = NSLocalizedString("JoinUs", comment: "title")
        youSeenTitleLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(youSeenTitleLbl!)
        
        youSeenLbl = UILabel(frame: CGRectMake(0, (frame.height * 0.7), frame.width, 18))
        youSeenLbl!.font = UIFont(name: "Lato-Light", size: 16)
        youSeenLbl!.textColor = UIColor.appTextColor()
        youSeenLbl!.text = NSLocalizedString("StartToEnjoy", comment: "title")
        youSeenLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(youSeenLbl!)
        
        circleIcon = BNUIJoinGameIconView(frame: CGRectMake(((frame.width / 2) - 43 ), (frame.height * 0.2 ), 86, 86), father: self, color:UIColor.biinColor())
        self.addSubview(circleIcon!)
        
    }
    
    /* Overide methods from BNView */
    override func transitionIn() {

        
    }
    
    override func transitionOut( state:BNState? ) {

    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
        father!.setNextState(goto)
    }
    
    override func changeJoinBtnText(text: String) {
        
    }
    
}


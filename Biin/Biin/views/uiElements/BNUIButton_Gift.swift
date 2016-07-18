//  BNUIButton_Gift.swift
//  Biin
//  Created by Esteban Padilla on 7/11/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIButton_Gift:BNUIButton {
    
    var titleLbl:UILabel?
    var expiredTitleLbl:UILabel?
    var expiredDateLbl:UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, hasExpiration:Bool, color:UIColor?) {
        
        self.init(frame:frame)
        
        self.color = color
        self.backgroundColor = color
        self.layer.cornerRadius  = 3
        self.layer.masksToBounds = true
        
        let height:CGFloat = 12
        var ypos:CGFloat = ((frame.height - height) / 2)
        
        if hasExpiration {
            ypos = ((frame.height - (height + height + 5)) / 2)
        }
        
        titleLbl = UILabel(frame: CGRect(x: 0, y:ypos, width: frame.width, height: height))
        titleLbl!.text = "Recoje tu regalo en la tienda."
        titleLbl!.textColor = UIColor.whiteColor()
        titleLbl!.font = UIFont(name: "Lato-Light", size: height)
        titleLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(titleLbl!)
        
        if hasExpiration {
           
            let expiredTitle_Length = SharedUIManager.instance.getStringLength("Expira:", fontName: "Lato-Light", fontSize:height)
            
            let expiredDate_Length = SharedUIManager.instance.getStringLength("Lunes, Junio 13", fontName: "Lato-Black", fontSize:height)
            
            var xpos:CGFloat = ((frame.width - (expiredTitle_Length + expiredDate_Length)) / 2)
            ypos += (height + 5)
            
            expiredTitleLbl = UILabel(frame: CGRect(x:xpos, y: ypos, width:(frame.width / 2), height:height))
            expiredTitleLbl!.text = "Expira:"
            expiredTitleLbl!.textColor = UIColor.whiteColor()
            expiredTitleLbl!.font = UIFont(name: "Lato-Light", size: height)
            expiredTitleLbl!.textAlignment = NSTextAlignment.Right
            expiredTitleLbl!.sizeToFit()
            self.addSubview(expiredTitleLbl!)

            xpos += (expiredTitle_Length + 2)
            expiredDateLbl = UILabel(frame: CGRect(x:xpos, y:ypos, width:(frame.width / 2), height:height))
            expiredDateLbl!.text = "Lunes, Junio 13"
            expiredDateLbl!.textColor = UIColor.whiteColor()
            expiredDateLbl!.font = UIFont(name: "Lato-Black", size:height)
            expiredDateLbl!.textAlignment = NSTextAlignment.Right
            expiredDateLbl!.sizeToFit()
            self.addSubview(expiredDateLbl!)
        }
    }
    
    override func showEnable() {
        icon!.color = UIColor.appIconColor()
        self.enabled = true
    }
    
    override func showDisable() {
        icon!.color = UIColor.appButtonColor_Disable()
        self.enabled = false
    }
}
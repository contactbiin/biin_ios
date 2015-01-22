//  BNUIImageView.swift
//  biin
//  Created by Esteban Padilla on 1/19/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

///This class inherites from UIImageView and is use to set it's alpha after downloading it's image.

import Foundation
import  UIKit

class BNUIImageView:UIImageView {
    
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    ///Set it's alpha to 1 once download is completed.
    ///:param: Network manager that handled the request.
    ///:param: BNShowcase received from web service in json format already parse in an showcase object.
    func showAfterDownload(){
        UIView.animateWithDuration(0.25, animations: {()-> Void in
            self.alpha = 1
        })
    }
    
}

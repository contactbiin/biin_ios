//  BNUIImageView.swift
//  biin
//  Created by Esteban Padilla on 1/19/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

///This class inherites from UIImageView and is use to set it's alpha after downloading it's image.

import Foundation
import  UIKit

class BNUIImageView:UIImageView {
    
    var loadingIndicator:UIActivityIndicatorView?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadingIndicator = UIActivityIndicatorView(frame: CGRectMake(((frame.width / 2) - 20), ((frame.width / 2) - 20), 40, 40))
        loadingIndicator!.hidesWhenStopped = true
        loadingIndicator!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator!.startAnimating();
        self.addSubview(loadingIndicator!)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    ///Set it's alpha to 1 once download is completed.
    func showAfterDownload(){
        
        loadingIndicator!.stopAnimating()
        self.alpha = 0
        
        UIView.animateWithDuration(0.5, animations: {()-> Void in
            self.alpha = 1
        })
    }
    
}

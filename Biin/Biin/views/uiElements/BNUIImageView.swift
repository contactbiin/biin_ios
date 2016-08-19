//  BNUIImageView.swift
//  biin
//  Created by Esteban Padilla on 1/19/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

///This class inherites from UIImageView and is use to set it's alpha after downloading it's image.

import Foundation
import  UIKit

class BNUIImageView:UIImageView {
    
    
    var useCache = true
//    var loadingIndicator:UIActivityIndicatorView?
    var loadingIndicator:BNActivityIndicator?
//    override init() {
//        super.init()
//    }
    
    var cover:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        cover = UIView(frame: frame)
//        cover!.backgroundColor = UIColor.whiteColor()
//        self.addSubview(cover!)
//        
//        loadingIndicator = UIActivityIndicatorView(frame: CGRectMake(((frame.width / 2) - 20), ((frame.width / 2) - 20), 40, 40))
//        loadingIndicator!.hidesWhenStopped = true
//        loadingIndicator!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        loadingIndicator!.startAnimating();
//        self.addSubview(loadingIndicator!)
    }
    
    convenience init(frame: CGRect, color:UIColor) {
        self.init(frame:frame)
        
        self.backgroundColor = color
        
        cover = UIView(frame: CGRectMake(0, 0, frame.width, frame.height))
        cover!.backgroundColor = color
        self.addSubview(cover!)
        
        loadingIndicator = BNActivityIndicator(frame:CGRectMake(((frame.width / 2) - 15), ((frame.height / 2) - 15), 30, 30))
//        loadingIndicator!.hidesWhenStopped = true
//        loadingIndicator!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        loadingIndicator!.startAnimating();
        self.addSubview(loadingIndicator!)
        loadingIndicator!.start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        loadingIndicator = nil
    }
    
    ///Set it's alpha to 1 once download is completed.
    func showAfterDownload(){
        //let imageRef = image!.CGImage
        //let height:CGFloat = CGFloat(CGImageGetHeight(imageRef))
        //let size:CGFloat =  CGFloat((CGFloat(CGImageGetBytesPerRow(imageRef)) * height))

        
        //BNAppSharedManager.instance.addImagesMB(size)
        loadingIndicator!.stop()
        loadingIndicator!.removeFromSuperview()
//        loadingIndicator!.stopAnimating()
        //self.alpha = 0
        
        UIView.animateWithDuration(0.25, animations: {()-> Void in
            //self.alpha = 1
            self.cover!.alpha = 0
        })
    }
    
    func clean() {
        self.image = nil
    }
    
    func updatePosition(frame:CGRect){
        
        var ypos:CGFloat = 0
        var xpos:CGFloat = 0
        var imageSize:CGFloat = 0
        
        let headerHeightForImage:CGFloat = SharedUIManager.instance.siteMiniView_headerHeight
        
        if frame.width == frame.height {
            imageSize = (frame.width)
            xpos = ((imageSize - frame.width) / 2) * -1
            ypos = ((imageSize - frame.height) / 2) * -1
            
        } else if frame.width < (frame.height - headerHeightForImage) {
            imageSize = (frame.height - headerHeightForImage)
            xpos = ((imageSize - (frame.height - headerHeightForImage)) / 2) * -1
        } else {
            imageSize = frame.width
            ypos = ((imageSize - (frame.height - headerHeightForImage)) / 2) * -1
        }
        
        self.frame = CGRectMake(xpos, ypos, imageSize, imageSize)
    }
    
}

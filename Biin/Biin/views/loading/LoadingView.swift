//  LoadingView.swift
//  biin
//  Created by Esteban Padilla on 1/15/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoadingView:UIView {

    var loadingLbl:UILabel?
    var biinLogo:BNUIBiinView?
    var progressView:UIProgressView?
    var version:UILabel?
    var lastProgressValue:Float = 0.0

    var scroll:UIScrollView?
    var currentHighlight:Int = 0
    var timer:NSTimer?
    
    var biinLogoView:BiinLogoView?
    
    var loadingIndicator:BNActivityIndicator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //NSLog("LoadingView()")
        
        self.backgroundColor = UIColor.whiteColor()
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        //var xpos:CGFloat = ((screenHeight - screenWidth) / 2) * -1
        var ypos:CGFloat = 0//((screenHeight - (330 + SharedUIManager.instance.signupView_spacer + SharedUIManager.instance.signupView_spacer )) / 2)
        
        /*
        scroll = UIScrollView(frame: CGRectMake(xpos, 0, screenHeight, screenHeight))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.backgroundColor = UIColor.clearColor()
        scroll!.pagingEnabled = true
        scroll!.userInteractionEnabled = false
        self.addSubview(scroll!)
        
        
        let image1 = UIImageView(image: UIImage(named: "loading1.jpg"))
        image1.frame = CGRectMake(0, 0, screenHeight, screenHeight)
        scroll!.addSubview(image1)
        
        xpos = screenHeight
        let image2 = UIImageView(image: UIImage(named: "loading2.jpg"))
        image2.frame = CGRectMake(xpos, 0, screenHeight, screenHeight)
        scroll!.addSubview(image2)
        
        xpos += screenHeight
        let image3 = UIImageView(image: UIImage(named: "loading3.jpg"))
        image3.frame = CGRectMake(xpos, 0, screenHeight, screenHeight)
        scroll!.addSubview(image3)

        xpos += screenHeight
        let image4 = UIImageView(image: UIImage(named: "loading4.jpg"))
        image4.frame = CGRectMake(xpos, 0, screenHeight, screenHeight)
        scroll!.addSubview(image4)
        
        
        xpos += screenHeight
        scroll!.contentSize = CGSize(width: xpos, height: screenHeight)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.alpha = 1
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
        
        
        let viewDark = UIView(frame: self.bounds)
        viewDark.backgroundColor = UIColor.whiteColor()
        self.addSubview(viewDark)
        */
        
        biinLogo = BNUIBiinView(position:CGPoint(x:0, y:ypos), scale:SharedUIManager.instance.signupView_logoSize)
        biinLogo!.frame.origin.x = ((screenWidth - biinLogo!.frame.width) / 2)
//        biinLogo!.frame.origin.y = (((screenHeight - biinLogo!.frame.height) / 2) - 50)
        biinLogo!.icon!.color = UIColor.blackColor()
        self.addSubview(biinLogo!)
        biinLogo!.setNeedsDisplay()

        ypos += (biinLogo!.frame.height + 5)// + biinLogo!.frame.origin.y
        //ypos += 5
        
        version = UILabel(frame: CGRectMake(0, ypos, screenWidth, 15))
        version!.font = UIFont(name: "Lato-Light", size: 13)
        version!.textColor = UIColor.blackColor()
        version!.textAlignment = NSTextAlignment.Center
        let versionTxt = NSLocalizedString("Version", comment: "the version title")
        version!.text = "\( versionTxt ) \(BNAppSharedManager.instance.version)"
        self.addSubview(version!)

        ypos = ((screenHeight - ypos) / 2)
        biinLogo!.frame.origin.y = ypos
        ypos += biinLogo!.frame.height
        version!.frame.origin.y = ypos
        
        progressView = UIProgressView(frame: CGRectMake(0, (screenHeight - 4), screenWidth, 2))
        progressView!.setProgress(0.0, animated: false)
        progressView!.progressViewStyle = UIProgressViewStyle.Default
        progressView!.trackTintColor = UIColor.whiteColor()
        progressView!.progressTintColor = UIColor.biinOrange()
        self.addSubview(progressView!)
        
        
        
        
        loadingLbl = UILabel(frame: CGRect(x:0, y:(screenHeight - 25), width:frame.width, height:18))
        loadingLbl!.font = UIFont(name: "Lato-Light", size: 15)
        loadingLbl!.textColor = UIColor.blackColor()
        loadingLbl!.textAlignment = NSTextAlignment.Center
        loadingLbl!.numberOfLines = 0
        loadingLbl!.text = NSLocalizedString("Loading", comment: "the Loading title")
        self.addSubview(loadingLbl!)
        
        
        loadingIndicator = BNActivityIndicator(frame:CGRectMake(((frame.width / 2) - 15), (screenHeight - 50), 20, 20))
        loadingIndicator!.rectShape!.strokeColor = UIColor.biinOrange().CGColor
        loadingIndicator!.rectShape!.fillColor = UIColor.clearColor().CGColor
        self.addSubview(loadingIndicator!)
        loadingIndicator!.start()
        
        
        //self.layerGradient()
    
//        biinLogoView = BiinLogoView(frame: CGRectMake(20, 100, 165, 90))
//        self.addSubview(biinLogoView!)
//        self.biinLogoView!.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        
        //biinLogoView!.startAnimation()
    }
    
    func toggle(sender: AnyObject!) {
        self.biinLogoView!.showsMenu = !self.biinLogoView!.showsMenu
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateProgressView(value:Float){
        
        if value > lastProgressValue {

            lastProgressValue = value
            progressView!.setProgress(value, animated: true)
            if value > 0.75 {
                loadingLbl!.text = NSLocalizedString("Finishing", comment: "the Finishing title")
            }
        }
    }
    
    func showHardwareError() {
        
        loadingLbl!.alpha = 0
        biinLogo!.alpha = 0
        
        let labelHeight:CGFloat = 80.0
        let ypos:CGFloat = (frame.height / 2) - (labelHeight / 2)
        let errorLbl = UILabel(frame: CGRect(x:25, y:ypos, width:(self.frame.width - 50), height:labelHeight))
        errorLbl.font = UIFont(name: "Lato-Light", size: 18)
        errorLbl.text = NSLocalizedString("HardwareError", comment: "HardwareError")
        errorLbl.textColor = UIColor.blackColor()
        errorLbl.textAlignment = NSTextAlignment.Center
        errorLbl.numberOfLines = 3

        self.addSubview(errorLbl)

    }
    
    func hideProgressView(){
        UIView.animateWithDuration(0.1, animations: {() -> Void in
            self.loadingLbl!.alpha = 0
            self.progressView!.alpha = 0
            self.version!.alpha = 0
        })
    }
    
    func change(sender:NSTimer){
        
        //biinLogoView!.startAnimation()

//        
//        if currentHighlight <= 3 {
//            let xpos:CGFloat = (SharedUIManager.instance.screenHeight * CGFloat(currentHighlight))
//            scroll!.setContentOffset(CGPoint(x:xpos, y: 0), animated: true)
//            currentHighlight++
//        } else {
//            scroll!.setContentOffset(CGPoint(x:0, y: 0), animated: false)
//            currentHighlight = 0
//        }
    }
    
    func stopTimer(){
        self.timer!.invalidate()
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector(self.change(_:)), userInfo: nil, repeats: false)
        timer!.fire()
    }
}
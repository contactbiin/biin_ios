//  PrivacyPolicyView.swift
//  biin
//  Created by Esteban Padilla on 4/23/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class PrivacyPolicyView:UIView, UIWebViewDelegate {
    
    var delegate:PrivacyPolicyView_Delegate?
    
    var title:UILabel?
    var warning:UILabel?
    var backBtn:BNUIButton_Back?
    var acceptBtn:UIButton?
    
    var loadingLbl:UILabel?
    var loadingIndicator:BNActivityIndicator?
    
    var webView:UIWebView?
    var scroll:UIScrollView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var line = UIView(frame: CGRectMake(0, 35, screenWidth, 1))
        line.backgroundColor = UIColor.appButtonColor_Disable()
        self.addSubview(line)
        
        var ypos:CGFloat = 10
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, 16))
        let titleText = NSLocalizedString("PrivacyPolicy", comment: "PrivacyPolicy").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.darkGrayColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 0, 35, 35))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()
        backBtn!.layer.backgroundColor = UIColor.biinOrange().CGColor
        backBtn!.layer.masksToBounds = true
        self.addSubview(backBtn!)
        
        scroll = UIScrollView(frame: CGRectMake(0, 36, screenWidth, (screenHeight - 35)))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.pagingEnabled = false
        self.addSubview(scroll!)
        
        loadingIndicator = BNActivityIndicator(frame:CGRectMake(((frame.width / 2) - 15), ((frame.height / 2) - 15), 30, 30))
        loadingIndicator!.rectShape!.strokeColor = UIColor.blackColor().colorWithAlphaComponent(0.5).CGColor
        self.addSubview(loadingIndicator!)
        loadingIndicator!.start()
        
        line = UIView(frame: CGRectMake(0, (screenHeight - 85), screenWidth, 1))
        line.backgroundColor = UIColor.biinOrange()
        self.addSubview(line)
        
        warning = UILabel(frame: CGRectMake(6, (screenHeight - 83), screenWidth, 16))
        warning!.text = NSLocalizedString("TermOfUserWarning", comment: "TermOfUserWarning")
        warning!.font = UIFont(name:"Lato-Black", size:12)
        warning!.textColor = UIColor.darkGrayColor()
        warning!.textAlignment = NSTextAlignment.Left
        warning!.alpha = 0
        self.addSubview(warning!)
        ypos += 20
        
        acceptBtn = UIButton(frame: CGRectMake(5, (screenHeight - 65), (frame.width - 10), 60))
        acceptBtn!.backgroundColor = UIColor.biinOrange()
        acceptBtn!.layer.cornerRadius = 2
        acceptBtn!.setTitle(NSLocalizedString("Accept", comment: "Accept"), forState: UIControlState.Normal)
        acceptBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 15)
        acceptBtn!.addTarget(self, action: #selector(self.acceptBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(acceptBtn!)
        acceptBtn!.alpha = 0
        
        loadWebView()
        
    }
    
    func loadWebView() {
        
        self.bringSubviewToFront(self.loadingIndicator!)
        
        
        if webView != nil {
            webView!.removeFromSuperview()
            webView = nil
        }
        
        webView = UIWebView(frame:CGRectMake(0, 35, SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenHeight - (35 + 90))))
        webView!.delegate = self
        
        let idioma = NSLocalizedString("Yes", comment: "Yes")
        var url:NSURL?
        
        if idioma == "si" {
            url = NSURL(string: "https://www.biin.io/es/termsofuse.html")
        } else {
            url = NSURL(string: "https://www.biin.io/en/termsofuse.html")
        }
    
        let urlRequest = NSURLRequest(URL: url!)
        webView!.loadRequest(urlRequest)
        webView!.alpha = 1
//        webView!.loadHTMLString("http://www.google.com", baseURL: NSURL(string:"http://www.google.com"))
        webView!.scrollView.userInteractionEnabled = true
        self.addSubview(webView!)
    }
    
    func getHtmlBody() ->String {
        
        var html = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><head>"
        html += "<style>"
        html += getBiinCSS()
        html += "</style></head>"
        html += "<body>"
        html += BNAppSharedManager.instance.dataManager.privacyPolicy!
        html += "</body></html>"
        return html
    }
    
    func getBiinCSS() -> String {
        
        var css = ""
        css += "html { font-family: Lato, Helvetica, sans-serif; background-color: rgb(255,255,255); margin-left: 30px !important; margin-right: 30px !important;}"
        css += "p { font-size: 14px; font-weight:300 !important;}"
        css += "b { font-size: 14px; font-weight:500 !important;}"
        css += "h1 { font-size: 30px; font-weight:600 !important;}"
        css += "h2 { font-size: 25px; font-weight:600 !important;}"
        css += "h3 { font-size: 25px; font-weight:600 !important;}"
        css += "blockquote { border-left: 2px solid rgb(0, 0, 0); margin: 1.5em 10px; padding: 0.5em 10px; quotes:none;}"
        css += "blockquote:before { content: open-quote; vertical-align:middle; }"
        css += "blockquote p { font-size:25px; font-weight: 300; display: inline; }"
        return css
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadingIndicator!.stop()
        UIView.animateWithDuration(0.5, animations: {()->Void in
            self.webView!.alpha = 1
            self.warning!.alpha = 1
            self.acceptBtn!.alpha = 1
        })
        
//        var frame:CGRect = webView.frame
//        frame.size.height = 1
//        webView.frame = frame
//        let fittingSize:CGSize = webView.sizeThatFits(CGSizeZero)
//        frame.size = fittingSize
//        webView.frame = frame
//        
//        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (fittingSize.height + 100))
//        
        
//        scroll!.bringSubviewToFront(acceptBtn!)
//        acceptBtn!.frame.origin.y = (scroll!.contentSize.height - 65)
    }

    func backBtnAction(sender:BNUIButton_Loging){
        delegate!.hidePrivacyPolicyView!()
    }
    
    func acceptBtnAction(sender:BNUIButton_Loging){
        delegate!.acceptPrivacyPolicy!()
    }
    
    func clean(){
        
    }
}

@objc protocol PrivacyPolicyView_Delegate:NSObjectProtocol {
    optional func hidePrivacyPolicyView()
    optional func acceptPrivacyPolicy()
    optional func showProgress(view:UIView)
}

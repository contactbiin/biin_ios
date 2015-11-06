//  MainViewController.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class MainViewController:UIViewController, MenuViewDelegate, MainViewDelegate, BNNetworkManagerDelegate, ProfileView_Delegate, BNAppManager_Delegate, BNPositionManagerDelegate, UIDocumentInteractionControllerDelegate {
    
    var mainView:MainView?
    var mainViewDelegate:MainViewDelegate?
    
    var menuView:MenuView?
    var showMenuSwipe:UIScreenEdgePanGestureRecognizer?
    
    var fadeView:UIView?
    
    var alert:BNUIAlertView?
    
    var uiDocumentInteractionController:UIDocumentInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.view.backgroundColor = UIColor.blackColor()
        //self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        self.becomeFirstResponder()
        
        BNAppSharedManager.instance.dataManager.startCommercialBiinMonitoring()
        
        BNAppSharedManager.instance.positionManager.delegateView = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViewController(frame:CGRect){
        
        BNAppSharedManager.instance.mainViewController = self

        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.delegate = self
        
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
        //BNAppSharedManager.instance.dataManager.checkAllShowcasesCompleted()
        
        mainView = MainView(frame: CGRectMake(0, 20, frame.width, frame.height), father:nil, rootViewController: self)
        mainView!.delegate = self
        mainView!.addUIViews()
        
        self.view.addSubview(self.mainView!)
        
        fadeView = UIView(frame: frame)
        fadeView!.backgroundColor = UIColor.blackColor()
        fadeView!.alpha = 0
        //fadeView!.userInteractionEnabled = false
        self.view.addSubview(fadeView!)
        
        var hideMenuSwipe = UISwipeGestureRecognizer(target: self, action: "hideMenu:")
        hideMenuSwipe.direction = UISwipeGestureRecognizerDirection.Left
        fadeView!.addGestureRecognizer(hideMenuSwipe)
        
        menuView = MenuView(frame: CGRectMake(-200, 20, 200, frame.height))
        menuView!.delegate = self
        self.view.addSubview(menuView!)
        
        hideMenuSwipe = UISwipeGestureRecognizer(target: self, action: "hideMenu:")
        hideMenuSwipe.direction = UISwipeGestureRecognizerDirection.Left
        menuView!.addGestureRecognizer(hideMenuSwipe)
        
        BNAppSharedManager.instance.IS_APP_READY_FOR_NEW_DATA_REQUEST = true
        
        //showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        //showMenuSwipe!.edges = UIRectEdge.Left
        //self.view.addGestureRecognizer(showMenuSwipe!)
        
        //var statusBarLine = UIView(frame: CGRectMake(0, 0, frame.width, 20))
        //statusBarLine.backgroundColor = UIColor.appMainColor()
        //self.view.addSubview(statusBarLine)
        
        if BNAppSharedManager.instance.notificationManager.currentNotification != nil && BNAppSharedManager.instance.notificationManager.didSendNotificationOnAppDown {
            mainView!.showNotificationContext()
        }
    }
    
    func refresh(){
        mainView!.refresh()
    }
    
    func showMenu(sender:UIScreenEdgePanGestureRecognizer) {
        if menuView!.isMenuHidden {

            fadeView!.becomeFirstResponder()

            UIView.animateWithDuration(0.5, animations: {() -> Void in
                self.menuView!.frame.origin.x = -40
                self.mainView!.frame.origin.x = 101
                self.fadeView!.frame.origin.x = 101
                }, completion: {(completed:Bool)->Void in
                self.menuView!.isMenuHidden = false
            })
            
//            
//            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
//                self.menuView!.frame.origin.x = -40
//                self.mainView!.frame.origin.x = 101
//                self.fadeView!.frame.origin.x = 101
//                }, completion: {(completed:Bool)->Void in
//                    
//                self.menuView!.isMenuHidden = false
//            })
            
            UIView.animateWithDuration(0.25, animations:{()-> Void in
                self.fadeView!.alpha = 0.5
            })
        }
    }
    
    func hideMenu(sender:UIGestureRecognizer) {
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.menuView!.frame.origin.x = -200
            self.mainView!.frame.origin.x = 0
            self.fadeView!.frame.origin.x = 0
            self.fadeView!.alpha = 0
            }, completion: {(completed:Bool)->Void in
                self.menuView!.isMenuHidden = true
        })
    }
    
    func showFade(){
        
        fadeView!.frame.origin.x = 0
        fadeView!.frame.origin.y = 0
        
        UIView.animateWithDuration(0.25, animations:{()-> Void in
            self.fadeView!.alpha = 0.5
        })
    }
    
    func hideFade(){
        UIView.animateWithDuration(0.25, animations:{()-> Void in
            self.fadeView!.alpha = 0
        })
    }
    
    func disableMenuButton(index:Int){
        menuView!.disableButton(index)
    }
    
    func hideMenuOnChange(){
        hideMenu(UIGestureRecognizer())
    }
    
    func tap(sender:UITapGestureRecognizer){

    }
    
    func setNextState(option:Int){

    }
    
    //MenuViewDelegate
    func menuView(menuView: MenuView!, showProfile value: Bool) {
        mainView!.setNextState(BNGoto.Profile)
    }
    
    func menuView(menuView: MenuView!, showHome value: Bool) {
        mainView!.setNextState(BNGoto.Main)
    }
    
    func menuView(menuView: MenuView!, showCollections value: Bool) {
        mainView!.setNextState(BNGoto.Collected)
    }
    
    func menuView(menuView: MenuView!, showLoyalty value: Bool) {
//        mainView!.setNextState(7)
    }
    
    func menuView(menuView: MenuView!, showNotifications value: Bool) {
//        mainView!.setNextState(6)
    }
    
    func menuView(menuView: MenuView!, showInviteFriends value: Bool) {
        sendInvitation()
    }
    
    func menuView(menuView: MenuView!, showSettings value: Bool) {
//        mainView!.setNextState(8)
    }
    
    func menuView(menuView: MenuView!, showSearch value: Bool) {
//        mainView!.setNextState(9)
    }
    
    func menuView(menuView: MenuView!, showAbout value: Bool) {
        mainView!.setNextState(BNGoto.About)
    }
    
    func showError(){

    }
    
    //MainViewDelegate
    func mainView(mainView: MainView!, hideMenu value: Bool) {
        self.hideMenu(UIGestureRecognizer())
    }
    
    func mainView(mainView: MainView!, hideMenuOnChange value: Bool, index:Int) {
        menuView!.disableButton(index)
        self.hideMenuOnChange()
    }
    
    func mainView(mainView: MainView!, showMenu value: Bool) {
        self.showMenu(UIScreenEdgePanGestureRecognizer())
    }
    
    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {

    }
    
    func manager(manager: BNNetworkManager!, didReceivedCategoriesSavedConfirmation response: BNResponse?) {
        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hide()
            }
        }
    }
    
    func manager(manager: BNNetworkManager!, didReceivedUpdateConfirmation response: BNResponse?) {
        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    BNAppSharedManager.instance.dataManager.requestDataForNewPosition()
                })
            }
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials, text:response!.responseDescription!)
                    self.view.addSubview(self.alert!)
                    self.alert!.showAndHide()
                })
            }
        }
    }
    
    //ProfileView_Delegate
    func showProgress(view: UIView) {
        if (alert?.isOn != nil) {
            alert!.hide()
        }
        
        showProgressView()
    }
    
    func showProgressView(){
        alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Please_wait, text:NSLocalizedString("PleaseWait", comment: "PleaseWait"))
        self.view.addSubview(alert!)
        alert!.show()
    }
    
    var fullPath = ""
    
    func shareSite(site:BNSite, shareView:ShareItView?){
        
//        var siteTitle = ""
//        if let site = BNAppSharedManager.instance.dataManager.sites[site.identifier!] {
//            siteTitle = site.title!
//        }
        
        //let view  = ShareItView(frame: CGRectMake(0, 0, 320, 450), site:site)
        let imageToShare:UIImage?
        imageToShare = imageFromView(shareView!)
        
        let subjectToShare:String?
        subjectToShare = NSLocalizedString("InviteSubject", comment: "InviteSubject")
        
        let textToShare:String?
        let string1 = NSLocalizedString("ShareBody1", comment: "ShareBody1")
        //let string2 = NSLocalizedString("ShareBody2", comment: "ShareBody2")
        let string3 = NSLocalizedString("ShareBody3", comment: "ShareBody3")
        
        textToShare = "\(string1)\(site.title!), \(site.city!). \(string3)"
        
        let myWebsite:NSURL?
        myWebsite = NSURL(string: "https:/www.biin.io")
        
        var sharingItems = [AnyObject]()

        if let image = imageToShare {
            sharingItems.append(image)
        }
        
        if let text = textToShare {
            sharingItems.append(text)
        }
        
        if let url = myWebsite {
            sharingItems.append(url)
        }
        
        let activityVC = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityVC.setValue(subjectToShare, forKey: "subject")
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func findSiteForElement(element:BNElement) -> BNSite? {
        return BNAppSharedManager.instance.dataManager.sites[element.showcase!.site!.identifier!]
    }
    
    func shareElement(element:BNElement, shareView:ShareItView?){
        
        var siteTitle = ""
        if let site = BNAppSharedManager.instance.dataManager.sites[element.showcase!.site!.identifier!] {
            siteTitle = "\(site.title!), \(site.city!)"
        }
        
//        let view  = ShareItView(frame: CGRectMake(0, 0, 320, 450), element: element, site:findSiteForElement(element))
        let imageToShare:UIImage?
        imageToShare = imageFromView(shareView!)
        
        let subjectToShare:String?
        subjectToShare = NSLocalizedString("InviteSubject", comment: "InviteSubject")
        
        let textToShare:String?
        let string1 = NSLocalizedString("ShareBody1", comment: "ShareBody1")
        let string2 = NSLocalizedString("ShareBody2", comment: "ShareBody2")
        let string3 = NSLocalizedString("ShareBody3", comment: "ShareBody3")
        
        textToShare = "\(string1)\(element.title!) \(string2)\(siteTitle). \(string3)"
        
        let myWebsite:NSURL?
        myWebsite = NSURL(string: "https:/www.biin.io")
        
        var sharingItems = [AnyObject]()
        
        if let image = imageToShare {
            sharingItems.append(image)
        }
        
        if let text = textToShare {
            sharingItems.append(text)
        }
        
        if let url = myWebsite {
            sharingItems.append(url)
        }
        
        let activityVC = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityVC.setValue(subjectToShare, forKey: "subject")
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]
        
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        let path = paths[0] ;
        fullPath = path.stringByAppendingPathComponent(name)

        return fullPath
    }
    
    func imageFromView(view:UIView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate()).jpg"
        let path = self.documentsPathForFileName(relativePath)
        imageData!.writeToFile(path, atomically: true)
        NSUserDefaults.standardUserDefaults().setObject(relativePath, forKey: "path")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return image
    }
    
    
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func sendInvitation(){
    
        let subjectToShare:String?
        subjectToShare = NSLocalizedString("InviteSubject", comment: "InviteSubject")
        
        let textToShare:String?
        textToShare = NSLocalizedString("InviteBody", comment: "InviteBody")
        
        let myWebsite:NSURL?
        myWebsite = NSURL(string: "https:/www.biinapp.com")
        
        var sharingItems = [AnyObject]()
        
        if let text = textToShare {
            sharingItems.append(text)
        }

        if let url = myWebsite {
            sharingItems.append(url)
        }
        
        let activityVC = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityVC.setValue(subjectToShare, forKey: "subject")

        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]


        self.presentViewController(activityVC, animated: true, completion: nil)
        mainView!.setNextState(BNGoto.Main)

    }
    
    func showInSiteView(site: BNSite?) {
        mainView!.showInSiteView(site)
    }
    
    func hideInSiteView() {
        mainView!.hideInSiteView()
    }
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
        
    }
    
    func clean(){
        
        self.mainView!.clean()
    }
    
    func show(){
        
        self.mainView!.show()
    }
}

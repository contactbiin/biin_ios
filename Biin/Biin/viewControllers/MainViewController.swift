//  MainViewController.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore
import FBSDKLoginKit

class MainViewController:UIViewController, MenuViewDelegate, MainViewDelegate, DevelopmentViewDelegate, BNNetworkManagerDelegate, ProfileView_Delegate, BNAppManager_Delegate, BNPositionManagerDelegate, UIDocumentInteractionControllerDelegate, FBSDKLoginButtonDelegate {
    
    var mainView:MainView?
    var mainViewDelegate:MainViewDelegate?
    
    var menuView:MenuView?
    var showMenuSwipe:UIScreenEdgePanGestureRecognizer?
    
    var fadeView:UIView?
    
    var alert:BNUIAlertView?
    
    var uiDocumentInteractionController:UIDocumentInteractionController?
    
    var developmentView:DevelopmentView?
    var showDevelopmentBtn:UIButton?
    var isShowing_developmentView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSLog("MainViewController - viewDidLoad()")
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.view.backgroundColor = UIColor.blackColor()
        self.view.layer.masksToBounds = true
        self.becomeFirstResponder()
        
        BNAppSharedManager.instance.dataManager.startCommercialBiinMonitoring()
        
        BNAppSharedManager.instance.positionManager.delegateView = self
        
        BNAppSharedManager.instance.positionManager!.startLocationService()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViewController(frame:CGRect){
        
        BNAppSharedManager.instance.IS_MAINVIEW_ON = true
        BNAppSharedManager.instance.mainViewController = self

        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.delegate = self
        
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
        mainView = MainView(frame: CGRectMake(0, 20, frame.width, frame.height), father:nil, rootViewController: self)
        mainView!.delegate = self
        mainView!.addUIViews()
        
        self.view.addSubview(self.mainView!)
        
        fadeView = UIView(frame: frame)
        fadeView!.backgroundColor = UIColor.blackColor()
        fadeView!.alpha = 0
        //fadeView!.userInteractionEnabled = false
        self.view.addSubview(fadeView!)
        
        var hideMenuSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.hideMenu(_:)))
        hideMenuSwipe.direction = UISwipeGestureRecognizerDirection.Left
        fadeView!.addGestureRecognizer(hideMenuSwipe)
        
        menuView = MenuView(frame: CGRectMake(-200, 20, 200, frame.height))
        menuView!.delegate = self
        self.view.addSubview(menuView!)
        
        hideMenuSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.hideMenu(_:)))
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
            
            if BNAppSharedManager.instance.isOpeningForLocalNotification {
                
                BNAppSharedManager.instance.isOpeningForLocalNotification = false
                mainView!.showNotificationContext()
            }
        }
        
        
        if BNAppSharedManager.instance.IS_DEVELOPMENT_BUILD {
            
            developmentView = DevelopmentView(frame:CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), viewController:self)
            self.view.addSubview(developmentView!)
            developmentView!.delegate = self
            
//            showDevelopmentBtn = UIButton(frame: CGRectMake((SharedUIManager.instance.screenWidth - 100), (SharedUIManager.instance.screenHeight - 45), 100, 45))
//            showDevelopmentBtn!.backgroundColor = UIColor.biinOrange()
//            showDevelopmentBtn!.addTarget(self, action: #selector(self.showDevelopmentView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//            showDevelopmentBtn!.setTitle("Show Dev", forState: UIControlState.Normal)
//            self.view!.addSubview(showDevelopmentBtn!)
        }
        
        if BNAppSharedManager.instance.dataManager.bnUser != nil {
            BNAppSharedManager.instance.networkManager.sendBiinieActions(BNAppSharedManager.instance.dataManager.bnUser!)
        }
    }
    
    func showDevelopmentView() {
        
        hideMenuOnChange()
        
        UIView.animateWithDuration(0.25, animations: {() -> Void in
            if !self.isShowing_developmentView {
                self.developmentView!.frame.origin.x = 0
                self.isShowing_developmentView = true
                //self.showDevelopmentBtn!.setTitle("Hide Dev", forState: UIControlState.Normal)
            } else {
                self.developmentView!.frame.origin.x = SharedUIManager.instance.screenWidth
                self.isShowing_developmentView = false
                //self.showDevelopmentBtn!.setTitle("Show Dev", forState: UIControlState.Normal)
            }
        })
    }
    
    func show_refreshButton(){
        mainView!.show_refreshButton()
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
    
    func menuView(menuView: MenuView!, showDevelopmentView value: Bool) {
        self.showDevelopmentView()
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
    func didReceivedAllInitialData() { }
    
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
                    BNAppSharedManager.instance.dataManager.requestInitialData()
                })
            }
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials )
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
    
    func hideProgressView(){
        if (alert?.isOn != nil) {
            alert!.hideWithCallback({() -> Void in
                self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.FacebookError )
                self.view.addSubview(self.alert!)
                self.alert!.showAndHide()
            })
        }
    }
        
    func showProgressView(){
        alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Please_wait )
        self.view.addSubview(alert!)
        alert!.show()
    }
    
    var fullPath = ""
    
    func shareSite(site:BNSite?, shareView:ShareItView?){
        
//        var siteTitle = ""
//        if let site = BNAppSharedManager.instance.dataManager.sites[site.identifier!] {
//            siteTitle = site.title!
//        }
        
        //let view  = ShareItView(frame: CGRectMake(0, 0, 320, 450), site:site)
        let imageToShare:UIImage?
        imageToShare = imageFromView(shareView!)
        
        let subjectToShare:String?
        subjectToShare = NSLocalizedString("InviteSubject", comment: "InviteSubject")
        
//        let textToShare:String?
//        let string1 = NSLocalizedString("ShareBody1", comment: "ShareBody1")
//        let string3 = NSLocalizedString("ShareBody3", comment: "ShareBody3")
//        textToShare = "\(string1)\(site!.title!), \(site!.city!). \(string3)"
//        
//        let myWebsite:NSURL?
//        myWebsite = NSURL(string: "https:/www.biin.io")
        
        var sharingItems = [AnyObject]()

        if let image = imageToShare {
            sharingItems.append(image)
        }
        
        //if let text = textToShare {
            //sharingItems.append(text)
        //}
        
        //if let url = myWebsite {
            //sharingItems.append(url)
        //}
        
        let activityVC = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityVC.setValue(subjectToShare, forKey: "subject")
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func findSiteForElement(element:BNElement) -> BNSite? {
        return BNAppSharedManager.instance.dataManager.sites[element.showcase!.site!.identifier!]
    }
    
    func shareElement(element:BNElement?, shareView:ShareItView?){
        
//        var siteTitle = ""
//        if let site = BNAppSharedManager.instance.dataManager.sites[element.showcase!.site!.identifier!] {
        //let siteTitle = "\(element!.showcase!.site!.title!), \(element!.showcase!.site!.city!)"
//        }
        
//        let view  = ShareItView(frame: CGRectMake(0, 0, 320, 450), element: element, site:findSiteForElement(element))
        let imageToShare:UIImage?
        imageToShare = imageFromView(shareView!)
        
        
        
        
        let subjectToShare:String?
        subjectToShare = NSLocalizedString("InviteSubject", comment: "InviteSubject")
        
        //let textToShare:String?
        //let string1 = NSLocalizedString("ShareBody1", comment: "ShareBody1")
        //let string2 = NSLocalizedString("ShareBody2", comment: "ShareBody2")
        //let string3 = NSLocalizedString("ShareBody3", comment: "ShareBody3")
        
        //textToShare = "\(string1)\(element!.title!) \(string2)\(siteTitle). \(string3)"
        
        //let myWebsite:NSURL?
        //myWebsite = NSURL(string: "https:/www.biin.io")
        
        var sharingItems = [AnyObject]()
        
        if let image = imageToShare {
            sharingItems.append(image)
        }
        
//        if let text = textToShare {
//            sharingItems.append(text)
//        }
//        
//        if let url = myWebsite {
//            sharingItems.append(url)
//        }
        
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
        myWebsite = NSURL(string: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=971157984&mt=8")
        
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
    
    func enableCollectionBtnOnMenu(){
        menuView!.collectionsBtn!.showEnable()
    }
    
    func shareWhatsapp(){
        
    }
    
    func developmentView(developmentView: DevelopmentView!, hideDevelopmentView value: Bool) {
        showDevelopmentView()
    }
    
    // Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if ((error) != nil) {
            // Process error
            self.hideProgressView()
        } else if result.isCancelled {
            // Handle cancellations
            self.hideProgressView()
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                self.showProgress(self.view)
                returnUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        //print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"id,first_name,last_name,gender,picture,email,birthday,friends"])
        
        //        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath:"me/friends", parameters: nil)
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                //print("fetched user: \(result)")
                if let first_name = result.valueForKey("first_name") {
                    BNAppSharedManager.instance.dataManager.bnUser!.firstName = first_name as? String
                }
                
                if let last_name = result.valueForKey("last_name") {
                    BNAppSharedManager.instance.dataManager.bnUser!.lastName = last_name as? String
                }
                
                if let userEmail = result.valueForKey("email") {
                    BNAppSharedManager.instance.dataManager.bnUser!.email = userEmail as? String
                    BNAppSharedManager.instance.dataManager.bnUser!.biinName = userEmail as? String 
                }
                
                if let birthday = result.valueForKey("birthday") {
                    let bd = NSDate(dateStringMMddyyyy: (birthday as! String))
                    BNAppSharedManager.instance.dataManager.bnUser!.birthDate = bd
                }
                
                if let gender = result.valueForKey("gender") {
                    BNAppSharedManager.instance.dataManager.bnUser!.gender = gender as? String
                }
                
                if let facebook_id = result.valueForKey("id") {
                    BNAppSharedManager.instance.dataManager.bnUser!.facebook_id = facebook_id as? String
                }
                
                if let friends = result["friends"] as? NSDictionary {
                    if let data = friends["data"] as? NSArray {
                        for friend in data {
                            if let facebook_id = friend.valueForKey("id") {
                                let biinie = Biinie()
                                biinie.facebook_id = facebook_id as? String
                                BNAppSharedManager.instance.dataManager.bnUser!.friends.append(biinie)
                            }
                        }
                    }
                }
                
                if let picture = result["picture"] as? NSDictionary {
                    if let data = picture["data"] as? NSDictionary {
                        
                        if let picture_url = data.valueForKey("url") as? String {
                            BNAppSharedManager.instance.dataManager.bnUser!.facebookAvatarUrl = picture_url
                        }
                    }
                }
                
                BNAppSharedManager.instance.dataManager.bnUser!.isEmailVerified = true
                BNAppSharedManager.instance.dataManager.bnUser!.save()
                BNAppSharedManager.instance.networkManager.sendBiinie(BNAppSharedManager.instance.dataManager.bnUser!)
                self.mainView!.updateProfileView()
            }
        })
    }
}

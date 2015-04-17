//  MainViewController.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class MainViewController:UIViewController, MenuViewDelegate, MainViewDelegate, BNNetworkManagerDelegate, ProfileView_Delegate, BNAppManager_Delegate, UIDocumentInteractionControllerDelegate {
    
    var mainView:MainView?
    var mainViewDelegate:MainViewDelegate?
    
    var menuView:MenuView?
    var showMenuSwipe:UIScreenEdgePanGestureRecognizer?
    
    var fadeView:UIView?
    
    var alert:BNUIAlertView?
    
    var uiDocumentInteractionController:UIDocumentInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("MainViewController - viewDidLoad()")
        
        BNAppSharedManager.instance.errorManager.currentViewController = self
        BNAppSharedManager.instance.mainViewController = self
        
        self.view.backgroundColor = UIColor.appMainColor()
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        self.becomeFirstResponder()
        
        BNAppSharedManager.instance.dataManager.setSitesBiinsCurrentState()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViewController(frame:CGRect){
    
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.delegate = self
        
        mainView = MainView(frame: frame, father:nil, rootViewController: self)
        mainView!.delegate = self
        self.view.addSubview(self.mainView!)
        
        fadeView = UIView(frame: frame)
        fadeView!.backgroundColor = UIColor.blackColor()
        fadeView!.alpha = 0
        //fadeView!.userInteractionEnabled = false
        self.view.addSubview(fadeView!)
        
        var hideMenuSwipe = UISwipeGestureRecognizer(target: self, action: "hideMenu:")
        hideMenuSwipe.direction = UISwipeGestureRecognizerDirection.Left
        fadeView!.addGestureRecognizer(hideMenuSwipe)
        
        menuView = MenuView(frame: CGRectMake(-140, 0, 140, frame.height))
        menuView!.delegate = self
        self.view.addSubview(menuView!)
        
        hideMenuSwipe = UISwipeGestureRecognizer(target: self, action: "hideMenu:")
        hideMenuSwipe.direction = UISwipeGestureRecognizerDirection.Left
        menuView!.addGestureRecognizer(hideMenuSwipe)
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe!.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(showMenuSwipe!)

    }
    
    func showMenu(sender:UIScreenEdgePanGestureRecognizer) {
        if menuView!.isMenuHidden {
            showMenuSwipe!.enabled = false
            fadeView!.becomeFirstResponder()


            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
                self.menuView!.frame.origin.x = -40
                self.mainView!.frame.origin.x = 101
                self.fadeView!.frame.origin.x = 101
                }, completion: {(completed:Bool)->Void in
                    
                self.menuView!.isMenuHidden = false
            })
            
            
            
            UIView.animateWithDuration(0.25, animations:{()-> Void in
                self.fadeView!.alpha = 0.5
            })
        }
    }
    
    func hideMenu(sender:UIGestureRecognizer) {
        
        showMenuSwipe!.enabled = true
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.menuView!.frame.origin.x = -140
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
        showMenuSwipe!.enabled = true
        hideMenu(UIGestureRecognizer())
        
        /*
        UIView.animateWithDuration(0.25, animations: {() -> Void in
            self.menuView!.frame.origin.x = -140
            self.mainView!.frame.origin.x = 0
//            self.fadeView!.frame.origin.x = 320
            self.fadeView!.alpha = 0
            }, completion: {(completed:Bool) -> Void in
                self.menuView!.isHidden = true
                self.fadeView!.frame.origin.x = 0
        })
        */
    }
    
    func tap(sender:UITapGestureRecognizer){

    }
    
    func setNextState(option:Int){

    }
    
    //MenuViewDelegate
    func menuView(menuView: MenuView!, showProfile value: Bool) {
        mainView!.setNextState(3)
    }
    
    func menuView(menuView: MenuView!, showHome value: Bool) {
        mainView!.setNextState(0)
    }
    
    func menuView(menuView: MenuView!, showCollections value: Bool) {
        mainView!.setNextState(4)
    }
    
    func menuView(menuView: MenuView!, showLoyalty value: Bool) {
        mainView!.setNextState(5)
    }
    
    func menuView(menuView: MenuView!, showNotifications value: Bool) {
        mainView!.setNextState(6)
    }
    
    func menuView(menuView: MenuView!, showInviteFriends value: Bool) {
        mainView!.setNextState(7)
    }
    
    func menuView(menuView: MenuView!, showSettings value: Bool) {
        mainView!.setNextState(8)
    }
    
    func menuView(menuView: MenuView!, showSearch value: Bool) {
        mainView!.setNextState(9)
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
                alert!.hideWithCallback({() -> Void in
                    //var vc = LoadingViewController()
                    //vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                    //self.presentViewController(vc, animated: true, completion: nil)
                })
            }
            
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials, text:response!.responseDescription!)
                    self.view.addSubview(self.alert!)
                    self.alert!.show()
                })
            }
        }
        
    }
    
    func manager(manager: BNNetworkManager!, didReceivedUpdateConfirmation response: BNResponse?) {
        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Saved, text:"Changes saved!")
                    self.view.addSubview(self.alert!)
                    self.alert!.show()
                })
            }

            
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials, text:response!.responseDescription!)
                    self.view.addSubview(self.alert!)
                    self.alert!.show()
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
        alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Please_wait, text:"Please wait a moment!")
        self.view.addSubview(alert!)
        alert!.show()
    }
    
    //BNAppManager_Delegate Methods
    func manager(showNotifications value: Bool) {
        mainView!.showNotification()
    }
    
    func manager(hideNotifications value: Bool) {
        mainView!.hideNotification()
    }
    
    var fullPath = ""
    
    func shareSite(site:BNSite){
        var view  = ShareItView(frame: CGRectMake(0, 0, 320, 450), site:site )
        
        var image = imageFromView(view)
        //var url = NSBundle.mainBundle().URLForResource("shareIt", withExtension: "jpg")
        var url = NSURL(fileURLWithPath: fullPath)
        
        if url != nil {
            uiDocumentInteractionController = UIDocumentInteractionController(URL: url!)
            uiDocumentInteractionController!.delegate = self
            uiDocumentInteractionController!.presentPreviewAnimated(false)
        }
        
    }
    
    func findSiteForElement(element:BNElement) -> BNSite? {
        for (identifier, site) in BNAppSharedManager.instance.dataManager.sites {
            for biin in site.biins {
                for showcase in biin.showcases! {
                    for elementSC in showcase.elements {
                        if element.identifier! == elementSC.identifier! {
                            return site
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func shareElement(element:BNElement){
        
        var view  = ShareItView(frame: CGRectMake(0, 0, 320, 450), element: element, site:findSiteForElement(element))
        
        var image = imageFromView(view)
        //var url = NSBundle.mainBundle().URLForResource("shareIt", withExtension: "jpg")
        var url = NSURL(fileURLWithPath: fullPath)
        
        if url != nil {
            uiDocumentInteractionController = UIDocumentInteractionController(URL: url!)
            uiDocumentInteractionController!.delegate = self
            uiDocumentInteractionController!.presentPreviewAnimated(false)
        }
    }
    
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        let path = paths[0] as! String;
        fullPath = path.stringByAppendingPathComponent(name)
        println("\(fullPath)")
        return fullPath
    }
    
    /*
    
    #import <QuartzCore/QuartzCore.h>
    
    + (UIImage *) imageWithView:(UIView *)view
    {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    }
*/
    func imageFromView(view:UIView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(image), forKey: "shareIt")
        
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate()).jpg"
        let path = self.documentsPathForFileName(relativePath)
        imageData.writeToFile(path, atomically: true)
        NSUserDefaults.standardUserDefaults().setObject(relativePath, forKey: "path")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return image
    }
    
    
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

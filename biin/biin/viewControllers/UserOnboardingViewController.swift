//  UserOnboardingViewController.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class UserOnboardingViewController:UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate, UserOnboardingView_Categories_Delegate {
    
    var categoriesView:UserOnboardingView_Categories?
    var fadeView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("SingupViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        self.becomeFirstResponder()
        
        categoriesView = UserOnboardingView_Categories(frame:self.view.frame)
        categoriesView!.delegate = self
        self.view.addSubview(categoriesView!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViewController(frame:CGRect){
        
        //        mainView = MainView(frame: frame, father:nil, rootViewController: self)
        //        mainView!.delegate = self
        //        self.view.addSubview(self.mainView!)
        //
        //        fadeView = UIView(frame: frame)
        //        fadeView!.backgroundColor = UIColor.blackColor()
        //        fadeView!.alpha = 0
        //        fadeView!.userInteractionEnabled = false
        //        self.view.addSubview(fadeView!)
        //
        //        menuView = MenuView(frame: CGRectMake(-140, 0, 140, frame.height))
        //        menuView!.delegate = self
        //        self.view.addSubview(menuView!)
        //
        //        var hideMenuSwipe = UISwipeGestureRecognizer(target: self, action: "hideMenu:")
        //        hideMenuSwipe.direction = UISwipeGestureRecognizerDirection.Left
        //        menuView!.addGestureRecognizer(hideMenuSwipe)
        //
        //        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        //        showMenuSwipe!.edges = UIRectEdge.Bottom
        //        self.view.addGestureRecognizer(showMenuSwipe!)
        
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }
    
    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {

    }
    
    func showProgress(view: UIView) {
        
    }
    
    func showSelectCategories(view: UIView) {
        
    }
    
    func startOnBiin(view: UIView) {
        var vc = MainViewController()
        vc.initViewController(self.view.frame)
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }

}
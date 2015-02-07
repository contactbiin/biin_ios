//  UserOnboardingViewController.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class UserOnboardingViewController:UIViewController, UIPopoverPresentationControllerDelegate {
    
    var fadeView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("SingupViewController - viewDidLoad()")
        
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        self.becomeFirstResponder()
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
    
    func enterBtnAction(sender: UIButton!){
        
        var vc = MainViewController()
        vc.initViewController(self.view.frame)
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }
}
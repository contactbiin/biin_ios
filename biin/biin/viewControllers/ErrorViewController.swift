//  ErrorViewController.swift
//  biin
//  Created by Esteban Padilla on 7/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ErrorViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {
    
    var internetErrorView:InternetErrorView?
    var bluetoothErrorView:BluetoothErrorView?
    var hardwareErrorView:HardwareErrorView?
    var locationErrorView:LocationErrorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ErrorViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        //BNAppSharedManager.instance.errorManager.currentViewController = self
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        


    }
    
    func addInternet_ErrorView(){
        //var screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        internetErrorView = InternetErrorView(frame: CGRectMake(0, 20, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        internetErrorView!.errorViewController = self
        self.view.addSubview(internetErrorView!)
    }
    
    func addBluetooth_ErrorView(){
       // var screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        bluetoothErrorView = BluetoothErrorView(frame: CGRectMake(0, 20, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        bluetoothErrorView!.errorViewController = self
        self.view.addSubview(bluetoothErrorView!)
    }
    
    func addHardware_ErrorView(){
        //var screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        hardwareErrorView = HardwareErrorView(frame: CGRectMake(0, 20, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        hardwareErrorView!.errorViewController = self
        self.view.addSubview(hardwareErrorView!)
    }
    
    func addLocation_ErrorView(){
        //var screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        locationErrorView = LocationErrorView(frame: CGRectMake(0, 20, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        locationErrorView!.errorViewController = self
        self.view.addSubview(locationErrorView!)
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
        
    }
}

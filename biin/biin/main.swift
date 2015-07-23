//
//  main.swift
//  biin
//
//  Created by Esteban Padilla on 7/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(AppDelegate))

//let objects = NSBundle.mainBundle().loadNibNamed("LaunchScreen", owner: nil, options: nil)
//var view = objects[0] as? UIView
//view!.backgroundColor = UIColor.greenColor()
//view!.setNeedsDisplay()





func isRunningTests() -> Bool {
    
 

//    let environment = NSProcessInfo.processInfo().environment
//    if let injectBundle = environment["XCInjectBundle"] as? NSString {
//        return injectBundle.pathExtension == "xctest"
//    }
    return false
}


class UnitTestsAppDelegate: UIResponder, UIApplicationDelegate
{
    
}

if isRunningTests() {
//    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(UnitTestsAppDelegate))
}else{
    //UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(AppDelegate))
}
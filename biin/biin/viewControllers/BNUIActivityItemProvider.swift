//  BNUIActivityItemProvider.swift
//  biin
//  Created by Esteban Padilla on 4/21/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIActivityItemProvider: UIActivityItemProvider {

    override init(placeholderItem: AnyObject) {
        super.init(placeholderItem: placeholderItem)
    }
    
    override func activityViewController(activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject?  {
        return nil
    }
    
}
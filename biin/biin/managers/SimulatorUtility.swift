//  SimulatorUtility.swift
//  biin
//  Created by Esteban Padilla on 6/19/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class SimulatorUtility {
    class var isRunningSimulator: Bool {
        get { return TARGET_IPHONE_SIMULATOR != 0 }
    }
}

//  ErrorState.swift
//  biin
//  Created by Esteban Padilla on 7/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ErrorState: BNState {

    override init(context: BNView, view: BNView?) {
        super.init(context: context, view: view)
        self.stateType = BNStateType.ErrorState
    }

    override func action() {
        view!.transitionIn()
    }

    override func next(state: BNState?) {
        context!.state = state
        view!.transitionOut(context!.state)
    }
}


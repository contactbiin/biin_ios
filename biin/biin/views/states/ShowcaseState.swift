//  ShowcaseState.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class ShowcaseState:BNState {

    override init(context:BNView, view:BNView?){
        super.init(context:context, view: view)
        //self.stateType = BNStateType.ShowcaseState
    }
    
    override init(context: BNView, view: BNView, stateType: BNStateType) {
        super.init(context: context, view: view, stateType: stateType)
    }
    
    override func action() {
        view!.transitionIn()
    }
    
    override func next( state:BNState? ) {

        context!.state = state
        view!.transitionOut( context!.state )
    }
}
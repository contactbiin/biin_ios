//  BrotherSiteState.swift
//  biin
//  Created by Esteban Padilla on 5/16/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BrotherSiteState:BNState {
    
    override init(context:BNView, view:BNView?){
        super.init(context:context, view: view)
        self.stateType = BNStateType.BrotherSiteState
    }
    
    override func action() {
        view!.transitionIn()
    }
    
    override func next( state:BNState? ) {
        context!.state = state
        view!.transitionOut( context!.state )
    }
    
    override func gotoPrevious() {
        context!.state = previous
    }
}

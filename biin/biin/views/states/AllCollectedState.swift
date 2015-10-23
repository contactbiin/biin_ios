//  AllCollectedState.swift
//  biin
//  Created by Esteban Padilla on 10/8/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.


import Foundation
import UIKit

class AllCollectedState:BNState {
    
    override init(context:BNView, view:BNView?){
        super.init(context:context, view: view)
        self.stateType = BNStateType.AllCollectedState
    }
    
    override init(context: BNView, view: BNView, stateType: BNStateType) {
        super.init(context: context, view: view, stateType: stateType)
    }
    
    override func action() {
        view!.transitionIn()
    }
    
    override func next( state:BNState? ) {
        print("goto state: \(state)")
        context!.state = state
        view!.transitionOut( context!.state )
    }
}



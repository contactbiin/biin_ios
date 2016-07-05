//  GiftsState.swift
//  Biin
//  Created by Esteban Padilla on 7/4/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.


import Foundation
import UIKit

class GiftsState:BNState {
    
    override init(context:BNView, view:BNView?){
        super.init(context:context, view: view)
        self.stateType = BNStateType.GiftsState
    }
    
    override func action() {
        view!.transitionIn()
    }
    
    override func next( state:BNState? ) {
        context!.state = state
        view!.transitionOut( context!.state )
    }
}

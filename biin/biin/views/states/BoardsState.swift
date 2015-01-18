//  BoardsState.swift
//  Biin
//  Created by Esteban Padilla on 1/7/15.
//  Copyright (c) 2015 Biin. All rights reserved.

import Foundation
import UIKit

class BoardsState:BNState {
    
    override init(context:BNView, view:BNView){
        super.init(context:context, view: view)
        self.stateType = BNStateType.BoardsState
    }
    
    override init(context: BNView, view: BNView, stateType: BNStateType) {
        super.init(context: context, view: view, stateType: stateType)
    }
    
    override func action() {
        view!.transitionIn()
    }
    
    override func next( state:BNState? ) {
        println("goto state: \(state)")
        context!.state = state
        view!.transitionOut( context!.state )
    }
}
//  SearchState.swift
//  Biin
//  Created by Esteban Padilla on 12/16/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class SearchState:BNState {
    
    override init(context:BNView, view:BNView?){
        super.init(context:context, view: view)
        self.stateType = BNStateType.SearchState
    }
    
    override func action() {
        view!.transitionIn()
    }
    
    override func next( state:BNState? ) {

        context!.state = state
        view!.transitionOut( context!.state )
    }
}
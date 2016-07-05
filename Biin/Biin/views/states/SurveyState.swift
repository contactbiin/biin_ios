//  SurveyState.swift
//  biin
//  Created by Esteban Padilla on 1/14/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SurveyState:BNState {
    
    override init(context:BNView, view:BNView?){
        super.init(context:context, view: view)
        self.stateType = BNStateType.SurveyState
    }
    
    override func action() {
        view!.transitionIn()
    }
    
    override func next( state:BNState? ) {
        context!.state = state
        view!.transitionOut( context!.state )
    }
}

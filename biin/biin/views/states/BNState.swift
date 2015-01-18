//  BNState.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNState {

    var context:BNView?
    var view:BNView?
    var stateType:BNStateType?
    
    init(context:BNView, view:BNView){
        self.context = context
        self.view = view
    }
    
    init(context:BNView, view:BNView, stateType:BNStateType){
        self.context = context
        self.view = view
        self.stateType = stateType
    }
    
    func action() {
//        view!.transitionIn()
    }
    
    func next( state:BNState? ) {
//        context!.state = state
//        view!.transitionOut( context!.state )
    }
}

enum BNStateType {
    case BiinieCategoriesState
    case SectionState
    case ShowcaseState
    case SearchState
    case SettingsState
    case CollectionState
    case ProfileState
    case BoardsState
}
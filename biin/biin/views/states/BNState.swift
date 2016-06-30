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
    var previous:BNState?
    
    init(context:BNView, view:BNView?){
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
    
    func gotoPrevious() { }
}

enum BNStateType {
    case MainViewContainerState
    case BiinieCategoriesState
    case SiteState
    case BrotherSiteState
    case AllSitesState
    case AllFavoriteSites
    case ElementState
    case ElementFromSiteState
    case AllElementsState
    case ProfileState
    case CollectionState
    case Notifications
    case SearchState
    case SettingsState
    case BoardsState
    case LoyaltiesState
    case AboutState
    case ErrorState
    case AllCollectedState
    case SurveyState
}
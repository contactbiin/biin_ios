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
    
    func action() {

    }
    
    func next( state:BNState? ) {

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
    case AboutState
    case ErrorState
    case AllCollectedState
    case SurveyState
    case GiftsState
    case LoyaltyWallet
    case LoyaltyCardState
    case LoyaltyCardCompletedState
    case AlertState
    case QRCodeState
    case FriendsState
}
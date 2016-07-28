//  LoyaltyMiniView.swift
//  biin
//  Created by Esteban Padilla on 7/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoyaltiesMiniView: BNView {
    
    var organizationAvatarView:UIView?
    var organizationAvatar:BNUIImageView?
    
    var title:UILabel?
    var subtitle:UILabel?
    
    weak var organization:BNOrganization?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame)
        self.father = father
    }
    
    convenience init(frame: CGRect, father: BNView?, organization:BNOrganization?) {
        self.init(frame:frame, father:father)
        //self.site = site
        self.organization = organization
        
        self.backgroundColor = UIColor.appMainColor()
        self.layer.borderColor = UIColor.appMainColor().CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        let screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        var xpos:CGFloat = 10
        var ypos:CGFloat = 10
        let avatarWidth:CGFloat = (frame.height - 20)
        
        
        organizationAvatarView = UIView(frame: CGRectMake(xpos, ypos, avatarWidth, avatarWidth))
        organizationAvatarView!.layer.cornerRadius = 25
        organizationAvatarView!.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        organizationAvatarView!.layer.borderWidth = 5
        organizationAvatarView!.layer.masksToBounds = true
        self.addSubview(organizationAvatarView!)
        
        organizationAvatar = BNUIImageView(frame: CGRectMake(1, 1, (avatarWidth - 2), (avatarWidth - 2)), color:organization!.media[0].vibrantColor!)
        organizationAvatarView!.addSubview(organizationAvatar!)
        
        BNAppSharedManager.instance.networkManager.requestImageData(organization!.media[0].url!, image: organizationAvatar)
        
        xpos += (avatarWidth + 5)
        ypos = 20
        title = UILabel(frame: CGRectMake(xpos, ypos, (screenWidth - 110), 20))
        title!.text = self.organization!.brand!
        title!.textColor = UIColor.appTextColor()
        title!.font = UIFont(name: "Lato-Black", size: 18)
        title!.textAlignment = NSTextAlignment.Left
        self.addSubview(title!)
        
        ypos += title!.frame.height
//        subtitle = UILabel(frame: CGRectMake(70, ypos, (screenWidth - 90), 12))
//        subtitle!.font = UIFont(name: "Lato-Light", size: 10)
//        subtitle!.text = self.organization!.subTitle!
//        subtitle!.textColor = UIColor.appTextColor()
//        subtitle!.numberOfLines = 0
//        self.addSubview(subtitle!)
//        
//        

   
    }
   
}

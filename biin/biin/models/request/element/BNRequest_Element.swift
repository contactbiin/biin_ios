//  BNRequest_Element.swift
//  biin
//  Created by Alison Padilla on 9/1/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNRequest_Element: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, dataIdentifier:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, element:BNElement){
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.Element
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.element = element
    }
    
    override func run() {
        
        //self.start = NSDate()
        
        isRunning = true
        requestAttemps += 1
        //var response:BNResponse?
        
        networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                
                self.networkManager!.handleFailedRequest(self, error: error )
                
                //response = BNResponse(code:10, type: BNResponse_Type.Suck)

                
            } else {

                if let elementData = data["data"] as? NSDictionary {
                    
                    //var status = self.networkManager!.findInt("status", dictionary: data)
                    //var result = self.networkManager!.findBool("result", dictionary: data)
                    //var status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        self.element!.isDownloadCompleted = true
                        self.element!.identifier = BNParser.findString("identifier", dictionary: elementData)
                        self.element!.position = BNParser.findInt("position", dictionary: elementData)
                        self.element!.title = BNParser.findString("title", dictionary: elementData)
                        self.element!.subTitle = BNParser.findString("subTitle", dictionary: elementData)
                        self.element!.nutshellDescriptionTitle = BNParser.findString("nutshellDescriptionTitle", dictionary: elementData)
                        self.element!.nutshellDescription = BNParser.findString("nutshellDescription", dictionary: elementData)
                        self.element!.currency = BNParser.findCurrency("currencyType", dictionary: elementData)
                        self.element!.stars = BNParser.findFloat("stars", dictionary: elementData)!
                        self.element!.detailsHtml = BNParser.findString("detailsHtml", dictionary: elementData)

                        self.element!.hasCallToAction = BNParser.findBool("hasCallToAction", dictionary: elementData)
                        if self.element!.hasCallToAction {
                            self.element!.callToActionURL = BNParser.findString("callToActionURL", dictionary: elementData)
                            self.element!.callToActionTitle = BNParser.findString("callToActionTitle", dictionary: elementData)
                        }

                        self.element!.isTaxIncludedInPrice = BNParser.findBool("isTaxIncludedInPrice", dictionary: elementData)
                        
                        self.element!.hasFromPrice = BNParser.findBool("hasFromPrice", dictionary: elementData)

                        if self.element!.hasFromPrice {
                            self.element!.fromPrice = BNParser.findString("fromPrice", dictionary: elementData)
                        }
                        
                        self.element!.hasListPrice = BNParser.findBool("hasListPrice", dictionary: elementData)
                        if self.element!.hasListPrice {
                            self.element!.listPrice = BNParser.findString("listPrice", dictionary: elementData)
                        }
                        
                        self.element!.hasDiscount = BNParser.findBool("hasDiscount", dictionary: elementData)
                        if self.element!.hasDiscount {
                            self.element!.discount = BNParser.findString("discount", dictionary: elementData)
                        }
                        
                        self.element!.hasPrice = BNParser.findBool("hasPrice", dictionary: elementData)
                        if self.element!.hasPrice {
                            self.element!.price = BNParser.findString("price", dictionary: elementData)
                        }
                        
                        self.element!.hasSaving = BNParser.findBool("hasSaving", dictionary: elementData)
                        if self.element!.hasSaving {
                            self.element!.savings = BNParser.findString("savings", dictionary: elementData)
                        }
                        
                        self.element!.hasTimming = BNParser.findBool("hasTimming", dictionary: elementData)
                        if self.element!.hasTimming {
                            self.element!.initialDate = BNParser.findNSDate("initialDate", dictionary: elementData)
                            self.element!.expirationDate = BNParser.findNSDate("expirationDate", dictionary: elementData)
                        }
                        
                        self.element!.hasQuantity = BNParser.findBool("hasQuantity", dictionary: elementData)
                        if self.element!.hasQuantity {
                            self.element!.quantity = BNParser.findString("quantity", dictionary: elementData)
                            self.element!.reservedQuantity = BNParser.findString("reservedQuantity", dictionary: elementData)
                            self.element!.claimedQuantity = BNParser.findString("claimedQuantity", dictionary: elementData)
                            self.element!.actualQuantity = BNParser.findString("actualQuantity", dictionary: elementData)
                        }
                        
                        self.element!.isHighlight = BNParser.findBool("isHighlight", dictionary: elementData)
                        
                        //let details = BNParser.findNSArray("details", dictionary: elementData)
                        /*
                        for var i = 0; i < details?.count; i++ {
                            let detailData = details!.objectAtIndex(i) as! NSDictionary
                            
                            let detail = BNElementDetail()
                            detail.text = BNParser.findString("text", dictionary: detailData)!
                            detail.elementDetailType = BNParser.findBNElementDetailType("elementDetailType", dictionary: detailData)
                            
                            if (detail.elementDetailType! == BNElementDetailType.ListItem){
                                
                                let body = BNParser.findNSArray("body", dictionary: detailData)
                                detail.body = Array<String>()
                                
                                for (var i = 0; i < body?.count; i++) {
                                    let line = body!.objectAtIndex(i) as! NSDictionary
                                    detail.body!.append( BNParser.findString("line", dictionary:line)! )
                                }
                                
                            }
                            
                            if (detail.elementDetailType! == BNElementDetailType.PriceList){
                                
                                let body = BNParser.findNSArray("body", dictionary: detailData)
                                detail.priceList = Array<BNElementDetail_PriceLlist>()
                                
                                for (var i = 0; i < body?.count; i++) {
                                    let line = body!.objectAtIndex(i) as! NSDictionary
                                    var priceListItem = BNElementDetail_PriceLlist()
                                    priceListItem.currency = BNParser.findCurrency("currencyType", dictionary: line)
                                    priceListItem.description = BNParser.findString("description", dictionary: line)
                                    priceListItem.price = BNParser.findString("line", dictionary: line)
                                    detail.priceList!.append(priceListItem)
                                }
                                
                            }
                            
                            
                            self.element!.details.append(detail)
                        }
                        */
                        let mediaArray = BNParser.findNSArray("media", dictionary: elementData)
                        
                        var i:Int = 0
                        for _ in mediaArray! {
//                        for i in (0..<mediaArray?.count) {
//                        for var j = 0; j < mediaArray?.count; j++ {
                            let mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                            let url = BNParser.findString("url", dictionary: mediaData)!
                            let type = BNParser.findMediaType("mediaType", dictionary: mediaData)
                            let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)!
                            let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)!
                            let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)!
                            
                            var white:CGFloat = 0.0
                            var alpha:CGFloat = 0.0
                            _ = vibrantColor.getWhite(&white, alpha: &alpha)
                            
                            if white <= 0.7 {
                                self.element!.useWhiteText = true

                            }


                            
                            let media = BNMedia(mediaType: type, url:url, vibrantColor: vibrantColor, vibrantDarkColor: vibrantDarkColor, vibrantLightColor:vibrantLightColor)
                            self.element!.media.append(media)
                            i += 1
                        }
                        
                        let categories = BNParser.findNSArray("categories", dictionary: elementData)
                        
                        i = 0
                        for _ in categories! {
//                        for var j = 0; j < categories?.count; j++ {
                            let categoryData = categories!.objectAtIndex(i) as! NSDictionary
                            _ = BNParser.findString("identifier", dictionary: categoryData)!
                            //BNAppSharedManager.instance.dataManager.addElementToCategory(identifier, element: self.element!)
                        }

                        self.element!.commentedCount = BNParser.findInt("commentedCount", dictionary: elementData)!
                        self.element!.collectCount = BNParser.findInt("collectCount", dictionary: elementData)!
                        self.element!.userCollected = BNParser.findBool("userCollected", dictionary: elementData)
                        self.element!.userLiked = BNParser.findBool("userLiked", dictionary: elementData)
                        self.element!.userShared = BNParser.findBool("userShared", dictionary: elementData)
                        self.element!.userCommented = BNParser.findBool("userCommented", dictionary: elementData)
                        self.element!.userViewed = BNParser.findBool("userViewed", dictionary: elementData)
                        
                        //let hasSticker = BNParser.findBool("hasSticker", dictionary: elementData)
                        /*
                        if (hasSticker) {
                            if let stickerData = elementData["sticker"] as? NSDictionary {
                                self.element!.hasSticker = hasSticker
                                let stickerColor = BNParser.findUIColor("color", dictionary: stickerData)
                                let stickerType = BNParser.findBNStickerType("type", dictionary: stickerData)
                                let sticker = BNSticker(type:stickerType, color:stickerColor!)
                                self.element!.sticker = sticker
                            }
                        }
                        */
//                        if self.element!.isHighlight {
//                            self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedHightlight:self.element!)
//                        } else {
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedElement:self.element!)
//                        }
                    }
                }
                
                /*
                let end = NSDate()
                let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                print("BNRequest_Element [\(timeInterval)] - \(self.requestString)")
                */
                
                self.inCompleted = true
                //self.clean()
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}
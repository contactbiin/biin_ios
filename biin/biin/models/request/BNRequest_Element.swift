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
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.ElementData
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.element = element
    }
    
    override func run() {
        
        println("BNRequest_Element.run()")
        isRunning = true
        var response:BNResponse?
        
        networkManager!.epsNetwork!.getJson(true, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on element data")
                //self.handleFailedRequest(request, error: error )
                
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
                println("*** element data SUCK - FAILED!")
                
            } else {
                
                if let elementData = data["data"] as? NSDictionary {
                    
                    var status = self.networkManager!.findInt("status", dictionary: data)
                    var result = self.networkManager!.findBool("result", dictionary: data)
                    
                    if result {
                        self.element!.isDownloadCompleted = true
                        self.element!.identifier = self.networkManager!.findString("identifier", dictionary: elementData)
                        //println("Processing: \(element.identifier!)")
                        self.element!.elementType = self.networkManager!.findBNElementType("elementType", dictionary: elementData)
                        self.element!.position = self.networkManager!.findInt("position", dictionary: elementData)
                        self.element!.title = self.networkManager!.findString("title", dictionary: elementData)
                        self.element!.subTitle = self.networkManager!.findString("subTitle", dictionary: elementData)
                        self.element!.nutshellDescriptionTitle = self.networkManager!.findString("nutshellDescriptionTitle", dictionary: elementData)
                        self.element!.nutshellDescription = self.networkManager!.findString("nutshellDescription", dictionary: elementData)
                        self.element!.titleColor = self.networkManager!.findUIColor("titleColor", dictionary: elementData)!
                        self.element!.currency = self.networkManager!.findCurrency("currencyType", dictionary: elementData)
                        self.element!.color = UIColor.elementColor()
                        //element.socialButtonsColor = self.findUIColor("socialButtonsColor", dictionary: elementData)!
                        
                        self.element!.hasFromPrice = self.networkManager!.findBool("hasFromPrice", dictionary: elementData)
                        if self.element!.hasFromPrice {
                            self.element!.fromPrice = self.networkManager!.findString("fromPrice", dictionary: elementData)
                        }
                        
                        self.element!.hasListPrice = self.networkManager!.findBool("hasListPrice", dictionary: elementData)
                        if self.element!.hasListPrice {
                            self.element!.listPrice = self.networkManager!.findString("listPrice", dictionary: elementData)
                        }
                        
                        self.element!.hasDiscount = self.networkManager!.findBool("hasDiscount", dictionary: elementData)
                        if self.element!.hasDiscount {
                            self.element!.discount = self.networkManager!.findString("discount", dictionary: elementData)
                        }
                        
                        self.element!.hasPrice = self.networkManager!.findBool("hasPrice", dictionary: elementData)
                        if self.element!.hasPrice {
                            self.element!.price = self.networkManager!.findString("price", dictionary: elementData)
                        }
                        
                        self.element!.hasSaving = self.networkManager!.findBool("hasSaving", dictionary: elementData)
                        if self.element!.hasSaving {
                            self.element!.savings = self.networkManager!.findString("savings", dictionary: elementData)
                        }
                        
                        self.element!.hasTimming = self.networkManager!.findBool("hasTimming", dictionary: elementData)
                        if self.element!.hasTimming {
                            self.element!.initialDate = self.networkManager!.findNSDate("initialDate", dictionary: elementData)
                            self.element!.expirationDate = self.networkManager!.findNSDate("expirationDate", dictionary: elementData)
                        }
                        
                        self.element!.hasQuantity = self.networkManager!.findBool("hasQuantity", dictionary: elementData)
                        if self.element!.hasQuantity {
                            self.element!.quantity = self.networkManager!.findString("quantity", dictionary: elementData)
                            self.element!.reservedQuantity = self.networkManager!.findString("reservedQuantity", dictionary: elementData)
                            self.element!.claimedQuantity = self.networkManager!.findString("claimedQuantity", dictionary: elementData)
                            self.element!.actualQuantity = self.networkManager!.findString("actualQuantity", dictionary: elementData)
                        }
                        
                        self.element!.isHighlight = self.networkManager!.findBool("isHighlight", dictionary: elementData)
                        
                        var details = self.networkManager!.findNSArray("details", dictionary: elementData)
                        
                        for var i = 0; i < details?.count; i++ {
                            var detailData = details!.objectAtIndex(i) as! NSDictionary
                            
                            var detail = BNElementDetail()
                            detail.text = self.networkManager!.findString("text", dictionary: detailData)!
                            detail.elementDetailType = self.networkManager!.findBNElementDetailType("elementDetailType", dictionary: detailData)
                            
                            if (detail.elementDetailType! == BNElementDetailType.ListItem){
                                
                                var body = self.networkManager!.findNSArray("body", dictionary: detailData)
                                detail.body = Array<String>()
                                
                                for (var i = 0; i < body?.count; i++) {
                                    var line = body!.objectAtIndex(i) as! NSDictionary
                                    detail.body!.append( self.networkManager!.findString("line", dictionary:line)! )
                                }
                                
                            }
                            
                            if (detail.elementDetailType! == BNElementDetailType.PriceList){
                                
                                var body = self.networkManager!.findNSArray("body", dictionary: detailData)
                                detail.priceList = Array<BNElementDetail_PriceLlist>()
                                
                                for (var i = 0; i < body?.count; i++) {
                                    var line = body!.objectAtIndex(i) as! NSDictionary
                                    var priceListItem = BNElementDetail_PriceLlist()
                                    priceListItem.currency = self.networkManager!.findCurrency("currencyType", dictionary: line)
                                    priceListItem.description = self.networkManager!.findString("description", dictionary: line)
                                    priceListItem.price = self.networkManager!.findString("line", dictionary: line)
                                    detail.priceList!.append(priceListItem)
                                }
                                
                            }
                            
                            
                            self.element!.details.append(detail)
                        }
                        
                        var mediaArray = self.networkManager!.findNSArray("media", dictionary: elementData)
                        
                        for var j = 0; j < mediaArray?.count; j++ {
                            var mediaData = mediaArray!.objectAtIndex(j) as! NSDictionary
                            var url = self.networkManager!.findString("url", dictionary: mediaData)!
                            var type = self.networkManager!.findMediaType("mediaType", dictionary: mediaData)
                            var domainColor = self.networkManager!.findUIColor("domainColor", dictionary:mediaData)
                            var media = BNMedia(mediaType:type, url:url, domainColor:domainColor!)
                            self.element!.media.append(media)
                        }

                        self.element!.biinedCount = self.networkManager!.findInt("biinedCount", dictionary: elementData)!
                        self.element!.commentedCount = self.networkManager!.findInt("commentedCount", dictionary: elementData)!
                        self.element!.userBiined = self.networkManager!.findBool("userBiined", dictionary: elementData)
                        self.element!.userShared = self.networkManager!.findBool("userShared", dictionary: elementData)
                        self.element!.userCommented = self.networkManager!.findBool("userCommented", dictionary: elementData)
                        self.element!.userViewed = self.networkManager!.findBool("userViewed", dictionary: elementData)
                        
                        var hasSticker = self.networkManager!.findBool("hasSticker", dictionary: elementData)
                        
                        if (hasSticker) {
                            if let stickerData = elementData["sticker"] as? NSDictionary {
                                self.element!.hasSticker = hasSticker
                                var stickerColor = self.networkManager!.findUIColor("color", dictionary: stickerData)
                                var stickerType = self.networkManager!.findBNStickerType("type", dictionary: stickerData)
                                var sticker = BNSticker(type:stickerType, color:stickerColor!)
                                self.element!.sticker = sticker
                            }
                        }
                        
                        
                        println("Element url: \(self.requestString)")
                        
                        if self.element!.isHighlight {
                            self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedHightlight:self.element!)
                        } else {
                            self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedElement:self.element!)
                        }
                    }
                }
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }

}
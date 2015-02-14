//  EPSNetworking.swift
//  Biin
//  Created by Esteban Padilla on 6/23/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import SystemConfiguration

struct RequetingImage {
    var image:BNUIImageView
    var imageUrl:String
}

//TEMP
struct ShareEPSNetworking
{
    static var cacheImages:Dictionary<String, UIImage> = Dictionary<String, UIImage>()
    static var requestingImages:Array<RequetingImage> = Array<RequetingImage>()
}


class EPSNetworking:NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate {
    
    var urlDelegate:NSURLSessionDelegate?
    
    override init(){
        super.init()
    }
    
    
    func shouldTrustProtectionSpace() ->Bool {
        
//        var certPath = NSBundle.mainBundle().pathForResource("cert", ofType: "der")
//        var certData = NSData(contentsOfFile:certPath!)
//        println("\(certData)")
//        var certDataRef = certData as CFDataRef
//        var cert = SecCertificateCreateWithData(nil, certDataRef)
        
        return true
    }
    /*
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void){
        println("willSendRequestForAuthenticationChallenge")
        
        println(challenge.protectionSpace)
        
//        var credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
//        challenge.sender.useCredential(credential, forAuthenticationChallenge: challenge)
//        challenge.sender.cancelAuthenticationChallenge(challenge)
//        var credential = NSURLCredential(user:"username", password:"password", persistence: .ForSession)
//        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
        
        completionHandler(.PerformDefaultHandling, nil)
    }
    
    

    
    func get(request: NSMutableURLRequest, callback: (String, NSError?) -> Void) {
        
        
        
        var queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        var session = NSURLSession.sharedSession()
        var sessionConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: queue)
        
        let task = session.dataTaskWithRequest(request,
            completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                
                if (error != nil) {
                    callback("", error)
                    return
                }
                
                if (data != nil) {
                    
//                    println("------------------------------------------------------------")
//                    println("------------------------------------------------------------")
//                    println("jsonString received: \(data)")
                    
                    callback(NSString(data: data, encoding: NSUTF8StringEncoding)!, nil)
                } else {
                    callback("", error)
                }
        })
        

        task.resume()
        
        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request,
//            completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
//                
//                if (error != nil) {
//                    callback("", error)
//                    return
//                }
//                
//                if (data != nil) {
//                    callback(NSString(data: data, encoding: NSUTF8StringEncoding), nil)
//                } else {
//                    callback("", error)
//                }
//            })
//        
//        task.resume()
    }
    */
    
    
    func getWithConnection(request: NSURLRequest, callback: (String, NSError?) -> Void) {
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            var queue = NSOperationQueue()
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                
                if (error != nil) {
                    callback("", error)
                    return
                }
                
                if (data != nil) {
                    callback(NSString(data: data, encoding: NSUTF8StringEncoding)!, nil)
                } else {
                    callback("", error)
                }
            })
        })
    }
    
    func getJson( url: String, callback:(Dictionary<String, AnyObject>, NSError?) -> Void) {
        
        var request = NSURLRequest(URL:NSURL(string:url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)

//        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
//        request.setValue("application/json", forHTTPHeaderField:"Accept")
        
        self.getWithConnection(request, callback:{( data: String, error: NSError?) -> Void in
            
            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {
                
                //println("------------------------------------------------------------")
                //println("------------------------------------------------------------")
                println("jsonString received: \(data)")
                
                var jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }
    
    
    func postJson(url: String, httpParams:Dictionary<String, String>, callback:(Dictionary<String, AnyObject>, NSError?) -> Void) {
        
        var request = NSMutableURLRequest(URL:NSURL(string:url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        
        //        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        //        request.setValue("application/json", forHTTPHeaderField:"Accept")
        
        var params = ["games":"games", "music":"music"] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        println("HTTPBody: \(request.HTTPBody)")
        
        self.getWithConnection(request, callback:{( data: String, error: NSError?) -> Void in
            
            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {
                
                //println("------------------------------------------------------------")
                //println("------------------------------------------------------------")
                println("jsonString received: \(data)")
                
                var jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }
    
    
    
    func parseJson(jsonString:String) -> Dictionary<String, AnyObject> {
        
        var options = NSJSONReadingOptions.AllowFragments
        var error: NSError?
        var data: NSData = jsonString.dataUsingEncoding( NSUTF8StringEncoding )!
        var json = NSJSONSerialization.JSONObjectWithData(data, options:options, error:&error) as Dictionary<String, AnyObject>
        
//        println("------------------------------------------------------------")
//        println("------------------------------------------------------------")
//        println("jsonString received: \(data)")
        
        
        if error != nil {
            return Dictionary<String, AnyObject>()
        } else {
            return json
        }
    }
    
    func getImage(urlString:NSString, image:BNUIImageView, callback:(NSError?) -> Void) {

        //add requesting image to queue
        
        if let cacheImage = ShareEPSNetworking.cacheImages[urlString] {
            println("image already in cache...")
            image.image = cacheImage
        }else {
        
        // Jump in to a background thread to get the image for this item
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

            // Check our image cache for the existing key. This is just a dictionary of UIImages
//            if let cacheImage = ShareEPSNetworking.cacheImages[urlString] {
//                println("image already in cache...")
//                image.image = cacheImage
//            }else {
            
                //TESTING
                //If the image does not exist, we need to download it
//                var loader = UIView(frame: CGRectMake(20, 20, 20, 20))
//                loader.backgroundColor = UIColor.redColor()
//                image.superview?.addSubview(loader)
                
                //println("requesting image: \(urlString)")
                
                ShareEPSNetworking.requestingImages.append(RequetingImage(image: image, imageUrl: urlString))
                
                var url: NSURL = NSURL(string: urlString)!
                
                // Download an NSData representation of the image at the URL
                var request: NSURLRequest = NSURLRequest(URL:url)
//                var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)!
            
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                        
                    if (error? != nil) {
                        println("Error on image request\( error! )")
                        callback(error)
                    } else {
                        //Send image to be store in image dictionary
                        
                        
                        
                        //println("Store image: \(urlString)")
                        ShareEPSNetworking.cacheImages[urlString] = UIImage(data: data)
//                        image.image = UIImage(data: data)
                        
                        self.sentImages(urlString)
                        //println("image cache count \(ShareEPSNetworking.cacheImages.count)")
                        
                        callback(nil)
                    }
                })
//            }
        })
        }

    }

    func sentImages(imageUrl:String){
        for (var i = 0; i < ShareEPSNetworking.requestingImages.count; i++){
            if ShareEPSNetworking.requestingImages[i].imageUrl == imageUrl {
                if let cacheImage = ShareEPSNetworking.cacheImages[imageUrl] {
                    ShareEPSNetworking.requestingImages[i].image.image = cacheImage
                    ShareEPSNetworking.requestingImages[i].image.showAfterDownload()
                }
            }
        }
        
        for (var i = 0; i < ShareEPSNetworking.requestingImages.count; i++){
            if ShareEPSNetworking.requestingImages[i].imageUrl == imageUrl {
                ShareEPSNetworking.requestingImages.removeAtIndex(i)
            }
        }
        
        println("pending: \(ShareEPSNetworking.requestingImages.count) ")
    }
    
    
    
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        println("\(dataTask.countOfBytesExpectedToReceive)")
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        println("didReceiveResponse")
    }
}

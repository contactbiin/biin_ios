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

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            var queue = NSOperationQueue()
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                
                if (error != nil) {
                    callback("", error)
                    return
                }
                
                if (data != nil) {
                    
//                    var zipData = NSData(contentsOfURL:request.URL!)
//                    var gzipString = NSString(data: zipData!, encoding:NSUTF8StringEncoding )! as String
//                    var gzipData = NSData(base64EncodedString: gzipString, options: NSDataBase64DecodingOptions.allZeros)
//                    
//                    
//                    println("------------------------------------------------------------")
//                    println("------------------------------------------------------------")
//                    println("jsonString received: \(gzipData)")
                    
                    callback(NSString(data: data, encoding:NSUTF8StringEncoding)! as String, nil)
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                } else {
                    callback("", error)
                }
            })
        })
    }
    
    func getJson(useCache:Bool, url: String, callback:(Dictionary<String, AnyObject>, NSError?) -> Void) {
        
        //var request = NSURLRequest(URL:NSURL(string:url)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 25.0)
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        //NSLog("BIIN - getJson 1")
        
        
        if BNAppSharedManager.instance.settings!.IS_USING_CACHE && useCache {
            request.cachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
            //NSLog("BIIN - getJson 2")
        } else {
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
            //NSLog("BIIN - getJson 3 -- \(url)")
        }
        
        request.timeoutInterval = 25.0
        //request.setValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")
        //request.addValue("gzip", forHTTPHeaderField: "Content-Encoding")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept-Encoding")
        
        
        var session = NSURLSession.sharedSession()
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
//        request.setValue("application/json", forHTTPHeaderField:"Accept")
        
        
        self.getWithConnection(request, callback:{( data: String, error: NSError?) -> Void in
            
            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {
                
//                println("------------------------------------------------------------")
//                println("------------------------------------------------------------")
//                println("jsonString received: \(data)")
                
                var jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }
    
    
    func post(params : Dictionary<String, String>, url : String) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
  //          println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }
    
    /*
    func post(params : Dictionary<String, String>, url : String) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }
    */

    
    func post(url: String, htttpBody:NSData?, callback:(Dictionary<String, AnyObject>, NSError?) -> Void) {
        
        var request = NSMutableURLRequest(URL:NSURL(string:url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 25.0)
        
        var err: NSError?
        request.HTTPMethod = "POST"
        request.HTTPBody = htttpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var httpString = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
        println("HTTPBody: \(httpString)")
        
        self.getWithConnection(request, callback:{( data: String, error: NSError?) -> Void in
            
            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {
                
                //println("------------------------------------------------------------")
                //println("------------------------------------------------------------")
                //println("jsonString received: \(data)")
                
                var jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }
    
    func put(url: String, htttpBody:NSData?, callback:(Dictionary<String, AnyObject>, NSError?) -> Void) {
        
        var request = NSMutableURLRequest(URL:NSURL(string:url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 25.0)
        
        var err: NSError?
        request.HTTPMethod = "PUT"
        request.HTTPBody = htttpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var httpString = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
        NSLog("BIIN - HTTPBody: \(httpString)")
        
        self.getWithConnection(request, callback:{( data: String, error: NSError?) -> Void in
            
            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {
                
//                println("------------------------------------------------------------")
//                println("------------------------------------------------------------")
//                println("jsonString received: \(data)")
                
                var jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }

    
    func delete(url: String, htttpBody:NSData?, callback:(Dictionary<String, AnyObject>, NSError?) -> Void) {
        
        var request = NSMutableURLRequest(URL:NSURL(string:url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 25.0)
        
        var err: NSError?
        request.HTTPMethod = "DELETE"
        request.HTTPBody = htttpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var httpString = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
        println("HTTPBody: \(httpString)")
        
        self.getWithConnection(request, callback:{( data: String, error: NSError?) -> Void in
            
            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {
                
                println("------------------------------------------------------------")
                println("------------------------------------------------------------")
                println("DELETE: jsonString received: \(data)")
                
                var jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }

    
    func parseJson(jsonString:String) -> Dictionary<String, AnyObject> {
        
        var options = NSJSONReadingOptions.AllowFragments
        var error: NSError?
        var data: NSData = jsonString.dataUsingEncoding( NSUTF8StringEncoding )!
        
        //TODO: Caough error when data is empty
        var json = NSJSONSerialization.JSONObjectWithData(data, options:options, error:&error) as! Dictionary<String, AnyObject>?
        
        //println("------------------------------------------------------------")
        //println("------------------------------------------------------------")
        //println("jsonString received: \(json)")
        //println("json cound: \(json!.count)")
        
        if error != nil {
            return Dictionary<String, AnyObject>()
        } else {
            return json!
        }
    }
    
    func getImageInCache(urlString:NSString, image:BNUIImageView) {
        
        //OLD
        ShareEPSNetworking.requestingImages.append(RequetingImage(image: image, imageUrl: urlString as String))

        
    }
    
    func getImage(urlString:NSString, image:BNUIImageView, callback:(NSError?) -> Void) {

        //add requesting image to queue
        
//        if let cacheImage = ShareEPSNetworking.cacheImages[urlString as String] {
        if let cacheImage = findImageInBiinChacheLocalFolder(urlString as String, image:image) {
            //println("image already in cache...")
            image.image = cacheImage
            image.showAfterDownload()
            //BNAppSharedManager.instance.networkManager.removeImageRequest(urlString as String)
            self.sentImages(urlString as String)
            callback(nil)
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
                
                ShareEPSNetworking.requestingImages.append(RequetingImage(image: image, imageUrl: urlString as String))
                
                var url: NSURL = NSURL(string: urlString as String)!
                
                // Download an NSData representation of the image at the URL
                var request: NSURLRequest = NSURLRequest(URL:url)
//                var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)!
            
            
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                        
                    if (error != nil) {
                        //println("Error on image request\( error! )")
                        callback(error)
                    } else {
                        //Send image to be store in image dictionary

                        //println("Store image: \(urlString)")
                        ShareEPSNetworking.cacheImages[urlString as String] = UIImage(data: data)
//                        image.image = UIImage(data: data)
                        
                        self.sentImages(urlString as String)
                        //println("image cache count \(ShareEPSNetworking.cacheImages.count)")
                        
                        self.saveImageInBiinChacheLocalFolder(urlString as String, image:UIImage(data: data)!)
                        
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        
                        
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
        
        //println("pending: \(ShareEPSNetworking.requestingImages.count) ")
        
        
        if ShareEPSNetworking.requestingImages.count == 0 {
            ShareEPSNetworking.cacheImages.removeAll(keepCapacity: false)
            ShareEPSNetworking.requestingImages.removeAll(keepCapacity: false)
        }
    }
    
    
    
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        println("\(dataTask.countOfBytesExpectedToReceive)")
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        println("didReceiveResponse")
    }
    
    func findImageInBiinChacheLocalFolder(urlString:String, image:BNUIImageView) -> UIImage? {
        //NEW
        // path to documents directory
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first as! String

        // create the custom folder path
        let biinCacheImagesFolder = documentDirectoryPath.stringByAppendingPathComponent(BNAppSharedManager.instance.biinCacheImagesFolder)
        

        //let imageData = UIImagePNGRepresentation(selectedImage)
        //let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first as! String
        
        
        
        
        //println("-----------------     \(urlString)")
        var index2 = urlString.rangeOfString("/", options: .BackwardsSearch)?.endIndex
        var substring2 = urlString.substringFromIndex(index2!)
        //println("-----------------     \(index2)")
        //println("-----------------     \(substring2)")
        
        let imagePath = biinCacheImagesFolder.stringByAppendingPathComponent(substring2)
        
//        let imagePath = biinCacheImagesFolder.stringByAppendingPathComponent(urlString)
        
        
        if NSFileManager.defaultManager().fileExistsAtPath(imagePath) == false {
            
            //println("Image:\(urlString) does not exist on BiinCacheImages folder, request and Save!")
            return nil
            
        } else {
            
            //println("Loading image:\(urlString) from on BiinCacheImages folder.")
            //TODO: LOAD IMAGE HERE
//            var loadedImage = UIImage(contentsOfFile:imagePath)
            return UIImage(contentsOfFile:imagePath)
        }
    }
    
    
    func saveImageInBiinChacheLocalFolder(urlString:String, image:UIImage) {
        //NEW
        // path to documents directory
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first as! String
        
        // create the custom folder path
        let biinCacheImagesFolder = documentDirectoryPath.stringByAppendingPathComponent(BNAppSharedManager.instance.biinCacheImagesFolder)
        
        let imageData = UIImagePNGRepresentation(image)// UIImageJPEGRepresentation(image, 1)
        //let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first as! String
        
        //println("-----------------     \(urlString)")
        var index2 = urlString.rangeOfString("/", options: .BackwardsSearch)?.endIndex
        var substring2 = urlString.substringFromIndex(index2!)
        //println("-----------------     \(index2)")
        //println("-----------------     \(substring2)")
        
        let imagePath = biinCacheImagesFolder.stringByAppendingPathComponent(substring2)

        if NSFileManager.defaultManager().fileExistsAtPath(imagePath) == false {
        
            if !imageData.writeToFile(imagePath, atomically: false) {
                //println("not saved:\(imagePath)")
            } else {
                //println("Saving image:\(urlString) on BiinCacheImages folder!")
                NSUserDefaults.standardUserDefaults().setObject(imagePath, forKey:urlString)
            }
        }
    }
}

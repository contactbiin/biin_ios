//  EPSNetworking.swift
//  Biin
//  Created by Esteban Padilla on 6/23/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import SystemConfiguration
import QuartzCore

struct RequetingImage {
    var image: BNUIImageView
    var imageUrl: String
}

//TEMP
struct ShareEPSNetworking {
    static var cacheImages: Dictionary<String, UIImage> = Dictionary<String, UIImage>()
    static var requestingImages: Array<RequetingImage> = Array<RequetingImage>()
}

class EPSNetworking: NSObject {

    override init() {
        super.init()
    }

    func shouldTrustProtectionSpace() -> Bool {

        return true
    }

    func getWithConnection(identifier: Int, request: NSURLRequest, callback: (String, NSError?) -> Void) {

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in

            dispatch_async(dispatch_get_main_queue(), {

                if (error != nil) {
                    callback("", error)
                    return
                }

                if (data != nil) {

                    callback(NSString(data: data!, encoding: NSUTF8StringEncoding)! as String, nil)
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false

                } else {
                    callback("", error)
                }
            })

        }

        task.resume()
    }

    func checkConnection(useCache: Bool, url: String, callback: (NSError?) -> Void) {

        //var Status:Bool = false
        let url = NSURL(string: url)
        let request = NSMutableURLRequest(URL: url!)

        if BNAppSharedManager.instance.settings!.IS_USING_CACHE && useCache {
            request.cachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
        } else {
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        }

        request.HTTPMethod = "HEAD"
        request.timeoutInterval = 10.0

        self.getWithConnection(0, request: request, callback: { (data: String, error: NSError?) -> Void in

            if error != nil {
                callback(error)
            } else {
                callback(nil)
            }
        })
    }

    func getJson(identifier: Int, url: String, callback: (Dictionary<String, AnyObject>, NSError?) -> Void) {

        //var request = NSURLRequest(URL:NSURL(string:url)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 25.0)
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)

        //NSLog("BIIN - getJson 1")

        if BNAppSharedManager.instance.settings!.IS_USING_CACHE {
            request.cachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
            //NSLog("BIIN - getJson 2 -- \(url)")
        } else {
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
            //NSLog("BIIN - getJson 3 -- \(url)")
        }

        request.timeoutInterval = 25.0
        request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        request.addValue("gzip", forHTTPHeaderField: "Content-Encoding")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept-Encoding")

        self.getWithConnection(identifier, request: request, callback: { (data: String, error: NSError?) -> Void in

            if error != nil {

                callback(Dictionary<String, AnyObject>(), error)
            } else {

                let jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }

    func post(params: Dictionary<String, String>, url: String) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"

        //var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch _ as NSError {
            //err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in

        })

        task.resume()
    }

    func post(identifier: Int, url: String, htttpBody: NSData?, callback: (Dictionary<String, AnyObject>, NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 25.0)

        //var err: NSError?
        request.HTTPMethod = "POST"
        request.HTTPBody = htttpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let httpString = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
        print("HTTPBody: \(httpString)")
        NSLog("BIIN: url:\(url), httpString:\(httpString)")

        self.getWithConnection(identifier, request: request, callback: { (data: String, error: NSError?) -> Void in

            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {

                let jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }

    func put(identifier: Int, url: String, htttpBody: NSData?, callback: (Dictionary<String, AnyObject>, NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 25.0)

        //var err: NSError?
        request.HTTPMethod = "PUT"
        request.HTTPBody = htttpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let httpString = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
        print("\(httpString)")
        //NSLog("BIIN - HTTPBody: \(httpString!)")

        self.getWithConnection(identifier, request: request, callback: { (data: String, error: NSError?) -> Void in

            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {

                let jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }

    func delete(identifier: Int, url: String, htttpBody: NSData?, callback: (Dictionary<String, AnyObject>, NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 25.0)

        //var err: NSError?
        request.HTTPMethod = "DELETE"
        request.HTTPBody = htttpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //let httpString = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
        //        print("HTTPBody: \(httpString)")

        self.getWithConnection(identifier, request: request, callback: { (data: String, error: NSError?) -> Void in

            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {

                let jsonData = self.parseJson(data)
                callback(jsonData, nil)
            }
        })
    }

    func parseJson(jsonString: String) -> Dictionary<String, AnyObject> {

        let options = NSJSONReadingOptions.AllowFragments
        //let error: NSError?
        let data: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)!

        let json: AnyObject

        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: options)
            // success ...
        } catch {
            // failure
            //print("Fetch failed: \((error as NSError).localizedDescription)")
            return Dictionary<String, AnyObject>()
        }

        return json as! Dictionary<String, AnyObject>
    }

    func getImageInCache(urlString: NSString, image: BNUIImageView) {

        //OLD
        ShareEPSNetworking.requestingImages.append(RequetingImage(image: image, imageUrl: urlString as String))

    }

    func getImage(urlString: NSString, image: BNUIImageView, callback: (NSError?) -> Void) {

        if let cacheImage = findImageInBiinChacheLocalFolder(urlString as String, image: image) {

            image.image = cacheImage
            image.showAfterDownload()

            self.sentImages(urlString as String)
            callback(nil)
        } else {

            ShareEPSNetworking.requestingImages.append(RequetingImage(image: image, imageUrl: urlString as String))

            let url: NSURL = NSURL(string: urlString as String)!

            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 25)

            UIApplication.sharedApplication().networkActivityIndicatorVisible = true

            let session = NSURLSession.sharedSession()
            let dataTask = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in

                dispatch_async(dispatch_get_main_queue(), {

                    if (error != nil) {

                        callback(error)
                    } else {
                        
                        //Send image to be store in image dictionary
                        if data != nil {
                        
                            let imageDownload = UIImage(data: data!)!

                            ShareEPSNetworking.cacheImages[urlString as String] = self.optimizeImageForRender(imageDownload.CGImage!)

                            self.sentImages(urlString as String)

                            self.saveImageInBiinChacheLocalFolder(urlString as String, image: imageDownload)

                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

                        }
                        
                        callback(nil)
                    }
                })
            }

            dataTask.resume()
        }

    }

    func sentImages(imageUrl: String) {
        //
        //        for i in 0..<ShareEPSNetworking.requestingImages.count {
        //
        //            if ShareEPSNetworking.requestingImages[i].imageUrl == imageUrl {
        //                if let cacheImage = ShareEPSNetworking.cacheImages[imageUrl] {
        //                    ShareEPSNetworking.requestingImages[i].image.image = cacheImage
        //                    ShareEPSNetworking.requestingImages[i].image.showAfterDownload()
        //                }
        //            }
        //        }

        for image in ShareEPSNetworking.requestingImages {
            if image.imageUrl == imageUrl {
                if let cacheImage = ShareEPSNetworking.cacheImages[imageUrl] {
                    image.image.image = cacheImage
                    image.image.showAfterDownload()

                }
            }
        }

        for j in (0 ..< ShareEPSNetworking.requestingImages.count).reverse() {
            if ShareEPSNetworking.requestingImages[j].imageUrl == imageUrl {
                ShareEPSNetworking.requestingImages.removeAtIndex(j)
            }
        }

        if ShareEPSNetworking.requestingImages.count == 0 {
            ShareEPSNetworking.cacheImages.removeAll(keepCapacity: false)
            ShareEPSNetworking.requestingImages.removeAll(keepCapacity: false)
        }
    }

    func findImageInBiinChacheLocalFolder(urlString: String, image: BNUIImageView) -> UIImage? {

        if !image.useCache {
            return nil
        }

        // path to documents directory
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first

        // create the custom folder path
        let biinCacheImagesFolder = documentDirectoryPath!.stringByAppendingPathComponent(BNAppSharedManager.instance.biinCacheImagesFolder)

        //let imageData = UIImagePNGRepresentation(selectedImage)
        //let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first as! String

        let index2 = urlString.rangeOfString("/", options: .BackwardsSearch)?.endIndex
        let substring2 = urlString.substringFromIndex(index2!)

        let imagePath = biinCacheImagesFolder.stringByAppendingPathComponent(substring2)

        if NSFileManager.defaultManager().fileExistsAtPath(imagePath) == false {

            //print("Image:\(urlString) does not exist on BiinCacheImages folder, request and Save!")
            return nil

        } else {

            //print("Loading image:\(urlString) from on BiinCacheImages folder.")

            /*
             //Using UIKIT
             let image = UIImage(contentsOfFile:imagePath)

             let size = CGSizeApplyAffineTransform(image!.size, CGAffineTransformMakeScale(0.25, 0.25))
             let hasAlpha = true
             let scale: CGFloat = 0.0 // Automatically use scale factor of main screen

             UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
             image!.drawInRect(CGRect(origin: CGPointZero, size: size))

             let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
             UIGraphicsEndImageContext()
             */

            /*
             let cgImage = UIImage(contentsOfFile:imagePath)!.CGImage

             let width = CGImageGetWidth(cgImage) / 2
             let height = CGImageGetHeight(cgImage) / 2
             let bitsPerComponent = CGImageGetBitsPerComponent(cgImage)
             let bytesPerRow = CGImageGetBytesPerRow(cgImage)
             let colorSpace = CGImageGetColorSpace(cgImage)
             let bitmapInfo = CGImageGetBitmapInfo(cgImage)

             let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)

             CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)

             CGContextDrawImage(context, CGRect(origin: CGPointZero, size: CGSize(width: CGFloat(width), height: CGFloat(height))), cgImage)

             let scaledImage = CGBitmapContextCreateImage(context).flatMap { UIImage(CGImage: $0)}
             */

            return optimizeImageForRender(UIImage(contentsOfFile: imagePath)!.CGImage!)//scaledImage//UIImage(contentsOfFile:imagePath)
        }
    }

    func optimizeImageForRender(cgImage: CGImageRef)  -> UIImage? {

        //let cgImage = UIImage(contentsOfFile:imagePath)!.CGImage

        let width = CGImageGetWidth(cgImage) / 2
        let height = CGImageGetHeight(cgImage) / 2
        let bitsPerComponent = CGImageGetBitsPerComponent(cgImage)
        let bytesPerRow = CGImageGetBytesPerRow(cgImage)
        let colorSpace = CGImageGetColorSpace(cgImage)
        let bitmapInfo = CGImageGetBitmapInfo(cgImage)

        let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)

        CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)

        CGContextDrawImage(context, CGRect(origin: CGPointZero, size: CGSize(width: CGFloat(width), height: CGFloat(height))), cgImage)

        let scaledImage = CGBitmapContextCreateImage(context).flatMap { UIImage(CGImage: $0) }

        return scaledImage//UIImage(contentsOfFile:imagePath)
    }

    func saveImageInBiinChacheLocalFolder(urlString: String, image: UIImage) {
        //NEW
        // path to documents directory
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first

        // create the custom folder path
        let biinCacheImagesFolder = documentDirectoryPath!.stringByAppendingPathComponent(BNAppSharedManager.instance.biinCacheImagesFolder)

        let imageData = UIImageJPEGRepresentation(image, 0.45)
        //let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first as! String

        let index2 = urlString.rangeOfString("/", options: .BackwardsSearch)?.endIndex
        let substring2 = urlString.substringFromIndex(index2!)

        let imagePath = biinCacheImagesFolder.stringByAppendingPathComponent(substring2)

        if NSFileManager.defaultManager().fileExistsAtPath(imagePath) == false {

            if !imageData!.writeToFile(imagePath, atomically: false) {
                //print("-------- Not saved:\(imagePath)")
            } else {
                //print("-------- Saving image:\(urlString) on BiinCacheImages folder!")
                NSUserDefaults.standardUserDefaults().setObject(imagePath, forKey: urlString)
            }
        }
    }

    func clean() {
        ShareEPSNetworking.cacheImages.removeAll(keepCapacity: false)
        ShareEPSNetworking.requestingImages.removeAll(keepCapacity: false)
    }
}

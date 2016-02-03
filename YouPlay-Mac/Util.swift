//
//  Util.swift
//  YouPlay-Mac
//
//  Created by 吴建国 on 16/2/3.
//  Copyright © 2016年 wujianguo. All rights reserved.
//

import Cocoa

class Util {
    static let imageCache = NSCache()
    
}

import Alamofire

extension NSImageView {
    class func requestImageWithUrlString(str: String?, complete: ((NSImage)->Void)? = nil) {
        if let url = NSURL(string: str ?? "") {
            requestImageWithUrl(url, complete: complete)
        }
    }
    
    class func requestImageWithUrl(url: NSURL, complete: ((NSImage)->Void)? = nil) {
        if let image = Util.imageCache.objectForKey(url) as? NSImage {
            complete?(image)
            return
        }
        Alamofire.request(.GET, url.absoluteString)
            .responseData { response in
                guard response.data != nil else { return }
                if let img = NSImage(data: response.data!) {
                    Util.imageCache.setObject(img, forKey: url)
                    complete?(img)
                }
        }
    }
    
    func setImageWithUrlString(str: String?, complete: ((NSImage)->Void)? = nil) {
        NSImageView.requestImageWithUrlString(str) { (image) -> Void in
            self.image = image
            complete?(image)
        }
    }
    
    func setImageWithURL(url: NSURL, complete: ((NSImage)->Void)? = nil) {
        NSImageView.requestImageWithUrl(url) { (image) -> Void in
            self.image = image
            complete?(image)
        }
    }
}
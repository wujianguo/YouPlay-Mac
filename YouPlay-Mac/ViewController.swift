//
//  ViewController.swift
//  YouPlay-Mac
//
//  Created by wujianguo on 16/1/2.
//  Copyright © 2016年 wujianguo. All rights reserved.
//

import Cocoa
import VLCKit

//private let api = "https://youplay.leanapp.cn/api/v1"
private let api = "http://127.0.0.1:8888/api/v1"

class ViewController: NSViewController {

    var player: VLCMediaListPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        player = VLCMediaListPlayer(drawable: view as! VLCVideoView)
        play("http://www.iqiyi.com/v_19rrl5wsqk.html#vfrm=2-3-0-1")
    }
    
    func parse(url: String, complete: ([String]) -> Void) {
        let base64 = url.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        let remote = "\(api)/videos2/\(base64)"
        print(remote)
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: remote)!) { (data, response, error) -> Void in
            guard data != nil && error == nil else { return }
            let json = JSON(data: data!)
            var urls = [String]()
            for en in json["entries"].arrayValue {
                urls.append(en["url"].stringValue)
            }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                complete(urls)
            }
        }.resume()
    }
    
    func play(url: String) {
        player.mediaList = VLCMediaList(array: [])
        parse(url) { (urls) -> Void in
            self.updateUrls(urls)
        }
    }
    
    func updateUrls(urls: [String]) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerTimeChanged:", name: VLCMediaPlayerTimeChanged, object: nil)
        for i in 0..<urls.count {
            player.mediaList.addMedia(VLCMedia(URL: NSURL(string: urls[urls.count-1-i])))
        }
        player.play()
    }
    
    func playerTimeChanged(notification: NSNotification) {
        print("playerTimeChanged: \(player.mediaPlayer.time), \(player.mediaPlayer.remainingTime)")
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


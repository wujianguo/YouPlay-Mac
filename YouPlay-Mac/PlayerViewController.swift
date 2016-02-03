//
//  PlayerViewController.swift
//  YouPlay-Mac
//
//  Created by 吴建国 on 16/1/20.
//  Copyright © 2016年 wujianguo. All rights reserved.
//

import Cocoa
import VLCKit

private extension String {
    var base64Value: String {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
}

private let api = "http://127.0.0.1:6066"

class PlayerViewController: NSViewController, VLCMediaPlayerDelegate {

    var player: VLCMediaListPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        player = VLCMediaListPlayer(drawable: view as! VLCVideoView)
        play("")
    }
    
    func play(url: String) {
        player.mediaList = VLCMediaList()
        for i in 0..<8 {
            player.mediaList.addMedia(VLCMedia(URL: NSURL(string: "http://127.0.0.1:6066/\(8-i).f4v")))
        }
        player.play()
        player.mediaPlayer.delegate = self
    }
    
    func mediaPlayerStateChanged(aNotification: NSNotification!) {
        print("mediaPlayerStateChanged to \(VLCMediaPlayerStateToString(player.mediaPlayer.state))")
        if player.mediaPlayer.state == .Stopped {
            if player.next {
                let index = player.mediaList.indexOfMedia(player.mediaPlayer.media) + 1
                print("play next \(index)")
                player.playItemAtIndex(Int32(index))
            }
        }
    }
    
    func mediaPlayerTimeChanged(aNotification: NSNotification!) {

    }
    
}

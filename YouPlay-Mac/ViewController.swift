//
//  ViewController.swift
//  YouPlay-Mac
//
//  Created by wujianguo on 16/1/2.
//  Copyright © 2016年 wujianguo. All rights reserved.
//

import Cocoa
import VLCKit

class ViewController: NSViewController {

    var player: VLCMediaPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let v = view as? VLCVideoView {
            player = VLCMediaPlayer(videoView: v)
            player?.media = VLCMedia(URL: NSURL(string: "http://119.147.17.153/videos/v0/20160113/72/3f/944ae550e326899cb775b41ade34e68b.f4v?key=063201557f936086fc55268f32e6df772&src=iqiyi.com&su=7c867f34c24e442cad3dda5a5f6f7eea&qyid=7a9afa08785a4cf38f8edc33f79828f1&client=&z=&bt=&ct=&tn=11258&uuid=b710073a-5699e562-66"))
            player?.play()
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


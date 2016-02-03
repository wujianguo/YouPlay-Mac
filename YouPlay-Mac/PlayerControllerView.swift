//
//  PlayerControllerView.swift
//  YouPlay-Mac
//
//  Created by 吴建国 on 16/1/20.
//  Copyright © 2016年 wujianguo. All rights reserved.
//

import Cocoa
import SnapKit

class PlayerControllerView: NSView {

    override func awakeFromNib() {
        super.awakeFromNib()
//        setup()
    }
    
    var playButton = NSButton()
    func setup() {
        addSubview(playButton)
        playButton.title = "play"
        playButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp_bottom).offset(-40)
            make.centerX.equalTo(self)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
}

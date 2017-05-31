//
//  MXVideoBackgroundVC.swift
//  MXVideoBackground
//
//  Created by maRk on 2017/5/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

enum MXVideoContentMode {
    case MXVideoContentModeResize
    case MXVideoContentModeAspectFit
    case MXVideoContentModeAspectFill
}

class MXVideoBackgroundVC: UIViewController {
    
    var videoPlayer = AVPlayerViewController()
    var soundLevel: Float = 1.0
    var startTime: CGFloat = 0.0
    var durationTime: CGFloat = 0.0
    var videoFrame: CGRect = CGRect.zero
    var contentUrl: URL? {
        didSet {
            configVideoPlayer(url: contentUrl!)
        }
    }
    
    var backgroundSound: Bool = true {
        didSet {
            if backgroundSound {
                soundLevel = 1.0
            }else {
                soundLevel = 0.0
            }
        }
    }
    
    var alpha: CGFloat = 1.0 {
        didSet {
            videoPlayer.view.alpha = alpha
        }
    }
    
    var contentMode: MXVideoContentMode = .MXVideoContentModeResize {
        didSet {
            switch contentMode {
            case .MXVideoContentModeResize:
                videoPlayer.videoGravity = AVLayerVideoGravityResize
            case .MXVideoContentModeAspectFit:
                videoPlayer.videoGravity = AVLayerVideoGravityResizeAspect
            case .MXVideoContentModeAspectFill:
                videoPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill

            }
        }
    }
    
    var alwaysRepeat: Bool = true {
        didSet {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer.view.frame = videoFrame
        view.addSubview(videoPlayer.view)
        view.sendSubview(toBack: videoPlayer.view)
    }

    private func configVideoPlayer(url: URL) {
        videoPlayer.player = AVPlayer(url: url)
        videoPlayer.player?.play()
        videoPlayer.player?.volume = soundLevel
    }

}

//
//  ViewController.swift
//  MXVideoBackground
//
//  Created by maRk on 2017/5/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class ViewController: MXVideoBackgroundVC {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initConfig()
        
        loginButton.layer.cornerRadius = 4
        signupButton.layer.cornerRadius = 4
    }
    
    func initConfig() {
        videoFrame = view.frame
        contentUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        backgroundSound = true
        alwaysRepeat = true
        contentMode = .MXVideoContentModeResize
        startTime = 2.0
        alpha = 0.8
    }

    
}


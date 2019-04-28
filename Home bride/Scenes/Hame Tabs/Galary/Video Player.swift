//
//  Video Player.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

//import Foundation
import UIKit
import NicooPlayer
//
class VideoPlayer: UIViewController {

//    let mainView = VideoPlayerView()
//    override func loadView() {
////        view = mainView
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let orirntation = UIApplication.shared.statusBarOrientation
        if  orirntation == UIInterfaceOrientation.landscapeLeft || orirntation == UIInterfaceOrientation.landscapeRight {
            return .lightContent
        }
        return .default
    }

    var url = ""

    fileprivate lazy var videoPlayer: NicooPlayerView = {
        let player = NicooPlayerView(frame: self.view.frame, bothSidesTimelable: true)
        player.delegate = self
        return player
    }()
    

    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "رجوع", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissMePlease))
        view.addSubview(videoPlayer)
        videoPlayer.centerInSuperview()
        videoPlayer.widthAnchorWithMultiplier(multiplier: 1)
        videoPlayer.heightAnchorEqualWidthAnchor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        videoPlayer.playLocalVideoInFullscreen(url, "", view, sinceTime: 0)
        videoPlayer.playLocalFileVideoCloseCallBack = { [weak self] (playValue) in
            self?.navigationController?.popViewController(animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoPlayer.cancle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension VideoPlayer: NicooPlayerDelegate {
    func retryToPlayVideo(_ videoModel: NicooVideoModel?, _ fatherView: UIView?) {
        //
    }
}

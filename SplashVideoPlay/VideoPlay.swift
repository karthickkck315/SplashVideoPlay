//
//  VideoPlay.swift
//  Salaat
//
//  Created by Karthick on 5/15/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

import UIKit
import AVFoundation
class VideoPlay: UIViewController {

  var avPlayer: AVPlayer!
  var avPlayerLayer: AVPlayerLayer!
  var paused: Bool = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let theURL = Bundle.main.url(forResource:"Bunny", withExtension: "mp4")
      avPlayer = AVPlayer(url: theURL!)
      avPlayerLayer = AVPlayerLayer(player: avPlayer)
      avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
      avPlayer.volume = 10
      avPlayer.actionAtItemEnd = .none
      
      avPlayerLayer.frame = view.layer.bounds
      view.backgroundColor = .clear
      view.layer.insertSublayer(avPlayerLayer, at: 0)
      NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd(notification:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: avPlayer.currentItem)
      
  }
  @objc func playerItemDidReachEnd(notification: Notification) {
    print("end video")
    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomePage")
    self.navigationController?.pushViewController(homePage!, animated: true)
//    let p: AVPlayerItem = notification.object as! AVPlayerItem
//    p.seek(to: kCMTimeZero)
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    avPlayer.play()
    paused = false
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    avPlayer.pause()
    paused = true
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

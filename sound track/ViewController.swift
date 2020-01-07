//
//  ViewController.swift
//  sound track
//
//  Created by MacStudent on 2020-01-07.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
//we need an instance of avaudioplayer
    var player = AVAudioPlayer()
    let path = Bundle.main.path(forResource: "bach", ofType: "mp3")//provide path for audio
    var timer = Timer()
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var scrubber: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            scrubber.maximumValue = Float(player.duration)
        }catch {
            print(error)
        }
       
    }

    @IBAction func playTrack(_ sender: UIBarButtonItem) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateScrubber), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopTrack(_ sender: UIButton) {
        player.stop()
        timer.invalidate()
        player.currentTime = 0
    }
    
    
    @IBAction func pauseTrack(_ sender: UIBarButtonItem) {
        player.pause()
        timer.invalidate()
    }
  @objc  func updateScrubber(){
        scrubber.value = Float(player.currentTime)
    }
    
    @IBAction func volumnChanged(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func scrubberMoved(_ sender: UISlider) {
        player.currentTime = TimeInterval(scrubber.value)
        player.play()
    }
}


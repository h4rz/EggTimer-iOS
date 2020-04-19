//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var eggTimes = ["Soft":300,"Medium":420,"Hard":720]
    var totalTime = 0
    var timePassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        timePassed = 0
        progressView.progress = 0.0
        let hardness = sender.currentTitle ?? "How do you like your eggs?"
        topLabel.text = hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timePassed < totalTime{
            timePassed += 1
            progressView.progress = Float(timePassed) / Float(totalTime)
        } else {
            timer.invalidate()
            topLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}


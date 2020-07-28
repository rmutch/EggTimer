//
//  ViewController.swift
//  EggTimer
//
//  Created by Robert Mutch on 07/28/2020.
//  Copyright © Robert Mutch. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer: Timer?
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    
    @IBAction func hardnessChosen(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0
        secondsPassed = 0
        titleLabel.text = hardness
        
        if timer != nil {
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                self.progressBar.progress = Float(self.secondsPassed) / Float(self.totalTime)

            } else {
                self.titleLabel.text = "Done!"
                timer.invalidate()
                
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player!.play()
            }
        }
    }
    
}

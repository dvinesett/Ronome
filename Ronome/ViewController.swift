//
//  ViewController.swift
//  Ronome
//
//  Created by Vinesett, Dylan on 11/8/15.
//  Copyright © 2015 Vinesett, Dylan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var tempoStepper: UIStepper!
    @IBOutlet weak var tempoSlider: UISlider!
    
    var metronomeTimer: NSTimer!
    var metronomeIsOn = false
    var metronomeSoundPlayer: AVAudioPlayer!
    var tempo: NSTimeInterval = 60 {
        didSet {
            tempoLabel.text = String(format: "%.0f", tempo)
            tempoStepper.value = Double(tempo)
            tempoSlider.value = Float(tempo)
        }
    }
    
    @IBAction func stepTempo(sender: UIStepper) {
        tempo = sender.value
    }
    
    @IBAction func slideTempo(sender: UISlider) {
        tempo = Double(sender.value)
    }
    
    @IBAction func toggleClick(sender: UIButton) {
        if metronomeIsOn {
            // stop
            metronomeIsOn = false
            metronomeTimer?.invalidate()
            sender.setTitle("Start", forState: UIControlState.Normal)
        } else {
            // start
            metronomeIsOn = true
            let metronomeTimeInterval:NSTimeInterval = 60.0 / tempo
            metronomeTimer = NSTimer.scheduledTimerWithTimeInterval(metronomeTimeInterval, target: self, selector: Selector("playMetronomeSound"), userInfo: nil, repeats: true)
            metronomeTimer?.fire()
            sender.setTitle("Stop", forState: UIControlState.Normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func playMetronomeSound() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        print("Play metronome sound @ \(currentTime)")
        
        metronomeSoundPlayer.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempo = 60
        
        let metronomeSoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("snizzap", ofType: "wav")!)
        metronomeSoundPlayer = try? AVAudioPlayer(contentsOfURL: metronomeSoundURL)
        metronomeSoundPlayer.prepareToPlay()
    }
}


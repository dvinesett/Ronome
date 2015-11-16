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
    
    
    var metronomeTimer: NSTimer!
    
    var metronomeIsOn = false
    
    var metronomeSoundPlayer: AVAudioPlayer!
    
    var tempo: NSTimeInterval = 20 {
        didSet {
            tempoLabel.text = String(format: "%.0f", tempo)
            tempoStepper.value = Double(tempo)
        }
    }
    
    @IBAction func changeTempo(tempoStepper: UIStepper) {
        tempo = tempoStepper.value
    }
    
    @IBAction func toggleClick(sender: UIButton) {
        if metronomeIsOn {
            metronomeIsOn = false
            
            metronomeTimer?.invalidate()
            tempoStepper.enabled = true
            
            tempoLabel.enabled = true
        } else {
            metronomeIsOn = true
            
            let metronomeTimeInterval:NSTimeInterval = 60.0 / tempo
            metronomeTimer = NSTimer.scheduledTimerWithTimeInterval(metronomeTimeInterval, target: self, selector: Selector("playMetronomeSound"), userInfo: nil, repeats: true)
            metronomeTimer?.fire()
            
            tempoStepper.enabled = false
            
            tempoLabel.resignFirstResponder()
            
            tempoLabel.enabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func playMetronomeSound() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        print("Play metronome sound @ \(currentTime)")
        
        metronomeSoundPlayer.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempo = 240
        
        let metronomeSoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("snizzap", ofType: "wav")!)
        metronomeSoundPlayer = try? AVAudioPlayer(contentsOfURL: metronomeSoundURL)
        metronomeSoundPlayer.prepareToPlay()
        
    }
}


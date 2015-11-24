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
    @IBOutlet weak var tsUpperLabel: UILabel!
    @IBOutlet weak var tsUpperStepper: UIStepper!
    @IBOutlet weak var tsLowerLabel: UILabel!
    @IBOutlet weak var tsLowerStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    
    var metronomeTimer: NSTimer!
    var metronomeIsOn = false
    var metronomeSoundPlayer: AVAudioPlayer!
    var metronomeAccentPlayer: AVAudioPlayer!
    var count: Int = 0 {
        didSet {
            if count == 0 {
                countLabel.text = String(tsUpper)
            } else {
                countLabel.text = String(count)
            }
        }
    }
    var tempo: NSTimeInterval = 60 {
        didSet {
            tempoLabel.text = String(format: "%.0f", tempo)
            tempoStepper.value = Double(tempo)
            tempoSlider.value = Float(tempo)
        }
    }
    var tsUpper: Int = 4 {
        didSet {
            tsUpperLabel.text = String(tsUpper)
            tsUpperStepper.value = Double(tsUpper)
        }
    }
    var tsLower: Int = 4 {
        didSet {
            tsLowerLabel.text = String(tsLower)
            tsLowerStepper.value = Double(tsLower)
        }
    }
    


    @IBAction func stepTempo(sender: UIStepper) {
        tempo = sender.value
    }
    
    @IBAction func stepTsUpper(sender: UIStepper) {
        tsUpper = Int(sender.value)
    }
    
    @IBAction func stepTsLower(sender: UIStepper) {
        tsLower = Int(sender.value)
    }
    
    
    @IBAction func slideTempo(sender: UISlider) {
        tempo = Double(sender.value)
    }
    
    @IBAction func toggleClick(sender: UIButton) {
        if metronomeIsOn {
            // stop
            metronomeIsOn = false
            metronomeTimer?.invalidate()
            count = 0
            sender.setTitle("Start", forState: UIControlState.Normal)
        } else {
            // start
            metronomeIsOn = true
            sender.setTitle("Stop", forState: UIControlState.Normal)
            
            let metronomeTimeInterval:NSTimeInterval = 60.0 / tempo
            metronomeTimer = NSTimer.scheduledTimerWithTimeInterval(metronomeTimeInterval, target: self, selector: Selector("playMetronomeSound"), userInfo: nil, repeats: true)
            
            metronomeTimer?.fire()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func playMetronomeSound() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        print("\(count) Play metronome sound @ \(currentTime)")
        count++
        if count == 1 {
            metronomeAccentPlayer.play()
        } else {
            metronomeSoundPlayer.play()
            if count == tsUpper {
                count = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempo = 120
        tsUpper = 4
        tsLower = 4
        
        let metronomeSoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("snizzap1", ofType: "wav")!)
        let metronomeAccentURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("snizzap2", ofType: "wav")!)

        metronomeSoundPlayer = try? AVAudioPlayer(contentsOfURL: metronomeSoundURL)
        metronomeAccentPlayer = try? AVAudioPlayer(contentsOfURL: metronomeAccentURL)
        
        metronomeSoundPlayer.prepareToPlay()
        metronomeAccentPlayer.prepareToPlay()
    }
}


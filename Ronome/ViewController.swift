//
//  ViewController.swift
//  Ronome
//
//  Created by Vinesett, Dylan on 11/8/15.
//  Copyright © 2015 Vinesett, Dylan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var stepperTempo: UIStepper!
    @IBOutlet weak var labelTempo: UILabel!
    
    var tempo: Int
    

    @IBAction func changeTempo(stepperTempo: UIStepper) {
        tempo = stepperTempo.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidLoad() {
        super.didViewLoad()
        
    }
}


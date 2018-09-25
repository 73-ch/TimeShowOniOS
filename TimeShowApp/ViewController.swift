//
//  ViewController.swift
//  TimeShowApp
//
//  Created by nami on 2018/09/24.
//  Copyright © 2018年 Kousaku Namikawa. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import OpenAL

import AudioKit
import AudioKitUI

let square = AKTable(.square, count: 256)
let triangle = AKTable(.triangle, count: 256)
let sine = AKTable(.sine, count: 256)
let sawtooth = AKTable(.sawtooth, count: 256)


var player: AVAudioPlayer!


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    let url = NSURL(fileURLWithPath: Bundle.main.path(forResource: "003", ofType: "mp3")!)
    
    var oscillator: AKOscillator!
    var oscillator2: AKOscillator!
    
    let waveType = [
        "sine": AKTable(.sine),
        "sawtooth": AKTable(.sawtooth),
        "square": AKTable(.square),
        "triangle": AKTable(.triangle)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2));
    
        Timer.scheduledTimer(timeInterval: 0.00001, target: self, selector: #selector(ViewController.updateTimeText), userInfo: nil, repeats: true)
//        do {
//
//            player = try AVAudioPlayer(contentsOf: url as URL)
//
////            player.delegate = self as! AVAudioPlayerDelegate
//
//            player.play()
//        } catch {
//            print("AVAudioPlayer error")
//        }
        
        
        let table1 = AKTable(.sine)
//        table1.phase = Float(Date().timeIntervalSince1970)
        oscillator = AKOscillator(waveform: table1)
        
        let table2 = AKTable(.sine)
//        table2.phase = Float(M_PI_2)
        table1.reverse()
        oscillator2 = AKOscillator(waveform: table1)
        
        
        let mixer = AKMixer(oscillator, oscillator2)
        AudioKit.output = mixer
        try? AudioKit.start()
//        oscillator.start()
//        oscillator2.start()
        
    }
    
    @IBAction func button(_ sender: Any) {
        
    }
    
    var keep = 0
    
    @objc func updateTimeText() {
        let date = Date().timeIntervalSince1970
        if (Int(date) > keep && Int(date) % 1 == 0) {
//            player.play()
            keep = Int(date)
        }
        
        if (Int(date) % 100 == 0) {
//            oscillator.start();
            oscillator2.start();
        }
        
        label.text = String(date)
        
    }
    
}


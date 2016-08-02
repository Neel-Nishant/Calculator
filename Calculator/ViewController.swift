//
//  ViewController.swift
//  Retro Calculator 2
//
//  Created by Neel Nishant on 02/08/16.
//  Copyright © 2016 Neel Nishant. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation : String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        
        case Empty = ""
    }
    
    @IBOutlet weak var outputlbl : UILabel!
    
    var btnSound : AVAudioPlayer!
    
    var runningNumber = ""
    var lstr = ""
    var rstr = ""
    var currOp : Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    @IBAction func onNumberPressed(btn : UIButton!)
    {
        playSound()
        runningNumber += "\(btn.tag)"
        outputlbl.text = runningNumber
    }
    
    @IBAction func onPressingDivide(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onPressingMultiply(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onPressingSubtract(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onPressingAdd(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onPressingEqual(sender: AnyObject) {
        processOperation(currOp)
    }
    
    @IBAction func onPressingClear(sender: AnyObject) {
        playSound()
        runningNumber = ""
        lstr = ""
        rstr = ""
        currOp = Operation.Empty
        result = ""
        outputlbl.text = "0"
        
    }
    func processOperation(op : Operation)
    {
        playSound()
        
        if currOp != Operation.Empty
        {
            if runningNumber != ""{
                rstr = runningNumber
                runningNumber = ""
                
                if currOp == Operation.Multiply{
                    result = "\(Double(lstr)! * Double(rstr)!)"
                }
                else if currOp == Operation.Divide{
                    result = "\(Double(lstr)! / Double(rstr)!)"
                }
                else if currOp == Operation.Subtract{
                    result = "\(Double(lstr)! - Double(rstr)!)"
                }
                else if currOp == Operation.Add{
                    result = "\(Double(lstr)! + Double(rstr)!)"
                }
                
                lstr = result
                outputlbl.text = result
                
            }
            
            
            currOp = op
            
        }
        else{
            lstr = runningNumber
            runningNumber = ""
            currOp = op
        }
    }
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    
}


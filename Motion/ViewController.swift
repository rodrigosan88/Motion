//
//  ViewController.swift
//  Motion
//
//  Created by iOS on 02/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit
import CoreMotion

extension Double{
    
    var grau: Double{
        return self * 180 / 3.14159
    }
    
    func format(f:String) ->String{
        return String(format: "%\(f)f", self)
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var tfPitch: UITextField!
    @IBOutlet weak var tfYaw: UITextField!
    @IBOutlet weak var tfRoll: UITextField!
    
    let motionManager : CMMotionManager = CMMotionManager()
    var timer: NSTimer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.deviceMotionAvailable{
            monitora(2.0)
            
        } else {
            print("Não possui sensor movimento")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func monitora(intervalo: Double){
        motionManager.deviceMotionUpdateInterval = intervalo
        motionManager.startDeviceMotionUpdates()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2*intervalo, target: self, selector: "handler", userInfo: nil, repeats: true)
        
    }
    
    func handler(time: NSTimer!){
        
        if let md = motionManager.deviceMotion{
            tfYaw.text = md.attitude.yaw.grau.format("0.2")
            tfRoll.text = md.attitude.roll.grau.format("0.2")
            tfPitch.text = md.attitude.pitch.grau.format("0.2")
        }
        
    }


}


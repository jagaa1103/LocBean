//
//  ViewController.swift
//  LocBean
//
//  Created by Enkhjargal Gansukh on 9/2/15.
//  Copyright (c) 2015 Enkhjargal Gansukh. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("ViewController is inited")
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var labelProximity: UILabel!
    @IBOutlet weak var labelMinor: UILabel!
    @IBOutlet weak var labelMajor: UILabel!
    @IBOutlet weak var labelRSSI: UILabel!
    @IBOutlet weak var labelUUID: UILabel!
    @IBAction func startClicked(sender: AnyObject) {
        BeaconService.sharedInstance.startService()
    }
    @IBAction func stopClicked(sender: AnyObject) {
        BeaconService.sharedInstance.stopService()
    }
}


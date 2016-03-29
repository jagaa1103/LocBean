//
//  beaconService.swift
//  LocBean
//
//  Created by Enkhjargal Gansukh on 3/29/16.
//  Copyright © 2016 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import CoreLocation

class beaconService: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var viewCtrl: ViewController?
    
    class var sharedInstance: beaconService {
        struct Static {
            static var instance: beaconService?
        }
        if (Static.instance == nil) {
            Static.instance = beaconService()
        }
        return Static.instance!
    }
    
    func startService(){
        let uuidString = "e2c56db5-dffb-48d2-b060-d0f5a71096e0"
        let beaconIdentifier = "us.iBeaconModules"
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier: beaconIdentifier)
        
        locationManager = CLLocationManager()
        
        if(locationManager!.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization))) {
            locationManager!.requestAlwaysAuthorization()
        }
        
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("you are in Beacon Region")
    }
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("you exited from Beacon Region")
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        for beacon:CLBeacon in beacons {
        	print(beacon)
        }
        viewCtrl!.beacons = beacons
        viewCtrl!.tableView?.reloadData()
    }
    
    
    func setView(view:ViewController){
        viewCtrl = view
    }
}

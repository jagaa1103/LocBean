//
//  BeaconService.swift
//  LocBean
//
//  Created by Enkhjargal Gansukh on 9/2/15.
//  Copyright (c) 2015 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class BeaconService: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "01122334-4556-6778-899a-abbccddeeff0"), identifier: "ibeacon")
    var currentView: ViewController?
    
    class var sharedInstance: BeaconService {
        struct Static {
            static var instance: BeaconService?
        }
        if (Static.instance == nil) {
            Static.instance = BeaconService()
        }
        return Static.instance!
    }
    
    func startService(view: ViewController) {
        self.currentView = view
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
        locationManager.startMonitoringForRegion(region)
        locationManager.startMonitoringVisits()
        
    }
    
    func stopService(){
        locationManager.stopMonitoringForRegion(region)
        locationManager.stopMonitoringVisits()
        locationManager.stopRangingBeaconsInRegion(region)
        self.currentView?.labelUUID.text = ""
        self.currentView?.labelRSSI.text = ""
        self.currentView?.labelMajor.text = ""
        self.currentView?.labelMinor.text = ""
        self.currentView?.labelProximity.text = ""
    }
    
    
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        println("Beacon visits: \(visit)")
    }
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        println("You are in beacon region")
        sendNotification()
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("You entered in Beacon Area")
        sendNotification()
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("You are exited")
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as! CLBeacon
            self.currentView?.labelUUID.text = "\(closestBeacon.proximityUUID.UUIDString)"
            self.currentView?.labelRSSI.text = "\(closestBeacon.rssi)"
            self.currentView?.labelMajor.text = "\(closestBeacon.major)"
            self.currentView?.labelMinor.text = "\(closestBeacon.minor)"
            self.currentView?.labelProximity.text = "\(closestBeacon.proximity.rawValue)"
        }
    }
    
    func sendNotification(){
        println("Sending Notif ......................")
        var localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
        localNotification.alertBody = "new Blog Posted at iOScreator.com"
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
}
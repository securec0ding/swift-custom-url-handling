//
//  CLLocationManager.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock CLLocationManager
// 

public typealias CLLocationAccuracy = Double

public let kCLLocationAccuracyBestForNavigation: CLLocationAccuracy = -2
public let kCLLocationAccuracyBest: CLLocationAccuracy = -1
public let kCLLocationAccuracyNearestTenMeters: CLLocationAccuracy = 10
public let kCLLocationAccuracyHundredMeters: CLLocationAccuracy = 100
public let kCLLocationAccuracyKilometer: CLLocationAccuracy = 1000
public let kCLLocationAccuracyThreeKilometers: CLLocationAccuracy = 3000

protocol CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
}

extension CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { }
}

class CLLocationManager {
    var delegate: CLLocationManagerDelegate?
    var desiredAccuracy: CLLocationAccuracy {
        didSet {
            delegate?.locationManager(self, didUpdateLocations: [CLLocation(latitude:40.7484, longitude:73.9857)])
        }
    }

    init() {
        self.desiredAccuracy = kCLLocationAccuracyBest
    }
}
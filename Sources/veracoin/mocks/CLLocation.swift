//
//  CLLocation.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock CLLocation
//

public typealias CLLocationDegrees = Double

public struct CLLocationCoordinate2D {

    public var latitude: CLLocationDegrees

    public var longitude: CLLocationDegrees

    public init() {
        latitude = 999
        longitude = 999
    }

    public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public class CLLocation {
    var coordinate: CLLocationCoordinate2D

    public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        coordinate = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
    }
}
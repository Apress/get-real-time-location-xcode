//
//  ViewController.swift
//  RealTimeLocation
//
//  Created by Tihomir RAdeff on 11.07.21.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locateButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    private var locationManager: CLLocationManager?
    
    private var centerMap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //round corners
        locateButton.layer.cornerRadius = 10
    }

    @IBAction func locateButtonAction(_ sender: Any) {
        locationLabel.text = "Locating..."
        locateMe()
    }
    
    func locateMe() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    // MARK: - Location Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //display location
            locationLabel.text = "Lat: \(location.coordinate.latitude)\nLon: \(location.coordinate.longitude)"
            
            //show on map
            let locationOnMap = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            //center map on the first location
            if !centerMap {
                mapView.setRegion(MKCoordinateRegion.init(center: locationOnMap, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: false)
                centerMap = true
            }
            
            //remove all previous points
            mapView.removeAnnotations(mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationOnMap
            mapView.addAnnotation(annotation)
        }
    }
}


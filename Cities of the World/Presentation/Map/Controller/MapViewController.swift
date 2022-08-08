//
//  MapViewController.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
	
	static let identifier = "MapStoryboard"
	@IBOutlet weak var mapView: MKMapView!
	
	let locationManager = CLLocationManager()
	
	var longitude: Double?
	var latitude: Double?
	var cityName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
		mapConfiguration()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func mapConfiguration() {
		if let latitude = self.latitude, let longitude = self.longitude, let cityName = self.cityName {
			let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
			let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
			let pin = MKPointAnnotation()
			pin.coordinate = location
			pin.title = cityName
			mapView.addAnnotation(pin)
			let zoomOut = MKCoordinateRegion(center: location, span: span)
			let region = mapView.regionThatFits(zoomOut)
			mapView.setRegion(region, animated: true)
			
		}
		
	}

}


extension MapViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		   if status == .authorizedWhenInUse {
			   locationManager.requestLocation()
		   }
	   }

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
				let region = MKCoordinateRegion(center: location.coordinate, span: span)
				mapView.setRegion(region, animated: true)
			}
	   }

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("error:: \(error.localizedDescription)")
    }
}

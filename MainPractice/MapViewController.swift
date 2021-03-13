//
//  MapViewController.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/8/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private var mapView:MKMapView = MKMapView()
    private var geocoder = CLGeocoder()
    private var placemark:CLPlacemark?
    private var lat:Double?
    private var lon:Double?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Maps"
        setupMapView()
    

        // Do any additional setup after loading the view.
    }
    
    func setupMapView() {
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
    
        mapView.center = view.center
    
        self.getCoordinates(address: "68 Mercer Ave Hartsdale, NY 10530") { location in
            guard let location = location else { return }
            let home = MKPointAnnotation()
            home.title = "Me"
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("lat:\(lat) lon:\(lon)")
            home.coordinate =  CLLocationCoordinate2D(latitude: 41.0171223, longitude: -73.7911415)
            self.mapView.addAnnotation(home)
            self.view.addSubview(self.mapView)
            self.mapView.translatesAutoresizingMaskIntoConstraints = false
            self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
            self.mapView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
            self.mapView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.mapView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }

    }

    private func getCoordinates(address:String, completion: @escaping(CLLocation?) -> Void) {
        
        let geoCoder = CLGeocoder()
      
        geoCoder.geocodeAddressString(address) { placemarks, error in
            
            guard error == nil else {
                           print("*** Error in \(#function): \(error!.localizedDescription)")
                           completion(nil)
                           return
                       }
                       
            guard let placemark = placemarks?[0] else {
                   print("*** Error in \(#function): placemark is nil")
                   completion(nil)
                   return
            }
            
            guard let location = placemark.location else {
                     print("*** Error in \(#function): placemark is nil")
                     completion(nil)
                     return
                 }
            print("country: \(placemark.country)")
            completion(location)
        
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

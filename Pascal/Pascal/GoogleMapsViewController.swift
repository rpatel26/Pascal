//
//  GoogleMapsViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/22/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleMaps
import Darwin

class GoogleMapsViewController: UIViewController {

    var ref: DatabaseReference!
    var myMap: GMSMapView!
    var markers = [GMSMarker]()
    var currentLatitude: Double!
    var currentLongitude: Double!
    var currentLocation: CLLocationCoordinate2D!
    var currentMarker: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        currentLatitude = 32.869131
        currentLongitude = -117.217818
        
        GMSServices.provideAPIKey("AIzaSyAXu0OYZD9_R0nyfVLCRSmGbFKcd6z9H_U")
        let camera = GMSCameraPosition.camera(withLatitude: currentLatitude, longitude:  currentLongitude, zoom: 1)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        myMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = myMap
        myMap.settings.compassButton = true
        myMap.settings.myLocationButton = true
        myMap.isMyLocationEnabled = true
        
        myMap.addObserver(self, forKeyPath: "myLocation", options: .new, context: nil)
        
        currentLocation = CLLocationCoordinate2DMake(currentLatitude, currentLongitude)
        currentMarker = GMSMarker(position: currentLocation)
        currentMarker.title = "Costa Verde"
        currentMarker.map = myMap
        currentMarker.icon = GMSMarker.markerImage(with: UIColor.purple)
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

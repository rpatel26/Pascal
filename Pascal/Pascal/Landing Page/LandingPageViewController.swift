//
//  LandingPageViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/27/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleMaps
import Darwin

class LandingPageViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var menu_bar: UIView!
    @IBOutlet weak var menu_bar_label: UILabel!
    @IBOutlet weak var how_to_rent_button: UIButton!
    @IBOutlet weak var hamburger_menu: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()

    @IBOutlet weak var rent_button: UIButton!
    var ref: DatabaseReference!
    var myMap: GMSMapView!
    var markers = [GMSMarker]()
    var currentLatitude: Double!
    var currentLongitude: Double!
    var currentLocation: CLLocationCoordinate2D!
    var currentMarker: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if (CLLocationManager.locationServicesEnabled())
        {
//            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }

        ref = Database.database().reference()
        
        currentLatitude = 32.881234
        currentLongitude = -117.235489
        
        GMSServices.provideAPIKey("AIzaSyAXu0OYZD9_R0nyfVLCRSmGbFKcd6z9H_U")
        let camera = GMSCameraPosition.camera(withLatitude: currentLatitude, longitude:  currentLongitude, zoom: 15)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        myMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = myMap
        myMap.settings.compassButton = true
        myMap.settings.myLocationButton = true
        myMap.isMyLocationEnabled = true
        
        myMap.addObserver(self, forKeyPath: "myLocation", options: .new, context: nil)
        
        currentLocation = CLLocationCoordinate2DMake(currentLatitude, currentLongitude)
        currentMarker = GMSMarker(position: currentLocation)
        currentMarker.title = "My Location"
        currentMarker.map = myMap
        currentMarker.icon = GMSMarker.markerImage(with: UIColor.red)
        currentMarker.icon = UIImage(named: "pascal")
        
        // Read from database in realtime
        ref.child("gps").observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            for i in 0..<self.markers.count{
                self.markers[i].map = nil
            }
            
            self.markers.removeAll()
            
            let latitude = value!["latitude"] ?? 0.0
            let longitude = value!["longitude"] ?? 0.0
            
            let markerLocation = CLLocationCoordinate2DMake(latitude as! CLLocationDegrees, longitude as! CLLocationDegrees)
            let marker = GMSMarker(position: markerLocation)
            marker.map = self.myMap
            marker.icon = GMSMarker.markerImage(with: UIColor.purple)
            
            self.markers.append(marker)

        }) { (err) in
            print("error reading from database.......error = ", err)
        }
        
        customizeRentButton()
        customizeMenuBar()
        customizeHowToRentButton()
        customize_hamburger_menu_button()
        
        myMap.addSubview(rent_button)
        myMap.addSubview(menu_bar)
        myMap.addSubview(how_to_rent_button)
        myMap.addSubview(hamburger_menu)
    }

 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
        /* you can use these values*/
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        let alert = UIAlertController(title: "Success", message: "Latitude: \(lat); Logitude: \(long)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func customizeRentButton(){
        rent_button.layer.backgroundColor = UIColor.init(red: 140/255, green: 56/255, blue: 182/255, alpha: 1).cgColor
        rent_button.layer.cornerRadius = rent_button.frame.height / 2
        
    }
    
    private func customizeMenuBar(){
        menu_bar.backgroundColor = UIColor.white
        menu_bar_label.textColor = UIColor.black
    }
    
    private func customizeHowToRentButton(){
        how_to_rent_button.layer.backgroundColor = UIColor.init(red: 140/255, green: 56/255, blue: 182/255, alpha: 1).cgColor
        how_to_rent_button.setTitleColor(UIColor.white, for: .normal)
    }
    
    private func customize_hamburger_menu_button(){
//        hamburger_menu.setBackgroundImage(UIImage(named: "hamburger_menu_button"), for: .normal)
    }
    
    @IBAction func menu_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "menu_bar_view")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func rent_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Renting", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "rent_a_pascal")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func how_to_rent_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HowToRent", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "find_and_unlock")
        self.present(viewController, animated: false, completion: nil)
    }
    
}

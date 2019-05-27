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

class LandingPageViewController: UIViewController {

    @IBOutlet weak var menu_bar: UIView!
    @IBOutlet weak var menu_bar_label: UILabel!
    @IBOutlet weak var how_to_rent_button: UIButton!
    @IBOutlet weak var hamburger_menu: UIButton!
    
    
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
        
        ref = Database.database().reference()
        
        currentLatitude = 32.869131
        currentLongitude = -117.217818
        
        GMSServices.provideAPIKey("AIzaSyAXu0OYZD9_R0nyfVLCRSmGbFKcd6z9H_U")
        let camera = GMSCameraPosition.camera(withLatitude: currentLatitude, longitude:  currentLongitude, zoom: 10)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        myMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = myMap
        myMap.settings.compassButton = true
        myMap.settings.myLocationButton = true
        myMap.isMyLocationEnabled = true
        
        myMap.addObserver(self, forKeyPath: "myLocation", options: .new, context: nil)
        
        currentLocation = CLLocationCoordinate2DMake(currentLatitude, currentLongitude)
        currentMarker = GMSMarker(position: currentLocation)
        currentMarker.title = "Random Location"
        currentMarker.map = myMap
        currentMarker.icon = GMSMarker.markerImage(with: UIColor.purple)
        
        customizeRentButton()
        customizeMenuBar()
        customizeHowToRentButton()
        customize_hamburger_menu_button()
        
        myMap.addSubview(rent_button)
        myMap.addSubview(menu_bar)
        myMap.addSubview(how_to_rent_button)
        myMap.addSubview(hamburger_menu)
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
    
}

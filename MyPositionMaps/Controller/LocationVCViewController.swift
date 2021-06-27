//
//  LocationVCViewController.swift
//  MyPositionMaps
//
//  Created by LARHCHIM ISMAIL on 6/14/21.
//  Copyright © 2021 LARHCHIM ISMAIL. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class LocationVCViewController: UIViewController,CLLocationManagerDelegate{

    @IBOutlet weak var lblLatitude: UILabel!
    
    
    @IBOutlet weak var lblLongitude: UILabel!
    
    
    @IBOutlet weak var lblAltitude: UILabel!
    
    @IBOutlet weak var maps: MKMapView!
    
    
    @IBOutlet weak var lblSpeed: UILabel!
    
    @IBOutlet weak var lblDistance: UILabel!
    
    
    @IBOutlet weak var RafraichirAction: UIButton!
    
    var manager = CLLocationManager()
    var ptsdepart : CLLocation!
    @IBAction func Rafraichir(_ sender: Any) {
        lblDistance.text = "0.0"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        ptsdepart = nil
        
        manager.startUpdatingLocation()

        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if ptsdepart == nil {
            ptsdepart = locations[0]
        }
        let ptsActuel = locations[0]
        lblLatitude.text = String(format: "%.2f", locations[0].coordinate.latitude)
        lblLongitude.text = String(format: "%.2f",locations[0].coordinate.longitude)
        lblDistance.text = String(format: "%.2f",ptsActuel.distance(from: ptsdepart))
        lblAltitude.text = String(format: "%.2f",locations[0].altitude)
        lblSpeed.text = String(format: "%.2f",locations[0].speed)
        
        let latitude : CLLocationDegrees = locations[0].coordinate.latitude
        let longitude : CLLocationDegrees = locations[0].coordinate.longitude
        
        let latDelta : CLLocationDegrees = 0.01
        let lonDelta : CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        
        let msg = MKPointAnnotation()
        msg.coordinate = locations[0].coordinate
        msg.title = "Maison"
        msg.subtitle = "User Location"
        maps.addAnnotation(msg)
        maps.setRegion(region, animated: true)
        maps.showsUserLocation = true
        
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

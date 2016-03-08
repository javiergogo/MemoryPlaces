//
//  ViewController.swift
//  17MemorialPlaces
//
//  Created by Javier Gomez on 12/1/15.
//  Copyright © 2015 Javier Gomez. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!

    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "accion:")
        
        uilpgr.minimumPressDuration = 1.3
        
        map.addGestureRecognizer(uilpgr)
    
    }
    
    func accion(gestureRecognizer:UIGestureRecognizer)
    {
        //no dos veces seleccion
        if gestureRecognizer.state == UIGestureRecognizerState.Began
        {
            var touchPoint = gestureRecognizer.locationInView(self.map)
            
            var newCoordinate = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                var titulo = ""
                if error == nil
                {
                    if let p = placemarks?[0]
                    {
                        var subDomicilio:String = ""
                        var Domicilio:String = ""
                        
                        if p.subThoroughfare != nil
                        {
                            subDomicilio = p.subThoroughfare!
                        }
                        
                        if p.thoroughfare != nil
                        {
                            Domicilio = p.thoroughfare!
                        }
                        
                        titulo = "\(subDomicilio) \(Domicilio)"
                        
                    }
                }
                
                if titulo == ""
                {
                    titulo = "Agregado \(NSDate())"
                }
                
                lugares.append(["name":titulo,"lat":"\(newCoordinate.latitude)","long":"\(newCoordinate.longitude)"])
            
                var annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                annotation.title = titulo
                
                print(annotation.title)
                print(annotation.coordinate)
                
                print(lugares)
                
                self.map.addAnnotation(annotation)
                
            })
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var userLocation:CLLocation = locations[0]
        
        var latitud = userLocation.coordinate.latitude
        
        var longitud = userLocation.coordinate.longitude
        
        var coordinate = CLLocationCoordinate2DMake(latitud, longitud)
        
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        self.map.setRegion(region, animated: true)
    
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


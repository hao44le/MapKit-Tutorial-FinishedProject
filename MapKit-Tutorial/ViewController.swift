//
//  ViewController.swift
//  MapKit-Tutorial
//
//  Created by Gelei Chen on 15/8/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    typealias coordinate = (latitude:Double, longitude: Double)
    
    let names:[String:coordinate] = ["newyork":(40.7128,-74.0059),"seattle":(47.6062,-122.3321),"sf":(37.7786,-122.3893),"texas":(31.9686,-99.9018)]
    
    let locateManage = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        setupLocationManager()
        addAnnotations()
        zoomToRegion()
    }
    
    // MARK:- Setup CLLocationManager
    
    func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locateManage.requestWhenInUseAuthorization()
        }

        locateManage.delegate = self
    }
    
    // MARK:- Add annotations
    
    func addAnnotations() {
        for name in names {
            let coordinate = CLLocationCoordinate2DMake(name.value.latitude, name.value.longitude)
            let annotation = Annotation(coordinate: coordinate,title:name.key)
            mapView.addAnnotation(annotation)
        }
    }
    
    // MARK:- ZoomToRegion
    
    func zoomToRegion() {
        let zoomRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 38.8833, longitude: -97.0167), 14000000, 14000000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let name = sender as! String
            let destinationViewController = segue.destination as! DetailViewController
            destinationViewController.titleText = name
            destinationViewController.annotationImage = UIImage(named: name)
        }
        
    }
    
    @IBAction func findMyLocation(_ sender: UIButton) {
        locateManage.startUpdatingLocation()
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLoca = locations.last {
            let newCoordinate = newLoca.coordinate
            mapView.centerCoordinate = newCoordinate
            manager.stopUpdatingLocation()//stop updating.save power
        }
    }
}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: Annotation.classForCoder()){
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "Annotation")
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Annotation")
                pinView?.canShowCallout = true
                pinView?.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
                pinView?.rightCalloutAccessoryView!.tintColor = UIColor.black
                
                
            } else {
                pinView?.annotation = annotation
            }
            let imageView = UIImageView(image: UIImage(named: ""))
            
            
            pinView!.leftCalloutAccessoryView = imageView
            
            pinView?.image = UIImage(named: "mapAnnotation")
            return pinView
        }else{
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! Annotation
        performSegue(withIdentifier: "toDetail", sender: annotation.title)
        
    }
}


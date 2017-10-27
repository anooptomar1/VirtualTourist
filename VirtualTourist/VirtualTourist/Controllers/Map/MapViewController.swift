//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 26/10/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    enum PinIdentifier: String {
        case pin
    }

    @IBOutlet weak var mapView: MKMapView!
    
    var canAddPin: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if MapHelper.didGetFirstCoodinates {
            let span: MKCoordinateSpan = MKCoordinateSpanMake(MapHelper.latitudeDelta, MapHelper.longitudeDelta)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(MapHelper.latitude, MapHelper.longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.mapView.setRegion(region, animated: true)
        }
        
        FlickrSearchClient.getFlickrImagesFromLocation(latitude: 37.33182, longitude: -122.03118) { (success) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK : - MKMapView Delegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: PinIdentifier.pin.rawValue) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: PinIdentifier.pin.rawValue)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .blue
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "showPhotosAlbum", sender: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        MapHelper.didGetFirstCoodinates = true
        
        let newRegion = self.mapView.region
        MapHelper.latitude = Double(newRegion.center.latitude)
        MapHelper.longitude = Double(newRegion.center.longitude)
        MapHelper.latitudeDelta = Double(newRegion.span.latitudeDelta)
        MapHelper.longitudeDelta = Double(newRegion.span.longitudeDelta)
    }
    
}

// MARK: - UIGesture Recognizer

extension MapViewController {
    
    func addGesture() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(triggerLongpressOn(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func triggerLongpressOn(_ gestureRecognizer: UIGestureRecognizer) {
        
        if canAddPin {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            annotation.title = "\(newCoordinates.latitude) \(newCoordinates.longitude)"
            mapView.addAnnotation(annotation)
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            canAddPin = false
        } else if gestureRecognizer.state == UIGestureRecognizerState.ended {
            canAddPin = true
        }
        
    }
    
}

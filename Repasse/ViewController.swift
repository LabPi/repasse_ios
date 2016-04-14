//
//  ViewController.swift
//  Repasse
//
//  Created by Ricardo Gayer on 4/10/16.
//  Copyright © 2016 Ricardo Gayer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation
import MBProgressHUD

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var Mapa: MKMapView!
    var proponentes:[AggregateProponente] = [AggregateProponente]()
    var arrRes = [[String:AnyObject]]()
    
    var locationManager: CLLocationManager!
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Recuperação da localização do usuário
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        Mapa.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateMapa() {
        Mapa.removeAnnotations(Mapa.annotations)
        Mapa.addAnnotations(self.proponentes)
        let center = CLLocationCoordinate2D(latitude:self.location.coordinate.latitude, longitude:self.location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.Mapa.setRegion(region,animated:true);
    }
    
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == annotationView.rightCalloutAccessoryView {
            let proponente:AggregateProponente = annotationView.annotation as! AggregateProponente
            proponenteSelecionado = proponente
            performSegueWithIdentifier("repasse", sender: nil)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?  {
        if let annotation = annotation as? AggregateProponente {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                // view.calloutOffset = CGPoint(x: -5, y: 5)
                let btn = UIButton(type: .DetailDisclosure)
                view.rightCalloutAccessoryView = btn
            }
            return view
        }
        return nil
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.location = locations[0]
        
        locationManager.stopUpdatingLocation()
        
        recuperaProponentes()
        
    }
    
    func recuperaProponentes() {
        
        let spiningAlert = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let parameters = ["latitude": self.location.coordinate.latitude,"longitude":self.location.coordinate.longitude]
        
        Alamofire.request(.GET, "http://repasse.cfapps.io/repasse", parameters: parameters)
            .responseJSON { response in
                let swiftyJsonVar = JSON(response.result.value!)
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                for a in self.arrRes {
                    let proponente:AggregateProponente = AggregateProponente(
                        id_proponente:a["id_proponente"] as! String,
                        proponente:a["proponente"] as! String,
                        coordinate:CLLocationCoordinate2D(latitude: a["latitude"] as! Double, longitude: a["longitude"] as! Double),
                        administracao:a["administracao"] as! String,
                        total:a["total"] as! Double)
                    self.proponentes.append(proponente)
                }
                
                self.updateMapa()
                spiningAlert.hide(true)
        }
        
    }

}









//
//  VCLogin.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit
import Foundation
import CFNetwork
import CoreLocation

class VCLogin: UIViewController, CLLocationManagerDelegate {
    
    // DECLARACIO BOTONS
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var txtUserOrMail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    let locationManager = CLLocationManager()
    
    // DECLARACIO VARIABLES
    var latitud = 37.33233141
    var longitud = -122.0312186
    
    // METODES PER LOGALITZACIO
   func findMyLocation() {
        println("entra findMyLocation")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        var latitud:CLLocationDegrees = locationManager.location.coordinate.latitude
        var longitud:CLLocationDegrees = locationManager.location.coordinate.longitude
        println(latitud)
        println(longitud)
        self.longitud = longitud
        self.latitud = latitud
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            println(locality)
            println(postalCode)
            println(administrativeArea)
            println(country)
            
            //Calcular distancia entre jo i badalona (41.446988300000000000, 2.245032499999979300) lat , long
            let distance = locationManager.location.distanceFromLocation(CLLocation.self(latitude: 41.446988300000000000 , longitude: 2.245032499999979300))
            println(distance)
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
        
    }

    // METODES CONTROLLER-VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        application.myController.connect()
        findMyLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // METODES BOTONS
    @IBAction func loginTapped(sender: UIButton) {
        // Checkejar els camps, si son correctes enviar al servidor i espera resposta
        
        let validarMail: Bool = application.isValidEmail(txtUserOrMail.text)
        let validarPassword: Bool = application.isValidPassword(txtPassword.text)
        let validarUsuari: Bool = application.validateUserName(txtUserOrMail.text)
        
        println("Mail: " + validarMail.description)
        println("Password: " + validarPassword.description)
        println("Usuari: " + validarUsuari.description)
        println("-----------------")
        
        if (validarUsuari && validarPassword && !txtUserOrMail.text.isEmpty && !txtPassword.text.isEmpty){
            println("Usuari correcte")
            application.myController.sendMessage(txtUserOrMail.text + "," + txtPassword.text + "," + latitud.description + "," + longitud.description)
            // Si el server diu OK pasem a menu
            if (application.myController.readMessage() == SUCCES){
                self.performSegueWithIdentifier("goto_menu", sender: self)
            }
        }else{
            if (validarMail == true && validarPassword == true && !txtUserOrMail.text.isEmpty && !txtPassword.text.isEmpty){
                println("Mail correcte")
                application.myController.sendMessage(txtUserOrMail.text + "," + txtPassword.text + "," + latitud.description + "," + longitud.description)
                // Si el server diu OK pasem a menu
                if (application.myController.readMessage() == SUCCES){
                    self.performSegueWithIdentifier("goto_menu", sender: self)
                }
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    @IBAction func registerTapped(sender: UIButton) {
        //Enviar al servidor que volem registrarnos.
        if (true){
            application.myController.sendMessage(REGISTER + "," + REGISTER)
            self.performSegueWithIdentifier("goto_register", sender: self)
        }
        
    }
    
}

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

class VCLogin: UIViewController, CLLocationManagerDelegate, UIAlertViewDelegate {

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
    @IBAction func entraPassword(sender: UITextField) {
        println("Password")
        txtPassword.background = UIImage(named: "focus.png")
        txtUserOrMail.background = UIImage(named: "no_focus.png")
    }
    @IBAction func entraUserName(sender: UITextField) {
        println("UserName")
        txtPassword.background = UIImage(named: "no_focus.png")
        txtUserOrMail.background = UIImage(named: "focus.png")
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
        
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        

        // POSAR IMATGE FONS EDIT TEXT
        txtPassword.background = UIImage(named: "no_focus.png")
        txtUserOrMail.background = UIImage(named: "no_focus.png")
        txtUserOrMail.layer.cornerRadius = 14
        txtPassword.layer.cornerRadius = 14
        let attributesDictionary = [NSForegroundColorAttributeName: UIColor.grayColor()]
        txtUserOrMail.attributedPlaceholder = NSAttributedString(string: "User or Email", attributes: attributesDictionary)
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributesDictionary)

        // ASSIGNAR TIPUS DE LLETRA
        /*btn_register.titleLabel?.font = UIFont(name: "Augusta.ttf", size: 50)
        btn_login.titleLabel?.font = UIFont(name: "Augusta.ttf", size: 50)*/
        
        if(application.comprovarConexion()){
            application.myController.connect()
            findMyLocation()
        }else{
            var alert : UIAlertView = UIAlertView(title: "No connection!", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Settings")
            alert.show()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        println(buttonIndex.description)
        if(buttonIndex == 1){
            self.settings()
        }
    }
    
    func settings(){
        UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
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
            application.myController.sendMessage(REGISTER + "," + REGISTER + "," + REGISTER + "," + REGISTER )
            if (application.myController.readMessage() == SUCCES){
                self.performSegueWithIdentifier("goto_register", sender: self)
            }
        }
        
    }
    
}

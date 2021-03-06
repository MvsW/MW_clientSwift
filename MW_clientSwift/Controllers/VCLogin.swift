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
    var connected = false
    
    // DECLARACIO VARIABLES
    var latitude = 37.33233141
    var longitude = -122.0312186
    
    
    // METODES PER LOGALITZACIO
    func findMyLocation() {
        println("Inside of VCLogin > findMyLocation")
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
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    @IBAction func fieldSelected(sender: UITextField) {
        
        switch sender.tag {
        case 0:
            txtPassword.background = UIImage(named: "no_focus.png")
            txtUserOrMail.background = UIImage(named: "focus.png")
            break
            
        case 1:
            txtPassword.background = UIImage(named: "focus.png")
            txtUserOrMail.background = UIImage(named: "no_focus.png")
            break
            
        default:
            println("Tag: \(sender.tag) from textfield received is not")
            break
        }
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        
        var latitude:CLLocationDegrees = locationManager.location.coordinate.latitude
        var longitude:CLLocationDegrees = locationManager.location.coordinate.longitude
        
        println(latitude)
        println(longitude)
        
        self.longitude = longitude
        self.latitude = latitude
        
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
    
    
    // CONTROLLER VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the images
        setupControllerImages();
        
        // Trying to get NSUserDefaults
        if (application.dataSessionStateIsNotNil()) {
            
            txtUserOrMail.text = NSDefaultUsernameOrEmail
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        application.precarregarMusica("main theme")
        application.startMusic()
//        application.myController.startLoading(self.view, text: "Loading...", size2: 12.5,viewController: self,areInBattle: false)
        if (application.checkConnection()){
            application.myController.connect()
            findMyLocation()
            connected = true
        } else {
            application.noConnectionAlert(self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // BUTTONS METHODS
    @IBAction func loginTapped(sender: UIButton) {
        
        if (connected) {
            
            let validateMail: Bool = application.isValidEmail(txtUserOrMail.text)
            let validatePassword: Bool = application.isValidPassword(txtPassword.text)
            let validateUser: Bool = application.validateUserName(txtUserOrMail.text)
            var readyForSend: Bool = false
            
            println("Mail: " + validateMail.description)
            println("Password: " + validatePassword.description)
            println("Usuari: " + validateUser.description)
            println("-----------------")
            
            // Checks if the two fields are empty or not
            if (!requiredFieldsAreEmpty()) {
                var userOrMail = txtUserOrMail.text
                
                // First check if is an email or not. And check in all case the criterias
                if (userOrMail.rangeOfString("@") == nil && validateUser && validatePassword) {
                    println("Fields filled. Username and password form valid")
                    readyForSend = true
                    
                } else if (validateMail && validatePassword) {
                    println("Fields filled. Mail and password form are not valids")
                    readyForSend = true
                    
                } else {
                    println("The fields are not empty but the user has not been found")
                }
                
                if (readyForSend) {
                    // Sending user data to the server
                    application.myController.sendMessage(txtUserOrMail.text + SEPARATOR + txtPassword.text + SEPARATOR + latitude.description + SEPARATOR + longitude.description)
                    
                    // Catching response
                    var serverResponse = application.myController.readMessage()
                    var serverResponseSplit = serverResponse.componentsSeparatedByString(SEPARATOR)
                    
                    if (serverResponseSplit[0] as! String == SUCCES) {
                        
                        // Everything is correct. Saving data session into the NSUserDefaults and GO to menu screen
                        application.saveDataSession(txtUserOrMail.text)
                        
                        self.performSegueWithIdentifier("goto_menu", sender: self)
                        
                    } else {
                        print("Server response = ")
                        var errorsMessage = ""
                        for(var i = 0; i<serverResponseSplit.count; i++){
                            println((application.getErrorName(serverResponseSplit[i] as! String)))
                            errorsMessage = errorsMessage + application.getErrorName(serverResponseSplit[i] as! String) + ". \n"
                        }
                        
                        application.showAlert(self, titles: "ERROR!", messages: errorsMessage)
                    }
                }
            }
        }else{
            if (application.checkConnection()){
                application.myController.connect()
                findMyLocation()
                connected = true
            } else {
                application.noConnectionAlert(self)
            }
        }
    }
    
    @IBAction func registerTapped(sender: UIButton) {
        if(connected && application.checkConnection()){
            application.myController.sendMessage(REGISTER + SEPARATOR + REGISTER + SEPARATOR + REGISTER + SEPARATOR + REGISTER )
            var serverResponse = application.myController.readMessage()
            var serverResponseSplit = serverResponse.componentsSeparatedByString(SEPARATOR)
            
            if (serverResponseSplit[0] as! String == SUCCES) {
                
                // Everything is correct. Go to menu view
                self.performSegueWithIdentifier("goto_register", sender: self)
            } else {
                print("Server response = ")
                var errorsMessage = ""
                for(var i = 0; i<serverResponseSplit.count; i++){
                    println((application.getErrorName(serverResponseSplit[i] as! String)))
                    errorsMessage = errorsMessage + application.getErrorName(serverResponseSplit[i] as! String) + ". \n"
                }
                application.showAlert(self, titles: "ERROR!", messages: errorsMessage)
            }
        }else{
            if (application.checkConnection()){
                application.myController.connect()
                findMyLocation()
                connected = true
            } else {
                application.noConnectionAlert(self)
            }
        }
    }
    
    //
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
    // Own methods
    func requiredFieldsAreEmpty()-> Bool {
        return txtPassword.text.isEmpty && txtUserOrMail.text.isEmpty
    }
    
    func setupControllerImages() {
        
        // Set the BACKGROUND image
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size
        // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        
        // Set the TEXTFIELDS images
        txtPassword.background = UIImage(named: "no_focus.png")
        txtUserOrMail.background = UIImage(named: "no_focus.png")
        txtUserOrMail.layer.cornerRadius = 14
        txtPassword.layer.cornerRadius = 14
        let attributesDictionary = [NSForegroundColorAttributeName: UIColor.grayColor()]
        txtUserOrMail.attributedPlaceholder = NSAttributedString(string: "User or Email", attributes: attributesDictionary)
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributesDictionary)
        
        
        // Set the BUTTONS images
        
        
    }
    
    
    
    func loadSessionDataInNSUserDefaults()-> String {
        return "falta implementar este método o bórrarme también"
    }
    
    
    @IBAction func goToMenu(sender: UIButton) {
        self.performSegueWithIdentifier("goto_menu", sender: self)
    }
    
    @IBAction func goToRegister(sender: UIButton) {
        self.performSegueWithIdentifier("goto_register", sender: self)

    }
    
    
    
    
    
}
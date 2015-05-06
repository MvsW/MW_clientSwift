//
//  VCResgiter_player.swift
//  MW_clientSwiftDesign
//
//  Created by Black Castle on 15/2/15.
//  Copyright (c) 2015 MW. All rights reserved.

import UIKit

class VCRegister_player: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    /*
        TODO: IMPLEMENTAR LA RECULLIDA DE DADES PER ENVIARLES AL SERVIDOR!!!!
    */
    
    // DECLARACIO BOTONS
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var sumaStrenght: UIButton!
    @IBOutlet weak var restaStrenght: UIButton!
    @IBOutlet weak var sumaInteligence: UIButton!
    @IBOutlet weak var restaInteligence: UIButton!
    
    @IBOutlet weak var tfStrenght: UITextField!
    @IBOutlet weak var tfInteligence: UITextField!
    @IBOutlet weak var tfPoints: UITextField!
    @IBOutlet weak var tfLife: UITextField!
    @IBOutlet weak var tfEnergy: UITextField!
    @IBOutlet weak var tfEnergyRegeneration: UITextField!
    @IBOutlet weak var tfCharacterName: UITextField!
    
    @IBOutlet weak var lbl_classSelected: UILabel!
    
    @IBOutlet weak var classImage: UIImageView!
    @IBOutlet weak var btnCharacterImage: UIButton!

    // VARIABLES
    var containerView: UIView!
    var pointsLife = 0
    var pointsEnergy = 0
    var pointsEnergyRegeneration = 0
    var pointsStrenght = 0
    var pointsInteligence = 0
    var pointsPoints = 0
    
    // CONSTANTS
    let MAXPOINTS_STRENGHT = 5
    let MINPOINTS_STRENGHT = 1
    let MAXPOINTS_INTELIGENCE = 5
    let MINPOINTS_INTELIGENCE = 1
    
    let mageClass = UIImage(named: "mage.png")
    let warlockClass = UIImage(named: "warlock.png")
    
    
    
    // SPECIFIC VARIABLES FROM VCRegister.swift
    var userName = ""
    var userMail = ""
    var userPassword = ""
    var typeCharacter = MAGE

    // BUTTON METHODS
//    @IBAction func btnImage(sender: UIButton) {
//        if(typeCharacter == MAGE){
//            btnImage.setImage(UIImage(named:"logo.png"),forState:UIControlState.Highlighted)
//            typeCharacter = WARLOCK
//        }else{
//            btnImage.setImage(UIImage(named:"mage.png"),forState:UIControlState.Highlighted)
//            typeCharacter = MAGE
//        }
//    }
    @IBAction func btnCharacterImage(sender: UIButton) {
        if(typeCharacter == WARLOCK){
            typeCharacter = MAGE
            btnCharacterImage.setBackgroundImage(UIImage(named: "mage.png"), forState: UIControlState.Normal)
            lbl_classSelected.text = "MAGE"
        }else{
            typeCharacter = WARLOCK
            btnCharacterImage.setBackgroundImage(UIImage(named: "warlock.png"), forState: UIControlState.Normal)
            lbl_classSelected.text = "WARLOCK"
        }
    }
    
    @IBAction func sumaStrenght(sender: UIButton) {
        println("sumaStrength")
        if(tfStrenght.text.toInt() <= MAXPOINTS_STRENGHT){
            pointsStrenght = pointsStrenght + 1
            tfStrenght.text = pointsStrenght.description
        }
    }
    @IBAction func restaStrenght(sender: UIButton) {
        println("restaStrength")
        if(tfStrenght.text.toInt() >= MINPOINTS_STRENGHT){
            pointsStrenght = pointsStrenght - 1
            tfStrenght.text = pointsStrenght.description
        }
    }
    @IBAction func sumaInteligence(sender: UIButton) {
        println("sumaInteligence")
        if(tfInteligence.text.toInt() <= MAXPOINTS_INTELIGENCE){
            pointsInteligence = pointsInteligence + 1
            tfInteligence.text = pointsInteligence.description
        }
    }
    @IBAction func restaInteligence(sender: UIButton) {
        println("restaInteligence")
        if(tfInteligence.text.toInt() >= MINPOINTS_INTELIGENCE){
            pointsInteligence = pointsInteligence - 1
            tfInteligence.text = pointsInteligence.description
        }
    }
    
    // CONTROLLER VIEW METHODS
    @IBAction func createTapped(sender: UIButton) {
        //Checkejar els camps, si son correctes enviar al servidor i espera resposta
        //Si el server diu OK pasem a menu

        //Validar camps i enviar al servidor
        let validarUsuari: Bool = application.validatePlayerName(tfCharacterName.text)
        println(validarUsuari)
        if(validarUsuari){
            
            /*
            @IBOutlet weak var tfStrenght: UITextField!
            @IBOutlet weak var tfInteligence: UITextField!
            @IBOutlet weak var tfPoints: UITextField!
            @IBOutlet weak var tfLife: UITextField!
            @IBOutlet weak var tfEnergy: UITextField!
            @IBOutlet weak var tfEnergyRegeneration: UITextField!
            @IBOutlet weak var tfCharacterName: UITextField!
            */
            
            // playerName typePlayer life energy regeneration strenght intelligent
            println(tfCharacterName.text.lowercaseString + "," + typeCharacter.description + "," + tfLife.text + "," + tfEnergy.text + "," + tfEnergyRegeneration.text + "," + tfStrenght.text + "," + tfInteligence.text)
            
            application.myController.sendMessage(tfCharacterName.text.lowercaseString + "," + typeCharacter.description + "," + tfLife.text + "," + tfEnergy.text + "," + tfEnergyRegeneration.text + "," + tfStrenght.text + "," + tfInteligence.text)
            if(application.myController.readMessage() == SUCCES){
                self.performSegueWithIdentifier("goto_login", sender: self)
            }else{
                println("ERROR -> unseccfull")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfLife.enabled = false
        tfEnergy.enabled = false
        tfEnergyRegeneration.enabled = false
        tfStrenght.enabled = false
        tfInteligence.enabled = false
        tfPoints.enabled = false
        
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        // Set up the container view to hold your custom view hierarchy
        //let containerSize = CGSizeMake(640.0, 640.0)
        let containerSize = CGSizeMake(0, self.view.frame.height * 1.7)
        
        containerView = UIView(frame: CGRect(origin: CGPointMake(0.0, 0.0), size:containerSize))
        scrollView.addSubview(containerView)
        
        // Tell the scroll view the size of the contents
        scrollView.contentSize = containerSize;
        
        // Set up the minimum & maximum zoom scale
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}


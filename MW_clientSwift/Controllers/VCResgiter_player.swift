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
    
    /* CHARACTER LABELS */
    @IBOutlet weak var lblCount_life: UILabel!
    @IBOutlet weak var lblCount_energy: UILabel!
    @IBOutlet weak var lblCount_eRegen: UILabel!
    @IBOutlet weak var lblCount_strength: UILabel!
    @IBOutlet weak var lblCount_intelligence: UILabel!
    @IBOutlet weak var lbl_classSelected: UILabel!
    @IBOutlet weak var lblCount_unasPoints: UILabel!
    @IBOutlet weak var btnCharacterImage: UIButton!
    @IBOutlet weak var tfCharacterName: UITextField!
    
    // steppers are declarated as actions directly
    @IBOutlet weak var stpr_strength: UIStepper!
    @IBOutlet weak var stpr_intelligence: UIStepper!
    
    
    // VARIABLES
    var containerView: UIView!
    var pointsLife = 0
    var pointsEnergy = 0
    var pointsEnergyRegeneration = 0
    var pointsStrength = 0
    var pointsInteligence = 0
    var pointsPoints = 0
    
    // CONSTANTS
    let MAX_STRENGHT = 5
    let MIN_STRENGHT = 1
    let MAX_INTELIGENCE = 5
    let MIN_INTELIGENCE = 1
    let MIN_GENERIC = 0.0
    
    let mageClass = UIImage(named: "mage.png")
    let warlockClass = UIImage(named: "warlock.png")
    
    
    // SPECIFIC VARIABLES FROM VCRegister.swift
    var userName = ""
    var userMail = ""
    var userPassword = ""
    var typeCharacter = MAGE
    
    // BUTTON METHODS
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
    
    
    // CONTROLLER VIEW METHODS
    @IBAction func createTapped(sender: UIButton) {
        
        // Check if the fields are correctly filled
        let characterValidation: Bool = application.validatePlayerName(tfCharacterName.text)
        
        if (characterValidation) {
        
            // Check points has been assigned
            if (allPointsHasBeenAssignedProperly()) {
                
                // Keep going. 
                // TODO Send a message and get message for been success
                // TODO Make and implement the methods for increase the life, energy or regen depending of the strength and intel.
                if (application.myController.readMessage() == SUCCES){
                    self.performSegueWithIdentifier("goto_login", sender: self)
                
                } else{
                    println("ERROR -> unsuccessfull")
                }
                
            } else {
                println("So sorry, but all the points has not been set")
            }
        }
    }
    
    @IBAction func stpr_strength(sender: UIStepper) {
        
        var stprValue = Int(sender.value)
        var currentLbl = self.lblCount_strength
        var currentPoints = lblCount_unasPoints.text!.toInt()!
        
        // First check if we are inside of the bounds.
        if stprValue < pointsStrength {
            // Decreasing
            // println("Restant contador strength.")
            
            if (currentPoints+1 >= 0 && currentPoints+1 <= MAX_UNASIGNED_POINTS) {
                currentPoints++
                pointsStrength = stprValue
                lblCount_strength.text = pointsStrength.description
            }
            
        } else {
            // Summing up
            // println("Sumant contador strength")
            
            if (currentPoints-1 >= 0 && currentPoints-1 <= MAX_UNASIGNED_POINTS) {
                currentPoints--
                // Setting the value
                pointsStrength = stprValue
                lblCount_strength.text = pointsStrength.description
            }
            
        }
        
        lblCount_unasPoints.text = currentPoints.description
    }
    
    @IBAction func stpr_intelligence(sender: UIStepper) {
        
        var stprValue = Int(sender.value)
        var currentLbl = self.lblCount_strength
        var currentPoints = lblCount_unasPoints.text!.toInt()!
        
        // First check if we are inside of the bounds.
        if stprValue < pointsInteligence {
            // Decreasing
            // println("Decreasing strength's counter.")
            
            if (currentPoints+1 >= 0 && currentPoints+1 <= MAX_UNASIGNED_POINTS) {
                currentPoints++
                pointsInteligence = stprValue
                lblCount_intelligence.text = pointsInteligence.description
            }
            
        } else {
            // Summing up
            // println("Increasing intelligence's counter")
            
            if (currentPoints-1 >= 0 && currentPoints-1 <= MAX_UNASIGNED_POINTS) {
                currentPoints--
                // Setting the value
                pointsInteligence = stprValue
                lblCount_intelligence.text = pointsInteligence.description
            }
            
        }
        
        lblCount_unasPoints.text = currentPoints.description
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCount_life.enabled = false
        lblCount_energy.enabled = false
        lblCount_eRegen.enabled = false
        lblCount_strength.enabled = false
        lblCount_intelligence.enabled = false
        lblCount_unasPoints.enabled = false
        
        // Set background image
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
    
    func allPointsHasBeenAssignedProperly()->Bool {
        return (lblCount_strength.text!.toInt()! + lblCount_intelligence.text!.toInt()!) == 14 && lblCount_unasPoints.text!.toInt()! == 0
    }
    
    func reCountUnassignedPoints()->Int? {
        
        var newValue = MAX_UNASIGNED_POINTS - (lblCount_strength.text!.toInt()! + lblCount_intelligence.text!.toInt()!)

        if (newValue >= 0) {
        
            lblCount_unasPoints.text = String(newValue)
            
        }
        println("unassigned points: \(newValue)")
        return newValue
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


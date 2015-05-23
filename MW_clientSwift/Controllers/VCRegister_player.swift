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
    var pointsPoints: Double = Double(CUSTOM_CALC)
    var pointsStepperStrength: Double = 0
    var pointsStepperIntelligence: Double = 0
    
    @IBOutlet weak var stepperStr: UIStepper!
    @IBOutlet weak var stepperInt: UIStepper!
    
    // CONSTANTS
    let MAX_STRENGTH = 5
    let MIN_STRENGTH = 1
    let MAX_INTELIGENCE = 5
    let MIN_INTELIGENCE = 1
    let MIN_GENERIC = 0.0
    
    let mageClass = UIImage(named: "mage.png")
    let warlockClass = UIImage(named: "warlock.png")
    
    
    // SPECIFIC VARIABLES FROM VCRegister.swift
    var userName = ""
    var userMail = ""
    var userPassword = ""
    var typeCharacter = WARLOCK
    
    var lastValueSendOfStr = 0
    var lastValueSendOfIntel = 0
    
    // BUTTON METHODS
    func resetStatsSteppers(){
        
        pointsPoints = Double(CUSTOM_CALC)
        pointsStepperStrength = 0
        pointsStepperIntelligence = 0
        lblCount_unasPoints.text = Int(pointsPoints).description
        stepperStr.value = 0
        stepperInt.value = 0
        stepperStr.maximumValue = 9999
        stepperInt.maximumValue = 9999
        stepperInt.minimumValue = -9999
        stepperStr.minimumValue = -9999
    }
    
    @IBAction func btnCharacterImage(sender: UIButton) {
        randomStats()
        resetStatsSteppers()
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
    
    @IBAction func btnCreatePlayerTapped(sender: UIButton) {
        
        // Check if the fields are correctly filled
        let characterValidation: Bool = application.validatePlayerName(tfCharacterName.text)
        
        if (characterValidation) {
            
            // Check points has been assigned
            if (allPointsHasBeenAssignedProperly()) {
                println(tfCharacterName.text + "," + typeCharacter.description + "," + lblCount_life.text! + "," + lblCount_energy.text! + "," + lblCount_eRegen.text! + "," + lblCount_strength.text! + "," + lblCount_intelligence.text!)
                
                application.myController.sendMessage(tfCharacterName.text + "," + typeCharacter.description + "," + lblCount_life.text! + "," + lblCount_energy.text! + "," + lblCount_eRegen.text! + "," + lblCount_strength.text! + "," + lblCount_intelligence.text!)
                
                // Keep going.
                // TODO Send a message and get message for been success
                // TODO Make and implement the methods for increase the life, energy or regen depending of the strength and intel.
                var receivedMessage = application.myController.readMessage()
                if (receivedMessage == SUCCES){
                    self.performSegueWithIdentifier("goto_login", sender: self)
                    
                } else{
                    println("Error -> Message received: \(receivedMessage)")
                }
                
            } else {
                println("So sorry, but all the points has not been set")
                application.showAlert(self, titles: "So sorry", messages: "All the points has not been set.")
            }
        }
    }
    
    @IBAction func stpr_strength(sender: UIStepper) {
//        println(Int(pointsPoints)-1)
        if (pointsStepperStrength <= sender.value && Int(pointsPoints)-1 >= 0){
            
            pointsPoints = pointsPoints - 1
            
            lblCount_strength.text = Int((Double(pointsStrength) + Double(sender.value))).description
            
            pointsStepperStrength = Double(sender.value)
            
            lblCount_unasPoints.text = Int(pointsPoints).description
            
            lastValueSendOfStr = Int(sender.value)
        
        } else {
            
            if (pointsStepperStrength > sender.value && Int(pointsPoints)-1 < Int(CUSTOM_CALC)){
                
                pointsPoints = pointsPoints + 1
                
                lblCount_strength.text = Int((Double(pointsStrength) + Double(sender.value))).description
                
                pointsStepperStrength = Double(sender.value)    
                
                lblCount_unasPoints.text = Int(pointsPoints).description
                
                lastValueSendOfStr = Int(sender.value)
                
            } else {
                
                sender.value = Double(lastValueSendOfStr)
            
            }
        }
        
        // Refreshing the strength and intelligence labels after modifing the current label
        refreshAllLabelStats()
    }
    
    @IBAction func stpr_intelligence(sender: UIStepper) {
//        println(Int(pointsPoints)-1)
        
        if (pointsStepperIntelligence < sender.value && Int(pointsPoints)-1 >= 0) {
            
            pointsPoints = pointsPoints - 1
            
            lblCount_intelligence.text = Int((Double(pointsInteligence) + Double(sender.value))).description
            
            pointsStepperIntelligence = Double(sender.value)
            
            lblCount_unasPoints.text = Int(pointsPoints).description
            
            lastValueSendOfIntel = Int(sender.value)
        
            
        } else {
            
            if (pointsStepperIntelligence >= sender.value && Int(pointsPoints)-1 < Int(CUSTOM_CALC)){
                
                pointsPoints = pointsPoints + 1
                
                lblCount_intelligence.text = Int((Double(pointsInteligence) + Double(sender.value))).description
                
                pointsStepperIntelligence = Double(sender.value)
                
                lblCount_unasPoints.text = Int(pointsPoints).description
                
                lastValueSendOfIntel = Int(sender.value)
            
                
            } else {
                
                sender.value = Double(lastValueSendOfIntel)
            }
        }
        
        // Refreshing the strength and intelligence labels after modifing the current label
        refreshAllLabelStats()
    }
    
    @IBAction func printAllDataReadyForSend(sender: UIButton) {
        println(tfCharacterName.text + "," + typeCharacter.description + "," + lblCount_life.text! + "," + lblCount_energy.text! + "," + lblCount_eRegen.text! + "," + lblCount_strength.text! + "," + lblCount_intelligence.text! + " => " + allPointsHasBeenAssignedProperly().description)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.randomStats()
        self.resetStatsSteppers()
        
        lblCount_life.enabled = false
        lblCount_energy.enabled = false
        lblCount_eRegen.enabled = false
        lblCount_strength.enabled = false
        lblCount_intelligence.enabled = false
        lblCount_unasPoints.enabled = false
        
        lblCount_unasPoints.text = CUSTOM_CALC.description
        
        
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func allPointsHasBeenAssignedProperly()->Bool {
        if(lblCount_unasPoints.text!.toInt() == 0){
            return true
        }else{
            return false
        }
    }
    
    func reCountUnassignedPoints()->Int? {
        
        var newValue = Int(CUSTOM_CALC) - (lblCount_strength.text!.toInt()! + lblCount_intelligence.text!.toInt()!)
        
        if (newValue >= 0) {
            
            lblCount_unasPoints.text = String(newValue)
            
        }
//        println("unassigned points: \(newValue)")
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
    
    func randomStats(){
        pointsLife = application.getDefaultStats(typeCharacter)[0]
        lblCount_life.text = pointsLife.description
        
        pointsEnergy = application.getDefaultStats(typeCharacter)[1]
        lblCount_energy.text = pointsEnergy.description
        
        pointsEnergyRegeneration = application.getDefaultStats(typeCharacter)[2]
        lblCount_eRegen.text = pointsEnergyRegeneration.description
        
        pointsStrength = application.getDefaultStats(typeCharacter)[3]
        lblCount_strength.text = pointsStrength.description
        
        pointsInteligence = application.getDefaultStats(typeCharacter)[4]
        lblCount_intelligence.text = pointsInteligence.description
    }
    
    func refreshAllLabelStats() {
        // Using the overload method getDefaultsStats passing 2 params.
        var freshData:[Int] = application.getDefaultsStats(lblCount_strength.text!.toInt()!, intelligence_points: lblCount_intelligence.text!.toInt()!)
        
        println(freshData.description)
        
        pointsLife = freshData[0]
        lblCount_life.text = pointsLife.description
        
        pointsEnergy = freshData[1]
        lblCount_energy.text = pointsEnergy.description
        
        pointsEnergyRegeneration = freshData[2]
        lblCount_eRegen.text = pointsEnergyRegeneration.description
    }
}


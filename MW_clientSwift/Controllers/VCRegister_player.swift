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
    @IBOutlet weak var lblCount_unasPoints: UILabel!
    @IBOutlet weak var btnCharacterImage: UIButton!
    @IBOutlet weak var tfCharacterName: UITextField!
    
    @IBOutlet weak var intIncrement: UIButton!
    @IBOutlet weak var intDecrement: UIButton!
    @IBOutlet weak var strIncrement: UIButton!
    @IBOutlet weak var strDecrement: UIButton!
    
    
    // VARIABLES
    var containerView: UIView!
    var pointsLife = 0
    var pointsEnergy = 0
    var pointsEnergyRegeneration = 0
    var pointsStrength = 0
    var pointsInteligence = 0
    var pointsPoints: Double = Double(CUSTOM_CALC)
    var assignedStrPoints = 0;
    var assignedIntPoints = 0;
    
    
    // CONSTANTS
    let MAX_STRENGTH = 5
    let MIN_STRENGTH = 1
    let MAX_INTELIGENCE = 5
    let MIN_INTELIGENCE = 1
    let MIN_GENERIC = 0.0
    
    let mageClass = UIImage(named: "mage.png")
    let warlockClass = UIImage(named: "warlock.png")
    

    
    // SPECIFIC VARIABLES FROM VCRegister.swift (user)
    var userName = ""
    var userMail = ""
    var userPassword = ""
    var typeCharacter = MAGE
    
    var lastValueSendOfStr = 0
    var lastValueSendOfIntel = 0
    
    func calculateTheAtributeForOperation(atribute : NSString, operation: NSString){
        var cal: Int
        let queVol = (operation,atribute)
        switch queVol{
        case let("sum" , "str"):
            assignedStrPoints++
            pointsPoints = pointsPoints - 1
            pointsStrength++
            lblCount_strength.text = pointsStrength.description
            lblCount_unasPoints.text = Int(pointsPoints).description
            break
        case let("rest" , "str"):
            assignedStrPoints--
            pointsPoints = pointsPoints + 1
            pointsStrength--
            lblCount_strength.text = pointsStrength.description
            lblCount_unasPoints.text = Int(pointsPoints).description
            break
        case let("sum", "int"):
            assignedIntPoints++
            pointsPoints = pointsPoints - 1
            pointsInteligence++
            lblCount_intelligence.text = pointsInteligence.description
            lblCount_unasPoints.text = Int(pointsPoints).description
            break
        case let("rest","int"):
            assignedIntPoints--
            pointsPoints = pointsPoints + 1
            pointsInteligence--
            lblCount_intelligence.text = pointsInteligence.description
            lblCount_unasPoints.text = Int(pointsPoints).description
            break
        default:
            break
        }
        refreshAllLabelStats()
    }
    
    @IBAction func button_pointsTapped(sender: UIButton){
        switch sender.tag{
        case 0:
            if (Int(pointsPoints) < Int(CUSTOM_CALC) && assignedStrPoints > 0){
                calculateTheAtributeForOperation("str", operation:"rest")
            }
            break
        case 1:
            if (Int(pointsPoints) > 0){
                calculateTheAtributeForOperation("str",operation: "sum")
            }
            break
        case 2:
            if (Int(pointsPoints) < Int(CUSTOM_CALC) && assignedIntPoints > 0){
                calculateTheAtributeForOperation("int", operation: "rest")
            }
            break
        case 3:
            if (Int(pointsPoints) > 0){
                calculateTheAtributeForOperation("int", operation: "sum")
            }
            break
        default:
            break
        }
        
        
    }
    
    // BUTTON METHODS
    @IBAction func cancelTapped(sender: UIButton) {
        application.myController.sendMessage(CANCEL)
        self.performSegueWithIdentifier("goto_login", sender: self)

    }
    
    @IBAction func btnCharacterImage(sender: UIButton) {
        randomStats()
        resetStats()
        if(typeCharacter == WARLOCK){
            typeCharacter = MAGE
            btnCharacterImage.setBackgroundImage(UIImage(named: "mage.png"), forState: UIControlState.Normal)
        }else{
            typeCharacter = WARLOCK
            btnCharacterImage.setBackgroundImage(UIImage(named: "warlock.png"), forState: UIControlState.Normal)
        }
        loadAllButtonsImages()
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

    
    @IBAction func printAllDataReadyForSend(sender: UIButton) {
        println(tfCharacterName.text + "," + typeCharacter.description + "," + lblCount_life.text! + "," + lblCount_energy.text! + "," + lblCount_eRegen.text! + "," + lblCount_strength.text! + "," + lblCount_intelligence.text! + " => " + allPointsHasBeenAssignedProperly().description)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.randomStats()
        self.resetStats()
        
        lblCount_life.enabled = false
        lblCount_energy.enabled = false
        lblCount_eRegen.enabled = false
        lblCount_strength.enabled = false
        lblCount_intelligence.enabled = false
        lblCount_unasPoints.enabled = false
        
        lblCount_unasPoints.text = Int(CUSTOM_CALC).description
        
        
        // Set background image
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        // Set up the container view to hold your custom view hierarchy
        //let containerSize = CGSizeMake(640.0, 640.0)
        let containerSize = CGSizeMake(0, self.view.frame.height * 1.7)
        
        containerView = UIView(frame: CGRect(origin: CGPointMake(0.0, 0.0), size:containerSize))
        scrollView.addSubview(containerView)
        
        // Loading all the steppers images
       loadAllButtonsImages()
        
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
        var myStats = application.getDefaultStats(typeCharacter)
        
        pointsLife = myStats[0]
        lblCount_life.text = pointsLife.description
        
        pointsEnergy = myStats[1]
        lblCount_energy.text = pointsEnergy.description
        
        pointsEnergyRegeneration = myStats[2]
        lblCount_eRegen.text = pointsEnergyRegeneration.description
        
        pointsStrength = myStats[3]
        lblCount_strength.text = pointsStrength.description
        
        pointsInteligence = myStats[4]
        lblCount_intelligence.text = pointsInteligence.description
    }
    
    func resetStats(){
        assignedIntPoints = 0
        assignedStrPoints = 0
        pointsPoints = Double(CUSTOM_CALC)
        lblCount_unasPoints.text = Int(pointsPoints).description
        
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
    
    func loadAllButtonsImages() {

        var imgStr_increment: UIImage!
        var imgStr_decrement: UIImage!
        var color_steppers: UIColor!
        switch(typeCharacter){
        case MAGE:
            
            intIncrement.setBackgroundImage(UIImage(named: "mage_point_up_focus.png")!,forState: UIControlState.Normal)
            intDecrement.setBackgroundImage(UIImage(named: "mage_point_down_focus.png")!, forState: UIControlState.Normal)
            strIncrement.setBackgroundImage(UIImage(named: "mage_point_up_focus.png")!,forState: UIControlState.Normal)
            strDecrement.setBackgroundImage(UIImage(named: "mage_point_down_focus.png")!, forState: UIControlState.Normal)
            color_steppers = UIColor(red: 0, green: 119/255, blue: 1, alpha: 0)
            break
            
        case WARLOCK:
            
            intIncrement.setBackgroundImage(UIImage(named: "warlock_point_up_focus.png")!,forState: UIControlState.Normal)
            intDecrement.setBackgroundImage(UIImage(named: "warlock_point_down_focus.png")!, forState: UIControlState.Normal)
            strIncrement.setBackgroundImage(UIImage(named: "warlock_point_up_focus.png")!,forState: UIControlState.Normal)
            strDecrement.setBackgroundImage(UIImage(named: "warlock_point_down_focus.png")!, forState: UIControlState.Normal)
            color_steppers = UIColor(red: 1, green: 20/255, blue: 0, alpha: 0)

            break
        default:
            break
        }
    }
}


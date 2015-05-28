//
//  VCBattle.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCBattle: UIViewController {
    
    // LABELS
    @IBOutlet weak var lbl_myLife: UILabel!
    @IBOutlet weak var lbl_myEnergy: UILabel!
    
    @IBOutlet weak var lbl_hisLife: UILabel!
    @IBOutlet weak var lbl_hisEnergy: UILabel!
    
    @IBOutlet weak var myLife: UIImageView!
    @IBOutlet weak var mYEnergy: UIImageView!
    @IBOutlet weak var opponentLife: UIImageView!
    @IBOutlet weak var opponentEnergy: UIImageView!
    
    @IBOutlet weak var btnShield: UIButton!
    @IBOutlet weak var btnUltimate: UIButton!
    @IBOutlet weak var btnSpell1: UIButton!
    @IBOutlet weak var btnDodge: UIButton!
    @IBOutlet weak var btnSpell2: UIButton!
    @IBOutlet weak var btnBasicAtt: UIButton!
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var opponentImageView: UIImageView!
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    
    @IBOutlet weak var lbl_actionName: UILabel!
    @IBOutlet weak var lbl_actionDescription: UITextView!
    
    var dataArray: [String]!
    var messageReceived: NSString!
    
    var myOriginalLife = "0"
    var myOriginalEnergy = "0"
    var opponentOriginalLife = "0"
    var opponentOriginalEnergy = "0"
    
    var originalLifeFrameWidth:CGFloat = 0
    var originalmYEnergyFrameWidth:CGFloat = 0
    var originalOpponentLifeFrameWidth:CGFloat = 0
    var originalOpponentEnergyFrameWidth:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalLifeFrameWidth = myLife.frame.width
        originalmYEnergyFrameWidth = mYEnergy.frame.width
        originalOpponentLifeFrameWidth = opponentLife.frame.width
        originalOpponentEnergyFrameWidth = opponentEnergy.frame.width
        
        // Set the background image
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "battle_display.jpg")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        
        // DESACTIVAT AMB FREE PASS
        if(!freePass){
            messageReceived = application.myController.readMessage()
            dataArray = messageReceived.componentsSeparatedByString(",") as! [String]
            
            myName.text = self.dataArray[0]
            if(self.dataArray[1].toInt() == MAGE){
                myImageView.image = UIImage(named: "pg_avatar_mage.png")
                btnBasicAtt.setBackgroundImage(UIImage(named: "basic2.png"), forState: UIControlState.Normal)

            }else{
                myImageView.image = UIImage(named: "pg_avatar_warlock.png")
                btnBasicAtt.setBackgroundImage(UIImage(named: "basic1.png"), forState: UIControlState.Normal)

            }
            myOriginalLife = self.dataArray[2]
            myOriginalEnergy = self.dataArray[3]
            
            opponentName.text = self.dataArray[4]
            if(self.dataArray[5].toInt() == MAGE){
                opponentImageView.image = UIImage(named: "pg_avatar_mage.png")
            }else{
                opponentImageView.image = UIImage(named: "pg_avatar_warlock.png")
            }
            opponentOriginalLife = self.dataArray[6]
            opponentOriginalEnergy = self.dataArray[7]
            
        }else{
            refreshInterfaceProgressBar(0.9, forMyEnergy: 0.8, forOpponentLife: 0.7, forOpponentEnergy: 0.6)
        }
        refreshInterfaceLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBtnTapped(sender: AnyObject) {
        var gameWon = "9"
        
        // Get the tag
        var tag: Int = sender.tag
        
        // Variables for printing the correct title and description on the info box
        var actionName = "Action name"
        var actionDescription = "Any action pressed yet."
    
        // 1 basic
        // 2 spell_1
        // 3 spell_2
        // 4 ulti
        // 6 dodge
        // 5 shield
        
        switch(String(tag)){
        
        case "1":
            actionName = NAME_BASIC
            actionDescription = TEXT_BASIC
            application.precarregarEfect("basico")
            application.startEfect()
        
        case "2":
            actionName = NAME_SPELL1
            actionDescription = TEXT_SPELL1
            application.precarregarEfect("spell1")
            application.startEfect()
        
        case "3":
            actionName = NAME_SPELL2
            actionDescription = TEXT_SPELL2
            application.precarregarEfect("spell2")
            application.startEfect()
        
        case "4":
            actionName = NAME_ULTIMATE
            actionDescription = TEXT_ULTIMATE
            application.precarregarEfect("ua")
            application.startEfect()
        
        case "5":
            actionName = NAME_SHIELD
            actionDescription = TEXT_SHIELD
            application.precarregarEfect("shield")
            application.startEfect()
            
        case "6":
            actionName = NAME_DODGE
            actionDescription = TEXT_DODGE
            application.precarregarEfect("dodge")
            application.startEfect()
        
        default:
            
            println("Inside of the music switch on action tapped > The tag \(String(tag)) given is incorrect.")
        
        }
        
        // Printing information
        dispatch_async(dispatch_get_main_queue()) {
            
            self.printNameAndActionDescription(actionName, description: actionDescription)
            
        }
        
        // Attention! Take care that the tags are between actions number of.
        if (tag >= 0 && tag <= MAX_ACTIONS) {
            
            println("Action battle sent: \(tag)")
            application.myController.sendMessage(String(tag))
            
            // Receiving the data from server.
            messageReceived = application.myController.readMessage()
            
            // Always receive my data, and then the other player (myLife, myEnergy, hisLife, hisEnergy)
            dataArray = messageReceived.componentsSeparatedByString(",") as! [String]
            
            println(self.dataArray[0])
            var array1ToFloat:CGFloat = CGFloat((self.dataArray[2] as NSString).floatValue)
            var originalmyLifeToFloat: CGFloat = CGFloat((myOriginalLife as NSString).floatValue)
            
            var array2ToFloat:CGFloat = CGFloat((self.dataArray[3] as NSString).floatValue)
            var originalmYEnergyToFloat: CGFloat = CGFloat((myOriginalEnergy as NSString).floatValue)
            
            var array3ToFloat:CGFloat = CGFloat((self.dataArray[6] as NSString).floatValue)
            var originalOpponentLifeToFloat: CGFloat = CGFloat((opponentOriginalLife as NSString).floatValue)
        
            var array4ToFloat:CGFloat = CGFloat((self.dataArray[7] as NSString).floatValue)
            var originalOpponentEnergyToFloat: CGFloat = CGFloat((opponentOriginalEnergy as NSString).floatValue)
            
            var calcul1 = (array1ToFloat * 100 / originalmyLifeToFloat)/100
            var calcul2 = (array2ToFloat * 100 / originalmYEnergyToFloat)/100
            var calcul3 = (array3ToFloat * 100 /  originalOpponentLifeToFloat)/100
            var calcul4 = (array4ToFloat  * 100 / originalOpponentEnergyToFloat)/100
            
            println(calcul1)
            println(calcul2)
            println(calcul3)
            println(calcul4)
            
            if(calcul2 < 0.89 && calcul2 > 0.34){
                btnUltimate.enabled = false
                btnUltimate.setBackgroundImage(UIImage(named: "nospecialbutton.png"), forState: UIControlState.Normal)
                
                btnSpell2.enabled = true
                btnSpell2.setBackgroundImage(UIImage(named: "special2.png"), forState: UIControlState.Normal)
                
                btnSpell1.enabled = true
                btnSpell1.setBackgroundImage(UIImage(named: "special1.png"), forState: UIControlState.Normal)
            }
            if(calcul2 < 0.34){
                btnUltimate.enabled = false
                btnUltimate.setBackgroundImage(UIImage(named: "nospecialbutton.png.png"), forState: UIControlState.Normal)
                
                btnSpell2.enabled = false
                btnSpell2.setBackgroundImage(UIImage(named: "nospecial2.png"), forState: UIControlState.Normal)
                
                btnSpell1.enabled = true
                btnSpell1.setBackgroundImage(UIImage(named: "special1.png"), forState: UIControlState.Normal)
            }
            if(calcul2 < 0.21){
                btnUltimate.enabled = false
                btnUltimate.setBackgroundImage(UIImage(named: "nospecialbutton.png.png"), forState: UIControlState.Normal)
                
                btnSpell2.enabled = false
                btnSpell2.setBackgroundImage(UIImage(named: "nospecial2.png"), forState: UIControlState.Normal)
                
                btnSpell1.enabled = false
                btnSpell1.setBackgroundImage(UIImage(named: "nospecial1.png"), forState: UIControlState.Normal)
            }
            
            self.refreshInterfaceProgressBar(calcul1, forMyEnergy: calcul2, forOpponentLife: calcul3, forOpponentEnergy: calcul4)
            refreshInterfaceLabels()

            if(dataArray.count == 9){
                gameWon = dataArray[8]
            }
            
            if(gameWon == WIN){
                application.precarregarEfect("victory")
                application.startEfect()
                application.showAlertWin(self, titles: "You WIN!", messages: "")
            }
            if(gameWon == DRAW){
                application.precarregarEfect("derrota")
                application.startEfect()
                application.showAlertDraw(self, titles: "Draw!", messages: "")
            }
            if(gameWon == LOSE){
                application.precarregarEfect("derrota")
                application.startEfect()
                application.showAlertDefeated(self, titles: "Defeated!", messages: "")
            }
        }
        
    }
    
    func refreshInterfaceLabels() {
        if (self.dataArray != nil) {
            self.lbl_myLife.text = (self.dataArray[2] as NSString).floatValue.description.componentsSeparatedByString(".")[0]+"/" + myOriginalLife.componentsSeparatedByString(".")[0]
            self.lbl_myEnergy.text = (self.dataArray[3] as NSString).floatValue.description.componentsSeparatedByString(".")[0]+"/" + myOriginalEnergy.componentsSeparatedByString(".")[0]
            self.lbl_hisLife.text = (self.dataArray[6] as NSString).floatValue.description.componentsSeparatedByString(".")[0]+"/" + opponentOriginalLife.componentsSeparatedByString(".")[0]
            self.lbl_hisEnergy.text = (self.dataArray[7] as NSString).floatValue.description.componentsSeparatedByString(".")[0]+"/" + opponentOriginalEnergy.componentsSeparatedByString(".")[0]
        }
    }
    
    func refreshInterfaceProgressBar(forMyLife:CGFloat, forMyEnergy:CGFloat, forOpponentLife:CGFloat, forOpponentEnergy:CGFloat){
        
        myLife.frame = CGRectMake(myLife.frame.minX, myLife.frame.minY, originalLifeFrameWidth*forMyLife, myLife.frame.height)
        mYEnergy.frame = CGRectMake(mYEnergy.frame.minX, mYEnergy.frame.minY, originalmYEnergyFrameWidth*forMyEnergy, mYEnergy.frame.height)
        
        opponentLife.frame = CGRectMake(opponentLife.frame.minX, opponentLife.frame.minY, originalOpponentLifeFrameWidth*forOpponentLife, opponentLife.frame.height)
        opponentEnergy.frame = CGRectMake(opponentEnergy.frame.minX, opponentEnergy.frame.minY, originalOpponentEnergyFrameWidth*forOpponentEnergy, opponentEnergy.frame.height)
    }
    
    func printNameAndActionDescription(actionName: String, description: String) {
        
        self.lbl_actionName.text = actionName
        self.lbl_actionDescription.text = description
        
    }
    
}

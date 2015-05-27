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
    
    var dataArray: [String]!
    var messageReceived: NSString!
    
    var myOriginalLife = "0"
    var myOriginalEnergy = "0"
    var opponentOriginalLife = "0"
    var opponentOriginalEnergy = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
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
        var guanyaPartida = "9"
        
        // Get the tag
        var tag: Int = sender.tag
        
        // 4 ulti
        // 1 basic
        // 2 spell 1
        // 3 spell 2
        // 6 dodge
        // 5 shield
        
        switch(String(tag)){
            case "1":
                application.precarregarEfect("basico")
                application.startEfect()
            case "2":
                application.precarregarEfect("spell1")
                application.startEfect()
            case "3":
                application.precarregarEfect("spell2")
                application.startEfect()
            case "4":
                application.precarregarEfect("ua")
                application.startEfect()
            case "5":
                application.precarregarEfect("shield")
                application.startEfect()
            case "6":
                application.precarregarEfect("dodge")
                application.startEfect()
        default:
            println("default music! WTF?")
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
            var oginalmyLifeToFloat: CGFloat = CGFloat((myOriginalLife as NSString).floatValue)
            
            var array2ToFloat:CGFloat = CGFloat((self.dataArray[3] as NSString).floatValue)
            var oginalmYEnergyToFloat: CGFloat = CGFloat((myOriginalEnergy as NSString).floatValue)
            
            var array3ToFloat:CGFloat = CGFloat((self.dataArray[6] as NSString).floatValue)
            var oginalOpponentLifeToFloat: CGFloat = CGFloat((opponentOriginalLife as NSString).floatValue)
        
            var array4ToFloat:CGFloat = CGFloat((self.dataArray[7] as NSString).floatValue)
            var oginalOpponentEnergyToFloat: CGFloat = CGFloat((opponentOriginalEnergy as NSString).floatValue)
            
            var calcul1 = (array1ToFloat * 100 / oginalmyLifeToFloat)/100
            var calcul2 = (array2ToFloat * 100 / oginalmYEnergyToFloat)/100
            var calcul3 = (array3ToFloat * 100 /  oginalOpponentLifeToFloat)/100
            var calcul4 = (array4ToFloat  * 100 / oginalOpponentEnergyToFloat)/100
            
            if(calcul2 < 0.8 && calcul2 > 0.4){
                btnUltimate.enabled = false
                btnUltimate.setBackgroundImage(UIImage(named: "nospecialbutton.png"), forState: UIControlState.Normal)
                
                btnSpell2.enabled = true
                btnSpell2.setBackgroundImage(UIImage(named: "special2.png"), forState: UIControlState.Normal)
                
                btnSpell1.enabled = true
                btnSpell1.setBackgroundImage(UIImage(named: "special1.png"), forState: UIControlState.Normal)
            }
            if(calcul2 < 0.4){
                btnUltimate.enabled = false
                btnUltimate.setBackgroundImage(UIImage(named: "nospecialbutton.png.png"), forState: UIControlState.Normal)
                
                btnSpell2.enabled = false
                btnSpell2.setBackgroundImage(UIImage(named: "nospecial2.png"), forState: UIControlState.Normal)
                
                btnSpell1.enabled = true
                btnSpell1.setBackgroundImage(UIImage(named: "special1.png"), forState: UIControlState.Normal)
            }
            if(calcul2 < 0.15){
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
                guanyaPartida = dataArray[8]
            }
            
            if(guanyaPartida == WIN){
                application.precarregarEfect("victory")
                application.startEfect()
                application.showAlertWin(self, titles: "You WIN!", messages: "")
            }
            if(guanyaPartida == DRAW){
                application.precarregarEfect("derrota")
                application.startEfect()
                application.showAlertDraw(self, titles: "Draw!", messages: "")
            }
            if(guanyaPartida == LOSE){
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
        
        myLife.frame = CGRectMake(myLife.frame.minX, myLife.frame.minY, myLife.frame.width*forMyLife, myLife.frame.height)
        mYEnergy.frame = CGRectMake(mYEnergy.frame.minX, mYEnergy.frame.minY, mYEnergy.frame.width*forMyEnergy, mYEnergy.frame.height)
        
        opponentLife.frame = CGRectMake(opponentLife.frame.minX, opponentLife.frame.minY, opponentLife.frame.width*forOpponentLife, opponentLife.frame.height)
        opponentEnergy.frame = CGRectMake(opponentEnergy.frame.minX, opponentEnergy.frame.minY, opponentEnergy.frame.width*forOpponentEnergy, opponentEnergy.frame.height)
    }
    
}

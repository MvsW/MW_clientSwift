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
    
    @IBOutlet weak var meLife: UIImageView!
    @IBOutlet weak var meEnergy: UIImageView!
    @IBOutlet weak var opponentLife: UIImageView!
    @IBOutlet weak var opponentEnergy: UIImageView!
    
    @IBOutlet weak var btnShield: UIButton!
    @IBOutlet weak var btnUltimate: UIButton!
    @IBOutlet weak var btnSpell1: UIButton!
    @IBOutlet weak var btnDodge: UIButton!
    @IBOutlet weak var btnSpell2: UIButton!
    @IBOutlet weak var btnBasicAtt: UIButton!
    
    var dataArray: [String]!
    var messageReceived: NSString!
    
    var originalMeLife = "0"
    var originalMeEnergy = "0"
    var originalOpponentLife = "0"
    var originalOpponentEnergy = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        
         //DESACTIVAT AMB FREE PASS
        messageReceived = application.myController.readMessage()
        dataArray = messageReceived.componentsSeparatedByString(",") as! [String]
        
        originalMeLife = self.dataArray[0]
        originalMeEnergy = self.dataArray[1]
        originalOpponentLife = self.dataArray[2]
        originalOpponentEnergy = self.dataArray[3]
        
        refreshInterfaceLabels()
        refreshInterfaceProgressBar(0.9,perOneMeEnergy: 0.8,perOneOpponentLife: 0.7,perOneOpponenEnergy: 0.6)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBtnTapped(sender: AnyObject) {
        var guanyaPartida = "9"

        // Get the tag
        var tag: Int = sender.tag
        
        // Attention! Take care that the tags are between actions number of.
        if (tag >= 0 && tag <= MAX_ACTIONS) {
            // TODO Make a method that check if have the energy required
            println("Action battle sent: \(tag)")
            application.myController.sendMessage(String(tag))
            
            // Receiving the data from server.
            messageReceived = application.myController.readMessage()
            
            // Always receive my data, and then the other player (myLife, myEnergy, hisLife, hisEnergy)
            dataArray = messageReceived.componentsSeparatedByString(",") as! [String]
            
            refreshInterfaceLabels()
            
            println(self.dataArray[0])
            var array1ToFloat:CGFloat = CGFloat((self.dataArray[0] as NSString).floatValue)
            var oginalMeLifeToFloat: CGFloat = CGFloat((originalMeLife as NSString).floatValue)
            
            var array2ToFloat:CGFloat = CGFloat((self.dataArray[1] as NSString).floatValue)
            var oginalMeEnergyToFloat: CGFloat = CGFloat((originalMeEnergy as NSString).floatValue)
            
            var array3ToFloat:CGFloat = CGFloat((self.dataArray[2] as NSString).floatValue)
            var oginalOpponentLifeToFloat: CGFloat = CGFloat((originalOpponentLife as NSString).floatValue)
            
            var array4ToFloat:CGFloat = CGFloat((self.dataArray[3] as NSString).floatValue)
            var oginalOpponentEnergyToFloat: CGFloat = CGFloat((originalOpponentEnergy as NSString).floatValue)
            
            var calcul1 = (array1ToFloat * 100 / oginalMeLifeToFloat)/100
            var calcul2 = (array2ToFloat * 100 / oginalMeEnergyToFloat)/100
            var calcul3 = (array3ToFloat * 100 /  oginalOpponentLifeToFloat)/100
            var calcul4 = (array4ToFloat  * 100 / oginalOpponentEnergyToFloat)/100
                        
            if(calcul2 < 0.8 && calcul2 > 0.4){
                btnUltimate.enabled = false
                btnUltimate.backgroundColor = UIColor.redColor()
                
                btnSpell2.enabled = true
                btnSpell2.backgroundColor = UIColor.greenColor()
                
                btnSpell1.enabled = true
                btnSpell1.backgroundColor = UIColor.greenColor()
            }
            if(calcul2 < 0.4){
                btnUltimate.enabled = false
                btnUltimate.backgroundColor = UIColor.redColor()
                
                btnSpell2.enabled = false
                btnSpell2.backgroundColor = UIColor.redColor()
                
                btnSpell1.enabled = true
                btnSpell1.backgroundColor = UIColor.greenColor()
            }
            if(calcul2 < 0.15){
                btnUltimate.enabled = false
                btnUltimate.backgroundColor = UIColor.redColor()
                
                btnSpell2.enabled = false
                btnSpell2.backgroundColor = UIColor.redColor()
                
                btnSpell1.enabled = false
                btnSpell1.backgroundColor = UIColor.redColor()
            }
            
            self.refreshInterfaceProgressBar(calcul1, perOneMeEnergy: calcul2, perOneOpponentLife: calcul3, perOneOpponenEnergy: calcul4)
            
            if(dataArray.count == 5){
               guanyaPartida = dataArray[4]
            }
            
            if(guanyaPartida == WIN){
                application.showAlertWin(self, titles: "Game WIN!", messages: "")
            }
            if(guanyaPartida == DRAW){
                application.showAlertDraw(self, titles: "Game DRAW!", messages: "")
            }
            if(guanyaPartida == LOSE){
                application.showAlertLoose(self, titles: "Game LOOSE!", messages: "")
            }
        }
    }
    
    func refreshInterfaceLabels() {
        if (self.dataArray != nil) {
            self.lbl_myLife.text = (self.dataArray[0] as NSString).floatValue.description.componentsSeparatedByString(".")[0]+"/" + originalMeLife.componentsSeparatedByString(".")[0]
            self.lbl_myEnergy.text = (self.dataArray[1] as NSString).floatValue.description.componentsSeparatedByString(".")[0]+"/" + originalMeEnergy.componentsSeparatedByString(".")[0]
            self.lbl_hisLife.text = (self.dataArray[2] as NSString).floatValue.description.componentsSeparatedByString(".")[0]+"/" + originalOpponentLife.componentsSeparatedByString(".")[0]
            self.lbl_hisEnergy.text = (self.dataArray[3] as NSString).floatValue.description.componentsSeparatedByString(".")[0]+"/" + originalOpponentEnergy.componentsSeparatedByString(".")[0]
        }
    }
    
    func refreshInterfaceProgressBar(perOneMeLife:CGFloat, perOneMeEnergy:CGFloat, perOneOpponentLife:CGFloat, perOneOpponenEnergy:CGFloat){

        meLife.frame = CGRectMake(meLife.frame.minX, meLife.frame.minY, meLife.frame.width*perOneMeLife, meLife.frame.height)
        meEnergy.frame = CGRectMake(meEnergy.frame.minX, meEnergy.frame.minY, meEnergy.frame.width*perOneMeEnergy, meEnergy.frame.height)
        opponentLife.frame = CGRectMake(opponentLife.frame.minX, opponentLife.frame.minY, opponentLife.frame.width*perOneOpponentLife, opponentLife.frame.height)
        opponentEnergy.frame = CGRectMake(opponentEnergy.frame.minX, opponentEnergy.frame.minY, opponentEnergy.frame.width*perOneOpponenEnergy, opponentEnergy.frame.height)
    }
    
}

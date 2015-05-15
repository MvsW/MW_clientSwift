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
    
    
    var dataArray: [String]!
    var messageReceived: NSString!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        
        /* DESACTIVAT AMB FREE PASS
        messageReceived = application.myController.readMessage()
        dataArray = messageReceived.componentsSeparatedByString(",") as! [String]
        
        refreshInterfaceLabels()*/
        
       self.refreshInterfaceProgressBar(0.9, perOneMeEnergy: 0.8, perOneOpponentLife: 0.7, perOneOpponenEnergy: 0.6)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBtnTapped(sender: AnyObject) {
        
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
        }
    }
    
    func refreshInterfaceLabels() {
        if (self.dataArray != nil) {
            self.lbl_myLife.text = self.dataArray[0]
            self.lbl_myEnergy.text = self.dataArray[1]
            self.lbl_hisLife.text = self.dataArray[2]
            self.lbl_hisEnergy.text = self.dataArray[3]
        }
    }
    
    func refreshInterfaceProgressBar(perOneMeLife:CGFloat, perOneMeEnergy:CGFloat, perOneOpponentLife:CGFloat, perOneOpponenEnergy:CGFloat){
        meLife.frame = CGRectMake(119, 106, 135*perOneMeLife, 25)
        meEnergy.frame = CGRectMake(119, 155, 135*perOneMeEnergy, 25)
        opponentLife.frame = CGRectMake(119, 256, 135*perOneOpponentLife, 25)
        opponentEnergy.frame = CGRectMake(119, 302, 135*perOneOpponenEnergy, 25)
    }
}

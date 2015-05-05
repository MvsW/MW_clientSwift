//
//  VCMy_data.swift
//  MW_clientSwiftDesign
//
//  Created by Black Castle on 15/2/15.
//  Copyright (c) 2015 MW. All rights reserved.
//

import UIKit

class VCMy_data: UIViewController {
    @IBOutlet weak var lblTypeCharacter: UILabel!
    @IBOutlet weak var lblCharacterName: UILabel!
    @IBOutlet weak var lblLife: UILabel!
    @IBOutlet weak var lblEnergy: UILabel!
    @IBOutlet weak var lblRegeneration: UILabel!
    @IBOutlet weak var lblStrength: UILabel!
    @IBOutlet weak var lblIntelligence: UILabel!
    @IBOutlet weak var lblDateRegister: UILabel!
    @IBOutlet weak var lblTotalPoints: UILabel!
    @IBOutlet weak var lblTotalWins: UILabel!
    @IBOutlet weak var imgIconPlayer: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)

        
        //Llegim la informació del servidor
        var info:String = application.myController.readMessage() as String
        var dates = info.componentsSeparatedByString(",")
        
        var playerName = dates[0]
        var classType = dates[1]
        var life = dates[2]
        var energy = dates[3]
        var regeneration = dates[4]
        var strength = dates[5]
        var intelligence = dates[6]
        var currentPoints = dates[7]
        var wonGames = dates[8]
        var date = dates[9]
        
        println("Player name: " + playerName)
        println("Class type: " + classType)
        println("Life: " + life)
        println("Energy: " + energy)
        println("Regeneration: " + regeneration)
        println("Strength: " + strength)
        println("Intelligence: " + intelligence)
        println("Current points: " + currentPoints)
        println("Won games: " + wonGames)
        println("date: " + date)
        
        lblCharacterName.text = playerName
        lblDateRegister.text = application.getData(date)
        lblEnergy.text = energy
        lblIntelligence.text = intelligence
        lblLife.text = life
        lblRegeneration.text = regeneration
        lblStrength.text = strength
        lblTotalPoints.text = currentPoints
        lblTotalWins.text = wonGames
        if(classType == MAGE.description){
            lblTypeCharacter.text = "MAGE"
            imgIconPlayer.image = UIImage(named: "mage.png")
        }else{
            lblTypeCharacter.text = "WARLOCK"
            imgIconPlayer.image = UIImage(named: "warlock.png")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

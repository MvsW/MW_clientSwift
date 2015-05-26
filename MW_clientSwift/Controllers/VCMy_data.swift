//
//  VCMy_data.swift
//  MW_clientSwiftDesign
//
//  Created by Black Castle on 15/2/15.
//  Copyright (c) 2015 MW. All rights reserved.
//

import UIKit

class VCMy_data: UIViewController {
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

        // Put the backround image
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)

        
        // Reading the server
        var info: String = application.myController.readMessage() as String
        
        var dates = info.componentsSeparatedByString(SEPARATOR)

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
            imgIconPlayer.image = UIImage(named: "mage.png")
            lblCharacterName.textColor = UIColor(red: 31/255, green: 0/255, blue: 186/255, alpha: 1)
            
        }else{
            imgIconPlayer.image = UIImage(named: "warlock.png")
            lblCharacterName.textColor = UIColor(red: 151/255, green: 7/255, blue: 25/255, alpha: 1)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneTapped(sender: UIButton) {
        self.performSegueWithIdentifier("goto_menu", sender: self)

    }

}

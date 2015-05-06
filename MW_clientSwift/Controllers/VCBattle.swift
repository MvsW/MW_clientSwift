//
//  VCBattle.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCBattle: UIViewController {
    
    /*
        TODO: implementar tots els tappeds de buttons
    */
    @IBOutlet weak var btnShield: UIButton!
    @IBOutlet weak var btnSpecialSpell: UIButton!
    @IBOutlet weak var btnSpell1: UIButton!
    @IBOutlet weak var btnDodge: UIButton!
    @IBOutlet weak var btnSpell2: UIButton!
    @IBOutlet weak var btnBasicAttack: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        println("Welcome to fisrt battle protocol by RO")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func actionButtonTapped(sender: UIButton) {
        
        //var title: String = sender.titleLabel!.text!
        var tag: Int = sender.tag
        
        // ATTENTION! Be sure that this method only receives battle action buttons
        if (tag >= 0 && tag <= MAX_ACTIONS) {
            // TODO Make a method that check if have the energy required
            application.myController.sendMessage(String(tag))
            println("Action battle sent: \(tag)")
        }
        
    }
}

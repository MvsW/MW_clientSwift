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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        if (tag >= 0 && tag <= battleAction.count) {
            // TODO Make a method that check if have the energy required
            application.myController.sendMessage(battleAction[tag])
            println("Action battle sent: \(battleAction[tag])")
        }
        
    }
}

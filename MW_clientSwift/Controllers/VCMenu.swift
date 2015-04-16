//
//  VCMenu.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCMenu: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func battleTapped(sender: UIButton) {
        if(true){
            application.myController.sendMessage(START_BATTLE)
            self.performSegueWithIdentifier("got_searching", sender: self)
        }
        
    }
    
    @IBAction func myDataTapped(sender: UIButton) {
        if(true){
            application.myController.sendMessage(SHOW_DATA)
            self.performSegueWithIdentifier("goto_my_data", sender: self)
        }
        
    }

}

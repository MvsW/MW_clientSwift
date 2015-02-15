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
        //Checkejar els camps, si son correctes enviar al servidor i espera resposta
        //Si el server diu OK pasem a menu
        if(false){
            self.performSegueWithIdentifier("got_searching", sender: self)
        }
        
    }
    
    @IBAction func myDataTapped(sender: UIButton) {
        //Checkejar els camps, si son correctes enviar al servidor i espera resposta
        //Si el server diu OK pasem a menu
        if(true){
            self.performSegueWithIdentifier("goto_my_data", sender: self)
        }
        
    }

}

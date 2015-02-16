//
//  VCLogin.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit
import Foundation
import CFNetwork
import CoreLocation

class VCLogin: UIViewController {
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var txtUserOrMail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        application.myController.connect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func loginTapped(sender: UIButton) {
        // Checkejar els camps, si son correctes enviar al servidor i espera resposta
        if (!txtUserOrMail.text.isEmpty && !txtPassword.text.isEmpty){
            application.myController.sendMessage("ro,User1994,0,0")
            // Si el server diu OK pasem a menu
            if (application.myController.readMessage() == SUCCES){
                self.performSegueWithIdentifier("goto_menu", sender: self)
            }
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    @IBAction func registerTapped(sender: UIButton) {
        //Enviar al servidor que volem registrarnos.
        if (true){
            self.performSegueWithIdentifier("goto_register", sender: self)
        }
        
    }
    
}

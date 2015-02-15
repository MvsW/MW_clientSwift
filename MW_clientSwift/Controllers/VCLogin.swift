//
//  VCLogin.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCLogin: UIViewController {
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var txtUserOrMail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func loginTapped(sender: UIButton) {
        //Checkejar els camps, si son correctes enviar al servidor i espera resposta
        //Si el server diu OK pasem a menu
        if(!txtUserOrMail.text.isEmpty && !txtPassword.text.isEmpty){
            self.performSegueWithIdentifier("goto_menu", sender: self)
        }
        
    }

    @IBAction func registerTapped(sender: UIButton) {
        //Enviar al servidor que volem registrarnos.
        if(true){
            self.performSegueWithIdentifier("goto_register", sender: self)
        }
        
    }
    
}

//
//  VCRegister.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCRegister: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtMail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerTapped(sender: UIButton) {
        //Validar camps i enviar al servidor 
        let validarMail: Bool = application.isValidEmail(txtMail.text)
        let validarPassword: Bool = application.isValidPassword(txtPassword.text)
        let validarUsuari: Bool = application.validateUserName(txtUserName.text)
        println("Mail: " + validarMail.description)
        println("Password: " + validarPassword.description)
        println("Usuari: " + validarUsuari.description)
        println("-------------")
        if(validarMail && validarPassword && validarUsuari && txtPassword.text == txtConfirmPassword.text){
            
            var register_player: VCRegister_player = self.storyboard?.instantiateViewControllerWithIdentifier("VRegisterCharacter") as VCRegister_player
            register_player.userName = txtUserName.text
            register_player.userMail = txtMail.text
            register_player.userPassword = txtUserName.text
            self.presentViewController(register_player, animated: true, completion: nil)

            //self.performSegueWithIdentifier("goto_register_player", sender: self)
        }
    }
}

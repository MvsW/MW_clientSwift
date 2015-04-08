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
        
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        // POSAR COLOR PLACEHOLDER
        let attributesDictionary = [NSForegroundColorAttributeName: UIColor.grayColor()]
        txtUserName.attributedPlaceholder = NSAttributedString(string: "User or Email", attributes: attributesDictionary)
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Choose the password", attributes: attributesDictionary)
        txtMail.attributedPlaceholder = NSAttributedString(string: "Type the real email", attributes: attributesDictionary)
        txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Repeat this password", attributes: attributesDictionary)
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
    @IBAction func clicUserName(sender: UITextField) {
        txtUserName.background = UIImage(named: "focus.png")
        txtMail.background = UIImage(named: "no_focus.png")
        txtPassword.background = UIImage(named: "no_focus.png")
        txtConfirmPassword.background = UIImage(named: "no_focus.png")
    }
    @IBAction func clicEmail(sender: UITextField) {
        txtUserName.background = UIImage(named: "no_focus.png")
        txtMail.background = UIImage(named: "focus.png")
        txtPassword.background = UIImage(named: "no_focus.png")
        txtConfirmPassword.background = UIImage(named: "no_focus.png")
    }
    @IBAction func clicPassword(sender: UITextField) {
        txtUserName.background = UIImage(named: "no_focus.png")
        txtMail.background = UIImage(named: "no_focus.png")
        txtPassword.background = UIImage(named: "focus.png")
        txtConfirmPassword.background = UIImage(named: "no_focus.png")
    }
    @IBAction func clicConfirmPassword(sender: UITextField) {
        txtUserName.background = UIImage(named: "no_focus.png")
        txtMail.background = UIImage(named: "no_focus.png")
        txtPassword.background = UIImage(named: "no_focus.png")
        txtConfirmPassword.background = UIImage(named: "focus.png")
    }
}

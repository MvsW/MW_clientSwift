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
        
        // TODO Mirar d'enviar la password xifrada (md5)
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
        
        // POSAR COLOR PLACEHOLDER
        let attributesDictionary = [NSForegroundColorAttributeName: UIColor.grayColor()]
        txtUserName.attributedPlaceholder = NSAttributedString(string: "User or Email", attributes: attributesDictionary)
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Choose the password", attributes: attributesDictionary)
        txtMail.attributedPlaceholder = NSAttributedString(string: "Type a real email", attributes: attributesDictionary)
        txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Repeat the password", attributes: attributesDictionary)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTapped(sender: UIButton) {
        application.myController.sendMessage(CANCEL)
        self.performSegueWithIdentifier("goto_login", sender: self)
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
        //Modificar per varis if on si hi ha un error el bolean pasara a true/false i refrescar pantalla
        if(validarMail && validarPassword && validarUsuari && txtPassword.text == txtConfirmPassword.text){
            
            
            /*
            //Deprecated
            var register_player: VCRegister_player = self.storyboard?.instantiateViewControllerWithIdentifier("VRegisterCharacter") as VCRegister_player
            register_player.userName = txtUserName.text
            register_player.userMail = txtMail.text
            register_player.userPassword = txtUserName.text
            self.presentViewController(register_player, animated: true, completion: nil)
            //No cal enviar les dades a la següent View Controler
            */
            
            /*
            Que enviar al servidor?? per saber si el nom de usuari o mail ja existeixen???
            String username, String email, String password, int status
            
            */
            application.myController.sendMessage(txtUserName.text.lowercaseString + "," + txtMail.text.lowercaseString + "," + txtPassword.text)
            // Si el server diu OK pasem a menu
            var serverResponse = application.myController.readMessage()
            var serverResponseSplit = serverResponse.componentsSeparatedByString(SEPARATOR)
            
            if (serverResponseSplit[0] as! String == SUCCES){
                self.performSegueWithIdentifier("goto_register_player", sender: self)
            }
            else{
                println("Camps no validats")
                //notificar el resultat del server
                //Cal implementar metodes per fer com els setErrors de android i mostra el error que toca
                //ERRORS via servidor
                var errorsMessage = ""
                for(var i = 0; i<serverResponseSplit.count; i++){
                    println((application.getErrorName(serverResponseSplit[i] as! String)))
                    errorsMessage = errorsMessage + application.getErrorName(serverResponseSplit[i] as! String) + ". \n"
                }
                application.showAlert(self, titles: "ERROR!", messages: errorsMessage)
            }
            
        }
        else{
            //Implementar mostrar per pantalla errors de control LOCAL
            application.showAlert(self, titles: "ERROR!", messages: "Mail: " + application.getErrorTrueFalse(validarMail) + ". \n" + "Password: " + application.getErrorTrueFalse(validarPassword) + ". \n" + "Usuari: " + application.getErrorTrueFalse(validarUsuari) + ".")
            
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var lblUserNameCounter: UILabel!
    @IBAction func editingUserName(sender: UITextField) {
        if(count(txtUserName.text) <= 12){
            lblUserNameCounter.text = String(12 - count(txtUserName.text))
        }else{
            var contador = 0
            var textFinal = ""
            for character in txtUserName.text{
                contador++
                textFinal = textFinal + String(character)
                if(contador == 12){
                    txtUserName.text = textFinal
                }
            }
        }
    }
    
    @IBOutlet weak var lblEmailCounter: UILabel!
    @IBAction func editingEmail(sender: UITextField) {
        if(count(txtMail.text) <= 50){
            lblEmailCounter.text = String(50 - count(txtMail.text))
        }else{
            var contador = 0
            var textFinal = ""
            for character in txtMail.text{
                contador++
                textFinal = textFinal + String(character)
                if(contador == 50){
                    txtMail.text = textFinal
                }
            }
        }
    }
    
    @IBOutlet weak var lblPassword1Counter: UILabel!
    @IBAction func editingPassword1(sender: UITextField) {
        if(count(txtPassword.text) <= 20){
            lblPassword1Counter.text = String(20 - count(txtPassword.text))
        }else{
            var contador = 0
            var textFinal = ""
            for character in txtPassword.text{
                contador++
                textFinal = textFinal + String(character)
                if(contador == 20){
                    txtPassword.text = textFinal
                }
            }
        }    }
    
    @IBOutlet weak var lblPassword2Counter: UILabel!
    @IBAction func editingPassword2(sender: UITextField) {
        if(count(txtConfirmPassword.text) <= 20){
            lblPassword2Counter.text = String(20 - count(txtConfirmPassword.text))
        }else{
            var contador = 0
            var textFinal = ""
            for character in txtConfirmPassword.text{
                contador++
                textFinal = textFinal + String(character)
                if(contador == 20){
                    txtConfirmPassword.text = textFinal
                }
            }
        }
    }
    
    
}

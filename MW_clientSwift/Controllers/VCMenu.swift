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
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func battleTapped(sender: UIButton) {
        if(application.comprovarConexion()){
            self.performSegueWithIdentifier("goto_searching", sender: self)
        }else{
            application.noConnectionAlertAndGoToLogin(self)
        }
        
    }
    
    @IBAction func myDataTapped(sender: UIButton) {
        if(application.comprovarConexion()){
            application.myController.sendMessage(SHOW_DATA)
            self.performSegueWithIdentifier("goto_my_data", sender: self)
        }else{
            application.noConnectionAlertAndGoToLogin(self)
        }
    }
}

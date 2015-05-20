//
//  VCSearchBattle.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCSearchBattle: UIViewController {
    var views: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // POSAR IMATGE FONS ADAPTADA A LA PANTALLA
        var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
        var imageObbj:UIImage! = application.imageResize(UIImage(named: "login_background.png")!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
        self.view.backgroundColor = UIColor(patternImage:imageObbj!)

        // Do any additional setup after loading the view, typically from a nib.
        application.myController.sendMessage(START_BATTLE)
        setUp()
        //START LOADING AND STOP THESE
         views = application.myController.startLoading(self.view, text: "Loading...", size2: 12.5,viewController: self,areInBattle: true)
        /*application.stopLoading(views)*/
    }
    
    func setUp(){
        var waitting = true
        dispatch_async(dispatch_get_global_queue(
            Int(QOS_CLASS_UTILITY.value), 0)) {
                while(waitting){
                    var areReady = application.myController.readMessage()
                    if (areReady == SUCCES){
                        waitting = false
                        // Recently added. Trying to fix the lag of loading UI
                        dispatch_async(dispatch_get_main_queue()) {
                            application.myController.stopLoading(self.views)
                            self.performSegueWithIdentifier("goto_battle", sender: self)
                        }
                    }else{
                        application.myController.sendMessage("xxx")
                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

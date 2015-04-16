//
//  VCSearchBattle.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCSearchBattle: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        application.myController.sendMessage(START_BATTLE)
        setUp()
        
    }
    
    func setUp(){
        
        
        dispatch_async(dispatch_get_global_queue(
            Int(QOS_CLASS_UTILITY.value), 0)) {
                
                NSLog("First Log")
                if(application.myController.readMessage() == SUCCES){
                    self.performSegueWithIdentifier("goto_battle", sender: self)
                }
                
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

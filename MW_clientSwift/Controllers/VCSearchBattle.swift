//
//  VCSearchBattle.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCSearchBattle: UIViewController {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        application.myController.sendMessage(START_BATTLE)
        setUp()
        loader.startAnimating()
    }
    
    func setUp(){
        
        dispatch_async(dispatch_get_global_queue(
            Int(QOS_CLASS_UTILITY.value), 0)) {
                if (application.myController.readMessage() == SUCCES){
                    // Recently added. Trying to fix the lag of loading UI
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("goto_battle", sender: self)
                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

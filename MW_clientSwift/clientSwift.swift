//
//  clientSwift.swift
//  MW_clientSwift
//
//  Created by Black Castle on 22/1/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit
import Foundation;
import Dispatch;
import CFNetwork;



let addr = "127.0.0.1"
let port = 2000

var buffer = [UInt8](count: 255, repeatedValue: 0)

var inp : NSInputStream?
var out : NSOutputStream?




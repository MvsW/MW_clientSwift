//
//  CConstants.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import Foundation


var serverAddress: CFString = "192.168.1.13"
let serverPort: UInt32 = 4444

var application = CApp()

// enumeracio ???
let SUCCES = "99"
let ERROR = "100"
let REGISTER = "register" // valor per enviar al servidor i entrar en el fil de registre


// Op menu TYPES aqui o a CMenu??
let SHOW_DATA = "showData";
let START_BATTLE = "startBattle";
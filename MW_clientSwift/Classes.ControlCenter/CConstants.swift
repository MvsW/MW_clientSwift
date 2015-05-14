//
//  CConstants.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import Foundation


var serverAddress: CFString = "kintoncloud.com"
//var serverAddress: CFString = "192.168.1.11"
//var serverAddress: CFString = "172.16.253.63"
//let serverPort: UInt32 = 49157
let serverPort: UInt32 = 4444

var application = CApp()
let SEPARATOR = ","

// CONSTANTS ERRORS
let NO_SERVER = "NO_SERVER"
let SUCCES = "0"
let ERROR = "100"
// LOGIN
let ERROR_UserAlreadyLogged = "101"
let ERROR_PasswordIncorrect = "102"
let ERROR_EmailNotExist = "103"
let ERROR_UserNotExist = "104"
//RESISTER
let ERROR_UserExist = "110"
let ERROR_emailExist = "111"
let ERROR_PlayerNameExist = "112"

// CONSTANTS FIL
let REGISTER = "register" // valor per enviar al servidor i entrar en el fil de registre
let MAX_UNASIGNED_POINTS: Int = 14


// Op menu TYPES aqui o a CMenu??
let SHOW_DATA = "showData"
let START_BATTLE = "startBattle"

// CONSTANTS CLASS TYPES
let MAGE = 1
let WARLOCK = 2

// BATTLE ACTIONS ARRAY
let MAX_ACTIONS = 6


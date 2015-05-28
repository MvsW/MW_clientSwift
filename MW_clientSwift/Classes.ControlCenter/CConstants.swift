//
//  CConstants.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import Foundation

var test = "*"

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


// Op menu TYPES aqui o a CMenu??
let SHOW_DATA = "showData"
let START_BATTLE = "startBattle"
let CANCEL = "cancel";

// CONSTANTS CLASS TYPES
let MAGE = 1
let WARLOCK = 2

// BATTLE ACTIONS ARRAY
let MAX_ACTIONS = 6
let WIN = "10"
let LOSE = "1"
let DRAW = "11"


// CREATE PLAYER CONSTANTS
let TOTAL_POINTS: Double = 200
let TOTAL_BASE_LIFE: Double = 200
let BASE_PERCENT: Double = 0.76
let RAND_PERCENT: Double = 0.04
let CUSTOM_PERCENT: Double = 0.2
let LIFE_INTEL_PERCENT: Double = 0.7
let REGEN_ENERGY_BASE_PERCENT: Double = 0.1

let ENERGY_COST_ULTIMATE = 0.89
let ENERGY_COST_SPELL2 = 0.34
let ENERGY_COST_SPELL1 = 0.21

//Calcs
let BASE_CALC: Int = Int(TOTAL_POINTS * BASE_PERCENT)
let RAND_CALC: Int = Int(TOTAL_POINTS * RAND_PERCENT)
let CUSTOM_CALC: Int = Int(TOTAL_POINTS * CUSTOM_PERCENT)

var freePass = false


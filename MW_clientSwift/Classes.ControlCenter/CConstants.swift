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

// NSUSERDEFAULTS
var NSDefaultUsernameOrEmail = ""


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

// Titles and actions descriptions
    let NAME_BASIC = "Basic Attack"
    let TEXT_BASIC = "No energy consumption damages the opponent based on your strength."
    
    let NAME_SPELL1 = "Spell 1"
    let TEXT_SPELL1 = "In exchange for a small amount of power you damage your opponent depending on your intelligence."
    
    let NAME_SPELL2 = "Spell 2"
    let TEXT_SPELL2 = "Cause considerable damage to the enemy according to your intelligence and your strength half."
    
    let NAME_ULTIMATE = "Ultimate Spell"
    let TEXT_ULTIMATE = "In exchange for almost all your energy you can exercise more than considerable damage on your opponent. This spell takes into account both your strengths as intelligence."
    
    let NAME_SHIELD = "Shield"
    let TEXT_SHIELD = "It allows you to reduce all or part of the damage taken according to your strengths."
    
    let NAME_DODGE = "Dodge"
    let TEXT_DODGE = "Depending on your intelligence you have the possibility to avoid all or part of the damage taken."





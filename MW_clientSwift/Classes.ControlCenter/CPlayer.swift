//
//  CPlayer.swift
//  MW_clientSwift
//
//  Created by Ferran Olivella on 21/4/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import Foundation


class CPlayer {
    
    /**
    * ATTRIBUTES
    */
    
    
    //
    var spells: [CSpell]!
    
    // call to static class for assign 0 or 1 (mage or warlock)
    var playerID: Int!
    var playerName: String!
    var classType: Int!
    var life: Double!
    var energy: Double?
    var energyRegen: Double!
    var strength: Double!
    var intelligence: Double!
    var totalPoints: Int!
    var wonGames: Int!
    var data: String!
    
    init(playerName: String, classType: Int, life: Double, energy: Double, energyRegen: Double, strength: Double, intelligence: Double, totalPoints: Int, wonGames: Int, data: String) {
        self.playerName = playerName
        self.classType = classType
        self.life = life
        self.energy = energy
        self.energyRegen = energyRegen
        self.strength = strength
        self.intelligence = intelligence
        self.totalPoints = totalPoints
        self.wonGames = wonGames
        self.data = data
    }
    
    init(playerName: String, classType: Int, life: Double, energy: Double, energyRegen: Double, strength: Double, intelligence: Double, totalPoints: Int, wonGames: Int) {
        self.playerName = playerName
        self.classType = classType
        self.life = life
        self.energy = energy
        self.energyRegen = energyRegen
        self.strength = strength
        self.intelligence = intelligence
        self.totalPoints = totalPoints
        self.wonGames = wonGames
    }
    
    
    init(playerName:String, classType: Int, life: Double, energy: Double, totalPoints: Int) {
        self.playerName = playerName
        self.classType = classType
        self.life = life
        self.energy = energy
        self.totalPoints = totalPoints
    }
    
    
}
//
//  CSpell.swift
//  MW_clientSwift
//
//  Created by Ferran Olivella on 21/4/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import Foundation


class CSpell {
    
    var name: String!
    var probability: Int!
    var energyCost: Int!
    var type: Int! // call static clas CTYPE (0/1 = offensive/defensive)
    
    
    init(name: String, probability: Int, energyCost: Int, type: Int) {
        self.name = name
        self.probability = probability
        self.energyCost = energyCost
        self.type = type
    }
    
}
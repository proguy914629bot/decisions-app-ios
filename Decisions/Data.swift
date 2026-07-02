//
//  Data.swift
//  Decisions
//
//  Created by Mac on 01/07/26.
//

import Foundation
import SwiftData

@Model
class Option: Identifiable {
    
    var name: String
    var pros: [String]
    var cons: [String]
    
    init(name: String, pros: [String], cons: [String]) {
        self.name = name
        self.pros = pros
        self.cons = cons
    }
    
}


@Model
class DecisionData: Identifiable {
    
    var name: String
    var options: [Option]
    var decided: Bool = false
    
    var decidedOption : Option? = nil
    
    init(name: String, options: [Option], decided: Bool = false, decidedOption: Option? = nil) {
        self.name = name
        self.options = options
        self.decided = decided
        
        self.decidedOption = decidedOption
    }
    
}

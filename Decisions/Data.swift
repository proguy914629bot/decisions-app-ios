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
    
    var id: UUID = UUID()
    var name: String
    var pros: [String]
    var cons: [String]
    
    init(id: UUID = UUID(), name: String, pros: [String], cons: [String]) {
        self.id = id
        self.name = name
        self.pros = pros
        self.cons = cons
    }
    
}


@Model
class DecisionData: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var options: [Option]
    var decided: Bool = false
    
    var decidedOption : Option? = nil
    
    init(id: UUID = UUID(), name: String, options: [Option], decided: Bool = false, decidedOption: Option? = nil) {
        self.id = id
        self.name = name
        self.options = options
        self.decided = decided
        
        self.decidedOption = decidedOption
    }
    
}

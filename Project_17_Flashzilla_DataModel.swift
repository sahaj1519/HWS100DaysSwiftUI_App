//
//  Project_17_Flashzilla_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 21/03/25.
//

import SwiftUI


struct Project_17_Flashzilla_DataModel: Codable{
    var id: UUID
    var prompt: String
    var answer: String
    
    
    static let example = Project_17_Flashzilla_DataModel(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

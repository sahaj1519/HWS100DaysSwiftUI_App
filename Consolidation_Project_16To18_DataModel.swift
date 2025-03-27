//
//  Consolidation_Project_16To18_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 22/03/25.
//
import SwiftData
import SwiftUI

@Model
class Consolidation_Project_16To18_DataModel{
    
    var id = UUID()
      var sideInDice: Int
      var rolledNumber: Int
      var date: Date
      
    init(id: UUID = UUID(), sideInDice: Int, rolledNumber: Int, date: Date) {
        self.id = id
        self.sideInDice = sideInDice
        self.rolledNumber = rolledNumber
        self.date = date
    }
    
    
}



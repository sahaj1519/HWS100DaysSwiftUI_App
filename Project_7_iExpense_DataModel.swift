//
//  Project_7_iExpense_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//

import SwiftData
import SwiftUI

@Model
class Project_7_iExpense_DataModel {
    // var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
      //  self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}


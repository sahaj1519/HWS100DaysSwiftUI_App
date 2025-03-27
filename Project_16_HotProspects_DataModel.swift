//
//  Project_16_HotProspects_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 20/03/25.
//

import SwiftData
import SwiftUI

@Model
class Project_16_HotProspects_DataModel{
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var date: Date?
    
    init(name: String, emailAddress: String, isContacted: Bool, date: Date? = nil) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.date = date
    }
}

//
//  Consolidation_Project_10To12_DataModelUser.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//


import SwiftData
import SwiftUI


@Model
class Consolidation_Project_10To12_DataModelUser{
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    @Relationship(deleteRule: .cascade) var friends: [Consolidation_Project_10To12_DataModel_Friend]? = []
    
    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Consolidation_Project_10To12_DataModel_Friend]? = nil) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
}
    
    
    



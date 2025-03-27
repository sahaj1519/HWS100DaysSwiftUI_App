//
//  Consolidation_Project_10To12_DataModel_Friend.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//
import SwiftData
import SwiftUI


@Model
class Consolidation_Project_10To12_DataModel_Friend{
    
    var id: UUID
    var name: String
  // @Relationship(inverse: \Consolidation_Project_10To12_DataModelUser.friends)
        var owner: Consolidation_Project_10To12_DataModelUser?
   
   
    init(id: UUID, name: String, owner: Consolidation_Project_10To12_DataModelUser? = nil) {
        self.id = id
        self.name = name
        self.owner = owner
    }
}
    
    
    


//
//  Consolidation_Project_10To12_StructureModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//

import SwiftUI

struct UserCodable: Codable{
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
    var friends: [FriendCodable]
    
}

struct FriendCodable: Codable{
    var id: UUID
    var name: String
    
}

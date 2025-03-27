//
//  Project_8_MoonShot_Mission.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 09/03/25.
//

import SwiftUI

struct Project_8_MoonShot_Mission: Codable, Identifiable, Hashable{
    
    struct CrewRole: Codable, Hashable{
        let name: String
        let role: String
    }
    
   let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String{
        "Apollo \(id)"
    }
    var image: String{
        "apollo\(id)"
    }
    var formattedDate: String{
        launchDate?.formatted(date: .abbreviated , time: .omitted) ?? "N/A"
    }
    
}

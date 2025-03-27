//
//  Project_12_SwiftDataProject_Job.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//
import SwiftData
import SwiftUI

@Model
class Project_12_SwiftDataProject_Job{
    var name: String = "none"
    var priority: Int = 1
    var owner: Project_12_SwiftdataProject_DataModel?
    
    init(name: String, priority: Int, owner: Project_12_SwiftdataProject_DataModel? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
    
}

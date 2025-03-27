//
//  Project_12_SwiftdataProject_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 14/03/25.
//
import SwiftData
import SwiftUI


@Model
class Project_12_SwiftdataProject_DataModel{
    var name: String = "Anonymous"  // default values//for cloudKit we have to make all peroperty in database have value either default or initial
    var city: String = "Unknown"
    var joinDate: Date = Date.now
    
    @Relationship(deleteRule: .cascade) var jobArray: [Project_12_SwiftDataProject_Job]? = [Project_12_SwiftDataProject_Job]()
    
    var unwrappedJobs: [Project_12_SwiftDataProject_Job]{  //doing for better code looking 
        jobArray ?? []
    }
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

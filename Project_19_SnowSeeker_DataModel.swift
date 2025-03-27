//
//  Project_19_SnowSeeker_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 23/03/25.
//

import SwiftUI

struct Project_19_SnowSeeker_DataModel: Codable, Hashable, Identifiable{
    
        var id: String
        var name: String
        var country: String
        var description: String
        var imageCredit: String
        var price: Int
        var size: Int
        var snowDepth: Int
        var elevation: Int
        var runs: Int
        var facilities: [String]
    
    var facilityType: [Project_19_SnowSeeker_Facility_Model]{
        facilities.map(Project_19_SnowSeeker_Facility_Model.init)
    }
    
    static let result: [Project_19_SnowSeeker_DataModel] = Bundle.main.decodeFile("resorts.json")
    static let example = result[0]
    
}

//
//  Project_14_BucketList_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 17/03/25.
//
import MapKit
import SwiftUI

struct Project_14_BucketList_DataModel: Codable, Identifiable, Equatable{
    
    var id: UUID
    var locationName: String
    var locationDescription: String
    var latitude: Double
    var longitude: Double
    
    var locationCoordinates: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
#if DEBUG
   static let example = Project_14_BucketList_DataModel(id: UUID(), locationName: "Buckingham Palace", locationDescription: "lit by over 40000 lightbulbs", latitude: 51.501, longitude: -0.141)
#endif
    
    static func ==(lhs: Project_14_BucketList_DataModel, rhs: Project_14_BucketList_DataModel) -> Bool {
        lhs.id == rhs.id
    }
    
    
}

//
//  Consolidation_Project_13To15_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 18/03/25.
//
import CoreLocation
import SwiftUI



@Observable
class Consolidation_Project_13To15_DataModel{
   
    var realData: [RealData]
    
    let savePath = URL.documentsDirectory.appending(path: "PersonNameWithPhoto")
    
    init(){
        do{
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([RealData].self, from: data)
        
            realData = decoded.sorted()
            
        }catch{
           realData = []
        }
        
    }
    
    
    func save(){      // encoding data
       
        do{
            let encoded = try JSONEncoder().encode(realData)
            try encoded.write(to: savePath)
            
        }catch{
            print("failed to save data \(error.localizedDescription)")
        }
        
    }
    
    
    func resetData() {
        realData.removeAll()  // Clear the array
        save()  // Save the empty array to storage
        print("Data reset successfully!")
    }
    
    func returnPosition(id: UUID) -> CLLocationCoordinate2D {
        for item in realData {
            if item.id == id {
                 let position = item.location.coordinate
                    return position
                
            }
        }
        
        // ✅ Return a default location if no match is found
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
}

struct RealData: Codable, Comparable, Identifiable, Hashable{
    var id = UUID()
    var photo: Data
    var personName: String
    var location: CodableCoordinate
    
    
    static func <(lhs: RealData, rhs: RealData ) -> Bool{
        lhs.personName < rhs.personName
    }
}

struct CodableCoordinate: Codable, Hashable{
    
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    init(from coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    init(latitude: Double, longitude: Double) {
           self.latitude = latitude
           self.longitude = longitude
       }
    
}

//
//  Project_14_BucketList_MVVM.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 17/03/25.
//
import LocalAuthentication
import CoreLocation
import MapKit
import SwiftUI

extension Project_14_BucketList{
    
    @Observable
    class ViewModel{
        
      private(set)  var  locationArray: [Project_14_BucketList_DataModel]
      var  longPressLocation: Project_14_BucketList_DataModel?
        var isUnlocked = false
       var isAlert = false
        let savePath = URL.documentsDirectory.appending(path: "savedLocations") // location in location array stored at here
        
        var whichMapView: String = "Standard"
        let whichMapViewArray: [String: MapStyle] = [
            "Standard": .standard,
            "Hybrid": .hybrid,
            "Imagery": .imagery
        ]
        
        init(){
              
            do{
                let data = try Data(contentsOf: savePath)
                let decoded =  try JSONDecoder().decode([Project_14_BucketList_DataModel].self, from: data)
                locationArray = decoded
        
               
            }catch{
                locationArray = []
            }
            
        }
      func authenticate(){
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                let reason = "Please authenticate yourself to unlock your places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){success, authenticationError in
                    
                    if success{
                        self.isUnlocked = true
                    }else{
                        self.isAlert = true
                        
                    }
                    
                }
            }else{
                // no biometrics
            }
        }
        
        func save(){
           // locationArray.removeAll()
            do{
                let encoded = try JSONEncoder().encode(locationArray)
                try  encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
            }catch{
                print("Unable to save data \(error.localizedDescription)")
            }
        }
        
        func addLocation( location: CLLocationCoordinate2D){
            let newLocation = Project_14_BucketList_DataModel(id: UUID(), locationName: " My New Location ", locationDescription: "", latitude: location.latitude, longitude: location.longitude)
            
            locationArray.append(newLocation)
            save()
        }
        
        func updateLocation(at location: Project_14_BucketList_DataModel){
            guard let longPressLocation else{ return}
            if let index = locationArray.firstIndex(of: longPressLocation){
                   locationArray[index] = location
                  save()
            }
        }
        
    }
}
